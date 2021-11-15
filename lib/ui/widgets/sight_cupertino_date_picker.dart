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
      color: Theme.of(context).colorScheme.secondary,
      height: 250,
      child: CupertinoTheme(
        data: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle: Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
          ),
        ),
        child: CupertinoDatePicker(
          initialDateTime: DateTime.now(),
          onDateTimeChanged: (newdate) {},
        ),
      ),
    );
  }
}
