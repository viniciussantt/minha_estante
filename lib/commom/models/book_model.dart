import 'dart:convert';

import 'package:html/parser.dart' as htmlParser;
import 'package:minha_estante/commom/constants/app_error.dart';
import 'package:minha_estante/commom/constants/book_reading_status.dart';

class BookModel {
  final String id; // ID único do livro
  final String titulo; // Título do livro
  final String autor; // Autor do livro
  final int qtdPaginas; // Número de páginas do livro
  final String descricao; // Descrição do livro
  final String imageUrl; // URL da imagem do livro
  final String textSnippet; //
  final String genero;
  final String statusLeitura; // Status de leitura do livro
  final int pgLidas;
  final int nota;

  BookModel({
    required this.id,
    required this.titulo,
    this.autor = AppError.unknownAuthor,
    required this.qtdPaginas,
    required this.descricao,
    required this.imageUrl,
    this.textSnippet = AppError.unavailableSnippet,
    this.genero = AppError.unknownCategory,
    required this.statusLeitura,
    required this.pgLidas,
    required this.nota,
  });

  // Converte o objeto BookModel em um mapa
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'autor': autor,
      'qtdPaginas': qtdPaginas,
      'descricao': descricao,
      'imageUrl': imageUrl,
      'textSnippet': textSnippet,
      'genero': genero,
      'statusLeitura': statusLeitura,
      'pgLidas': pgLidas,
      'nota': nota,
    };
  }

  // Constrói um objeto BookModel a partir de um mapa
  factory BookModel.fromMap(Map<String, dynamic> map) {
    final volumeInfo = map['volumeInfo'];
    final searchInfo = map['searchInfo'];

    // Função auxiliar para obter o primeiro valor de uma lista, retornando um valor padrão se a lista for nula ou vazia
    String getFirstListValue(List<dynamic>? list, String defaultValue) {
      if (list != null && list.isNotEmpty) {
        return list[0].toString();
      } else {
        return defaultValue;
      }
    }

    final description = volumeInfo['description']; // Obtém a descrição do livro
    // Analisa a descrição como HTML, extrai o texto removendo as tags HTML, e atribui o resultado à variável 'sanitizedDescription'.
    final sanitizedDescription =
        htmlParser.parse(description).body?.text ?? description;

    return BookModel(
      id: map['id'],
      titulo: volumeInfo['title'] ?? AppError.unknownTitle,
      autor: getFirstListValue(volumeInfo['authors'], AppError.unknownAuthor),
      qtdPaginas: volumeInfo['pageCount'] ??
          AppError.unknownPaginas, // Verifica se é nulo e atribui 0 caso seja
      descricao: sanitizedDescription,
      imageUrl: volumeInfo['imageLinks']?['thumbnail'] ??
          AppError.unavailableImageUrl, // Verifica se é nulo e atribui uma string vazia caso seja
      textSnippet: searchInfo != null
          ? searchInfo['textSnippet']
          : AppError.unavailableSnippet,
      genero:
          getFirstListValue(volumeInfo['categories'], AppError.unknownCategory),
      statusLeitura:
          BookReadingStatus.naoLido, // Defina o status de leitura do livro aqui
      pgLidas: BookReadingStatus.pgLidas,
      nota: BookReadingStatus.nota,
    );
  }

  // Converte o objeto BookModel em uma string JSON
  String toJson() => json.encode(toMap());

  // Constrói um objeto BookModel a partir de uma string JSON
  factory BookModel.fromJson(String source) =>
      BookModel.fromMap(json.decode(source));
}