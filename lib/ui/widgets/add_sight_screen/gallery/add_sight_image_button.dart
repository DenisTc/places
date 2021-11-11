import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/constants.dart' as Constants;
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/widgets/add_sight_screen/gallery/file_list.dart';
import 'package:places/ui/widgets/add_sight_screen/gallery/select_image_dialog.dart';

class AddSightImageButton extends StatefulWidget {
  final Function(List<XFile>?) addImage;
  const AddSightImageButton({
    Key? key,
    required this.addImage,
  }) : super(key: key);

  @override
  _AddSightImageButtonState createState() => _AddSightImageButtonState();
}

class _AddSightImageButtonState extends State<AddSightImageButton> {
  ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (_) {
            return Material(
              color: Colors.transparent,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Theme.of(context).accentColor,
                    ),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            _getImageFromCamera().then(
                              (_) {
                                Navigator.of(context).pop(imageFileList);
                                widget.addImage(imageFileList);
                              },
                            );
                          },
                          child: Row(
                            children: [
                              // TODO: Need make the text color as on the layout in figma
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
                        ),
                        const SizedBox(height: 10),
                        Divider(
                          height: 1,
                          color: myLightSecondaryTwo.withOpacity(0.56),
                        ),
                        const SizedBox(height: 6),
                        InkWell(
                          onTap: () {
                            _imgFromGallery().then(
                              (_) {
                                Navigator.of(context).pop(imageFileList);
                                widget.addImage(imageFileList);
                              },
                            );
                          },
                          child: Row(
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
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        color: Theme.of(context).accentColor,
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
          },
        );
      },
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
                color: Theme.of(context).buttonColor.withOpacity(0.56),
              ),
            ),
          ),
          SvgPicture.asset(
            iconPlus,
            width: 25,
            color: Theme.of(context).buttonColor,
          ),
        ],
      ),
    );
  }

  Future<void> _getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile == null) return;
    imageFileList = [XFile(pickedFile.path)];
  }

  Future<void> _imgFromGallery() async {
    final selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages == null) return;
    imageFileList = selectedImages;
  }
}
