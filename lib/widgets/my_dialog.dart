import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soluxe/widgets/typography/my_text.dart';
import 'package:soluxe/l10n/app_localizations.dart';

class MyDialog extends StatelessWidget {
  final String message;
  final String? title;

  const MyDialog({super.key, required this.message, this.title});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoAlertDialog(
            title: MyText.warmPrimary(
              title ?? AppLocalizations.of(context)!.errorOccurred,
              fontSize: 22,
            ),
            content: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: MyText.deepBlue(
                message,
                fontSize: 16,
              ),
            ),
            actions: [
              CupertinoButton(
                onPressed: () => Navigator.of(context).pop(),
                child: MyText.deepBlue(AppLocalizations.of(context)!.ok),
              ),
            ],
          )
        : AlertDialog(
            title: MyText.warmPrimary(
              AppLocalizations.of(context)!.errorOccurred,
              fontSize: 22,
            ),
            content: MyText.deepBlue(
              message,
              fontSize: 16,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: MyText.deepBlue(AppLocalizations.of(context)!.ok),
              ),
            ],
          );
  }
}
