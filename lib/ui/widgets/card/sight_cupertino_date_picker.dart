
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SightCupertinoDatePicker extends StatefulWidget {
  const SightCupertinoDatePicker({Key? key}) : super(key: key);

  @override
  _SightCupertinoDatePickerState createState() =>
      _SightCupertinoDatePickerState();
}

class _SightCupertinoDatePickerState extends State<SightCupertinoDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      color: Colors.white,
      child: CupertinoDatePicker(
        initialDateTime: DateTime.now(),
        onDateTimeChanged: (newdate) {},
      ),
    );
  }
}
