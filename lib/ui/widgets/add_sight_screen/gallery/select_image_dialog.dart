import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/res/constants.dart' as Constants;

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
                      color: myLightSecondaryTwo,
                    ),
                    const SizedBox(width: 15),
                    const Text(
                      Constants.textBtnCamera,
                      style: TextStyle(
                        fontSize: 16,
                        color: myLightSecondaryTwo,
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Row(
                  children: [
                    SvgPicture.asset(
                      iconPhoto,
                      color: myLightSecondaryTwo,
                    ),
                    const SizedBox(width: 14),
                    const Text(
                      Constants.textBtnPhoto,
                      style: TextStyle(
                        fontSize: 16,
                        color: myLightSecondaryTwo,
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
                      color: myLightSecondaryTwo,
                    ),
                    const SizedBox(width: 16),
                    const Text(
                      Constants.textBtnFile,
                      style: TextStyle(
                        fontSize: 16,
                        color: myLightSecondaryTwo,
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
              child: Text(
                Constants.textCancel.toUpperCase(),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).buttonColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
