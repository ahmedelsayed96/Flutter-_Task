import 'package:flutter/material.dart';

class AppEditText extends StatelessWidget {
  final TextEditingController controller;

  final String labelText;
  final String pictureString;
  final TextInputType textInputType;
  final TextAlign textAlign;
  final Function onTap;
  final int maxLines;

  final int minLines;
  final FormFieldValidator<String> validator;
  final ValueChanged<String> onChanged;
  final bool enabled;
  final bool readOnly;

  AppEditText(
      {this.controller,
      this.labelText,
      this.pictureString,
      this.textInputType = TextInputType.text,
      this.textAlign = TextAlign.start,
      this.onTap,
      this.validator,
      this.readOnly = false,
      this.enabled = true,
      this.onChanged,
      this.maxLines = 1,
      this.minLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      readOnly: readOnly,
      onChanged: onChanged,
      controller: controller,
      enabled: enabled,
      minLines: minLines,
      maxLines: maxLines,
      keyboardType: textInputType,
      validator: this.validator,
      textAlign: textAlign,
      style: TextStyle(color: Colors.black, fontSize: 14),
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: Colors.red, width: 1)),
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 14),
      ),
    );
  }
}
