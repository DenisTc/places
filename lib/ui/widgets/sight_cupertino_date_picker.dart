import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SightCupertinoDatePicker extends StatelessWidget {
  final ValueChanged<DateTime> onValueChanged;
  const SightCupertinoDatePicker({
    Key? key,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      height: 250,
      child: CupertinoTheme(
        data: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
          ),
        ),
        child: CupertinoDatePicker(
          initialDateTime: DateTime.now(),
          onDateTimeChanged: (date) => onValueChanged(date),
        ),
      ),
    );
  }
}
