import 'package:flutter/material.dart';

import '../../themes.dart';

class StyleTextFormField extends StatelessWidget {
  final FormFieldValidator validator;
  final Key key;
  final TextInputType textInputType;
  final String hintText;
  final Widget icon;
  final FormFieldSetter onSaved;
  final bool obscure;
  final bool autocorrect;
  final TextCapitalization textCapitalization;

  final  bool enableSuggestions;

  StyleTextFormField(
      {required this.validator,
      required this.textInputType,
      required this.hintText,
      required this.icon,
      required this.onSaved,
      required this.key,
      required this.obscure,
      required this.autocorrect,
      required this.textCapitalization,
     required this.enableSuggestions});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: autocorrect,
      textCapitalization: textCapitalization,
      enableSuggestions: enableSuggestions,
      style: const TextStyle(color: bronColor),
      obscureText: obscure,
      autofocus: false,
      cursorColor: bronColor,
      cursorHeight: 20,
      onSaved: onSaved,
      validator: validator,
      key: key,
      keyboardType: textInputType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 17),
        prefixIcon: icon,
        iconColor: bronColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(width: 2, color: bronColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(width: 2, color: bronColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(width: 2, color: bronColor),
        ),
      ),
    );
  }
}
