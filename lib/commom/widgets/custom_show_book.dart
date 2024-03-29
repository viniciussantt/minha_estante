import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/constants/book_reading_status.dart';
import 'package:minha_estante/commom/constants/routes.dart';
import 'package:minha_estante/commom/models/book_model.dart';
import 'package:minha_estante/commom/utils/truncate_text.dart';
import 'package:minha_estante/commom/widgets/buttom_add_book.dart';
import 'package:minha_estante/commom/widgets/widgetsDialog/remove_book.dart';
import 'package:minha_estante/services/user_library_service.dart';

class CustomShowBook extends StatefulWidget {
  final BookModel book;

  CustomShowBook({Key? key, required this.book}) : super(key: key);

  @override
  _CustomShowBookState createState() => _CustomShowBookState();
}

class _CustomShowBookState extends State<CustomShowBook> {
  String _statusBook = BookReadingStatus.naoLido;
  int _pgLidas = BookReadingStatus.pgLidas;
  int _nota = BookReadingStatus.nota;

  @override
  void initState() {
    super.initState();
    getBookStatus();
    getReadingPg();
    getNota();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    getBookStatus();
  }

  void getBookStatus() {
    UserLibraryService libraryService = UserLibraryService();
    Stream<String> statusStream = libraryService.getBookStatus(widget.book);

    statusStream.listen((status) {
      setState(() {
        _statusBook = status;
      });
    });
  }

  void getReadingPg() {
    UserLibraryService libraryService = UserLibraryService();
    Stream<int> pgLidasStream = libraryService.getReadingPages(widget.book);

    pgLidasStream.listen((pgLidas) {
      setState(() {
        _pgLidas = pgLidas;
      });
    });
  }

  void getNota() {
    UserLibraryService libraryService = UserLibraryService();
    Stream<int?> notaStream = libraryService.getRating(widget.book);

    notaStream.listen((nota) {
      setState(() {
        _nota = nota ?? BookReadingStatus.nota;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isUnread = _statusBook !=
        BookReadingStatus.naoLido; // Verifica se o status do livro é "não lido"

    return WillPopScope(
      onWillPop: () async {
        Navigator.popAndPushNamed(context, NamedRoute.splash);
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              child: Container(
                decoration: const BoxDecoration(
                  color: AppColors.green,
                ),
                height: 410,
                padding: const EdgeInsets.only(left: 15.0),
                child: Stack(
                  children: [
                    Positioned(
                      top: 130,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          widget.book.imageUrl,
                          fit: BoxFit.cover,
                          width: 128.0,
                          height: 200.0,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 130.0,
                      left: 140.0,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 180.0,
                        child: Text(
                          widget.book.titulo,
                          style: AppTextStyles.mediumText16.copyWith(
                            color: AppColors.white,
                          ),
                          //textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 240.0,
                      left: 140.0,
                      child: Container(
                        width: MediaQuery.of(context).size.width - 180.0,
                        child: RichText(
                          text: TextSpan(
                            style: DefaultTextStyle.of(context).style,
                            children: <TextSpan>[
                              TextSpan(
                                text: "Autor: ",
                                style: AppTextStyles.boldText.copyWith(
                                  color: AppColors.black,
                                ),
                              ),
                              TextSpan(
                                text: widget.book.autor,
                                style: AppTextStyles.boldText.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 260.0,
                      left: 140.0,
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: "Gênero: ",
                              style: AppTextStyles.boldText.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                            TextSpan(
                              text: TruncateText.truncateText(
                                  widget.book.genero, 22),
                              style: AppTextStyles.boldText.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 280.0,
                      left: 140.0,
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: "Nº de páginas: ",
                              style: AppTextStyles.boldText.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                            TextSpan(
                              text: widget.book.qtdPaginas.toString(),
                              style: AppTextStyles.boldText.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 350.0,
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: "Status: ",
                              style: AppTextStyles.boldText.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                            TextSpan(
                              text: _statusBook,
                              style: AppTextStyles.boldText.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 350.0,
                      right: 20.0,
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: "Páginas: ",
                              style: AppTextStyles.boldText.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                            TextSpan(
                              text: _pgLidas < 0
                                  ? " --" +
                                      " / " +
                                      widget.book.qtdPaginas.toString()
                                  : _pgLidas.toString() +
                                      " / " +
                                      widget.book.qtdPaginas.toString(),
                              style: AppTextStyles.boldText.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      top: 370.0,
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(
                              text: "Sua nota: ",
                              style: AppTextStyles.boldText.copyWith(
                                color: AppColors.black,
                              ),
                            ),
                            TextSpan(
                              text: _nota < 0 ? " --" : _nota.toString(),
                              style: AppTextStyles.boldText.copyWith(
                                color: AppColors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 20,
              right: 0,
              top: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () =>
                        Navigator.popAndPushNamed(context, NamedRoute.home),
                    child: const Icon(
                      Icons.arrow_back_ios,
                      size: 25.0,
                      color: AppColors.white,
                    ),
                  ),
                  SizedBox(width: 40.0),
                ],
              ),
            ),
            Positioned(
              top: 430,
              left: 15.0,
              child: Container(
                width: MediaQuery.of(context).size.width - 30.0,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: AppColors.otherGrey,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Text(
                  'Descrição',
                  style: AppTextStyles.mediumBoldText20.copyWith(
                    color: AppColors.otherGrey,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 460,
              left: 20.0,
              child: Container(
                width: MediaQuery.of(context).size.width - 40.0,
                child: Wrap(
                  children: [
                    Text(
                      TruncateText.truncateText(widget.book.descricao, 700),
                      style: AppTextStyles.extraSmallText.copyWith(
                        color: AppColors.black,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width - 30.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: isUnread,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: RemoveBook(book: widget.book),
              ),
              buttomAddBook(
                book: widget.book,
              ),
            ],
          ),
        ),
      ),
    );
  }
}