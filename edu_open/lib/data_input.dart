import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final String newText = _addSlash(newValue.text);
    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }

  String _addSlash(String value) {
    value = value.replaceAll('/', '');
    final StringBuffer stringBuffer = StringBuffer();
    for (int i = 0; i < value.length; i++) {
      if (i == 2 || i == 4) {
        stringBuffer.write('/');
      }
      stringBuffer.write(value[i]);
    }
    return stringBuffer.toString();
  }
}