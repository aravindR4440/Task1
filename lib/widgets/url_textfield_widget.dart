

import 'package:flutter/material.dart';

class UrlTextField extends StatelessWidget {
  final String label;
  final String value;

  const UrlTextField({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: TextFormField(
        enabled: false,
        initialValue: value,
        style: const TextStyle(color: Colors.blue,
            fontWeight: FontWeight.w500,fontSize: 14),
        maxLines: null,
        decoration: InputDecoration(
          border: const UnderlineInputBorder(borderSide: BorderSide(width: 0.5)),
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black)
        ),
      ),
    );
  }
}
