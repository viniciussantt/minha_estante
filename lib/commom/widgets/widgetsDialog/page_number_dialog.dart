import 'package:flutter/material.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';
import 'package:minha_estante/commom/constants/book_reading_status.dart';
import 'package:minha_estante/commom/models/book_model.dart';
import 'package:minha_estante/commom/widgets/widgetsDialog/show_success_dialog.dart';
import 'package:minha_estante/services/user_library_service.dart';
import 'package:minha_estante/commom/constants/app_colors.dart';

Widget buildPageNumberDialog(
    BuildContext context, BookModel book, String statusLeitura) {
  int _numberPag = BookReadingStatus.pgLidas;
  final UserLibraryService userLibraryService = UserLibraryService();

  return AlertDialog(
    title: Text(
      'Insira o número da página:',
      style: AppTextStyles.mediumText18.copyWith(color: AppColors.green),
    ),
    content: TextField(
      keyboardType: TextInputType.number,
      onChanged: (value) {
        _numberPag = int.tryParse(value) ?? 0;
      },
      decoration: InputDecoration(hintText: 'Número da página'),
    ),
    actions: <Widget>[
      TextButton(
        child: Text(
          'CANCELAR',
          style: AppTextStyles.smallText.copyWith(color: AppColors.greenOne),
        ),
        onPressed: () {
          Navigator.of(context).pop(); // Fecha o dialog
        },
      ),
      TextButton(
        child: Text(
          'CONFIRMAR',
          style: AppTextStyles.smallText.copyWith(color: AppColors.greenOne),
        ),
        onPressed: () {
          if (_numberPag >= 0 && _numberPag <= book.qtdPaginas) {
            print('Número da página: $_numberPag');
            userLibraryService.updateReadingStatus(
                book, statusLeitura, _numberPag);
            Navigator.of(context).pop(); // Fecha o dialog
            SuccessDialog.show(context, book.id); // Exibe o dialog de sucesso
          } else {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text(
                    'Página inválida',
                    style: AppTextStyles.mediumText18
                        .copyWith(color: AppColors.red),
                  ),
                  content: Text(
                    'Por favor, digite um número de página válido.',
                    style: AppTextStyles.smallText,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop(); // Fecha o dialog de página inválida
                      },
                      child: Text(
                        'OK',
                        style: AppTextStyles.smallText
                            .copyWith(color: AppColors.greenOne),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
    ],
  );
}
