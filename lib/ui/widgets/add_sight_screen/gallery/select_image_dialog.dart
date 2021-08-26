import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/icons.dart';

class SelectImageDialog extends StatelessWidget {
  const SelectImageDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      iconCamera,
                      color: textColorSecondary,
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      'Камера',
                      style: TextStyle(
                        fontSize: 16,
                        color: textColorSecondary,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    SvgPicture.asset(
                      iconPhoto,
                      color: textColorSecondary,
                    ),
                    const SizedBox(width: 14),
                    const Text(
                      'Фотография',
                      style: TextStyle(
                        fontSize: 16,
                        color: textColorSecondary,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    const SizedBox(width: 4),
                    SvgPicture.asset(
                      iconFile,
                      color: textColorSecondary,
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      'Файл',
                      style: TextStyle(
                        fontSize: 16,
                        color: textColorSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width,
              child: const Text(
                'ОТМЕНА',
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: lightGreen,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
