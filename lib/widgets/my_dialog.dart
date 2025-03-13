import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:soluxe/widgets/typography/my_text.dart';

class MyDialog extends StatelessWidget {
  final String message;
  final String? title;

  const MyDialog({super.key, required this.message, this.title});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoAlertDialog(
            title: MyText.warmBrown(
              title ?? 'Error',
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
                child: const MyText.deepBlue('OK'),
              ),
            ],
          )
        : AlertDialog(
            title: MyText.warmBrown(
              'Error',
              fontSize: 22,
            ),
            content: MyText.deepBlue(
              message,
              fontSize: 16,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const MyText.deepBlue('OK'),
              ),
            ],
          );
  }
}
