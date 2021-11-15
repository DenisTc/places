import 'package:flutter/material.dart';

class SightMapScreen extends StatelessWidget {
  const SightMapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: const Center(
        child: Text(
          'Карта интересных мест',
        ),
      ),
    );
  }
}
