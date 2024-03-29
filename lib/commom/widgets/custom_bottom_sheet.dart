import 'package:flutter/material.dart';
import 'package:minha_estante/commom/widgets/primary_button.dart';

import 'package:minha_estante/commom/constants/app_colors.dart';
import 'package:minha_estante/commom/constants/app_text_styles.dart';

Future<void> customModalBottomSheet(
  BuildContext context, {
  required String content,
  required String buttonText,
  VoidCallback? onPressed,
}) {
  return showModalBottomSheet<void>(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(38.0),
        topRight: Radius.circular(38.0),
      ),
    ),
    builder: (BuildContext context) {
      return Container(
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(38.0),
            topRight: Radius.circular(38.0),
          ),
        ),
        height: 200,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.00,
                  horizontal: 32.00,
                ),
                child: Text(
                  content,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.mediumText20.copyWith(
                    color: AppColors.greenOne,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 32.0,
                ),
                child: PrimaryButton(
                  text: buttonText,
                  onPressed: onPressed ?? () => Navigator.pop(context),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
