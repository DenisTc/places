import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/icons.dart';
import 'package:places/ui/widgets/add_sight_screen/gallery/select_image_dialog.dart';

class AddSightImageButton extends StatefulWidget {
  final Function() addImage;
  const AddSightImageButton({
    Key? key,
    required this.addImage,
  }) : super(key: key);

  @override
  _AddSightImageButtonState createState() => _AddSightImageButtonState();
}

class _AddSightImageButtonState extends State<AddSightImageButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _selectImage,
      //() {widget.addImage();},
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0),
              ),
              border: Border.all(
                color: lightGreen.withOpacity(0.56),
              ),
            ),
          ),
          SvgPicture.asset(
            iconPlus,
            width: 25,
            color: lightGreen,
          ),
        ],
      ),
    );
  }

  void _selectImage() async {
    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (_) {
        return const SelectImageDialog();
      },
    );
  }
}
