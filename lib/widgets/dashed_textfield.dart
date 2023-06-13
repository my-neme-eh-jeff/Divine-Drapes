import 'package:flutter/material.dart';

class DashedTextField extends StatefulWidget {
  final int length;
  final Function(String) onChanged;

  DashedTextField({required this.length, required this.onChanged});

  @override
  _DashedTextFieldState createState() => _DashedTextFieldState();
}

class _DashedTextFieldState extends State<DashedTextField> {
  late List<String> otpValues;

  @override
  void initState() {
    super.initState();
    otpValues = List.generate(widget.length, (index) => '');
  }

  void _onTextChanged(String value, int index) {
    otpValues[index] = value;
    widget.onChanged(otpValues.join());
    if (value.isNotEmpty && index < widget.length - 1) {
      FocusScope.of(context).nextFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        widget.length,
        (index) => Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          width: 32.0,
          height: 48.0,
          child: TextField(
            onChanged: (value) => _onTextChanged(value, index),
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            maxLength: 1,
            style: TextStyle(fontSize: 24.0),
            decoration: InputDecoration(
              counterText: '',
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
