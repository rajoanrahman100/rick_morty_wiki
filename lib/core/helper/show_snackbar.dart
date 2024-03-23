import 'package:flutter/material.dart';
import 'package:ricky_morty_wiki/core/constants/text_styles.dart';

void showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message,style: bodySemiBold12,)),
  );
}