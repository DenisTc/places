import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlaceCupertinoDatePicker extends StatefulWidget {
  const PlaceCupertinoDatePicker({Key? key}) : super(key: key);

  @override
  _PlaceCupertinoDatePickerState createState() =>
      _PlaceCupertinoDatePickerState();
}

class _PlaceCupertinoDatePickerState extends State<PlaceCupertinoDatePicker> {
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
