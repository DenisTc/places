// TODO: The functionality of this widget has been moved to the AddPlaceImageButton widget. The decision on the fate of this widget will be made later.

// import 'dart:io';

// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:open_file/open_file.dart';
// import 'package:places/ui/screens/res/colors.dart';
// import 'package:places/ui/screens/res/constants.dart' as constants;
// import 'package:places/ui/screens/res/icons.dart';
// import 'package:places/ui/widgets/add_place_screen/gallery/file_list.dart';

// class SelectImageDialog extends StatefulWidget {
//   const SelectImageDialog({Key? key}) : super(key: key);

//   @override
//   State<SelectImageDialog> createState() => _SelectImageDialogState();
// }

// class _SelectImageDialogState extends State<SelectImageDialog> {
//   // List<XFile>? _imageFileList = [];
//   ImagePicker imagePicker = ImagePicker();
//   List<XFile>? imageFileList = [];

//   final picker = ImagePicker();
//   // FilePickerResult? result;
//   // PlatformFile? file;

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       color: Colors.transparent,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           Container(
//             margin: const EdgeInsets.symmetric(horizontal: 16),
//             padding: const EdgeInsets.all(16),
//             decoration: const BoxDecoration(
//               borderRadius: BorderRadius.all(
//                 Radius.circular(10),
//               ),
//               color: Colors.white,
//             ),
//             child: Column(
//               children: [
//                 InkWell(
//                   onTap: getImageFromCamera,
//                   child: Row(
//                     children: [
//                       SvgPicture.asset(
//                         iconCamera,
//                         color: myLightSecondaryTwo,
//                       ),
//                       const SizedBox(width: 15),
//                       const Text(
//                         Constants.textBtnCamera,
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: myLightSecondaryTwo,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const Divider(),
//                 InkWell(
//                   onTap: () {
//                     _imgFromGallery();
//                     Navigator.of(context).pop();
//                   },
//                   child: Row(
//                     children: [
//                       SvgPicture.asset(
//                         iconPhoto,
//                         color: myLightSecondaryTwo,
//                       ),
//                       const SizedBox(width: 14),
//                       const Text(
//                         Constants.textBtnPhoto,
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: myLightSecondaryTwo,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 // TODO: Clarify the functionality of the "file" button. At the moment it performs actions similar to the "Photo" button.
//                 // const Divider(),
//                 // InkWell(
//                 //   onTap: () async {
//                 //     result = await FilePicker.platform
//                 //         .pickFiles(type: FileType.image);
//                 //     if (result == null) return;
//                 //     file = result!.files.first;
//                 //     debugPrint(file?.name.toString());
//                 //     setState(() {});
//                 //   },
//                 //   child: Row(
//                 //     children: [
//                 //       const SizedBox(width: 4),
//                 //       SvgPicture.asset(
//                 //         iconFile,
//                 //         color: myLightSecondaryTwo,
//                 //       ),
//                 //       const SizedBox(width: 16),
//                 //       const Text(
//                 //         Constants.textBtnFile,
//                 //         style: TextStyle(
//                 //           fontSize: 16,
//                 //           color: myLightSecondaryTwo,
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//           const SizedBox(height: 8),
//           InkWell(
//             onTap: () {
//               Navigator.of(context).pop();
//             },
//             child: Container(
//               alignment: Alignment.center,
//               margin: const EdgeInsets.symmetric(horizontal: 16),
//               padding: const EdgeInsets.all(16),
//               decoration: const BoxDecoration(
//                 borderRadius: BorderRadius.all(
//                   Radius.circular(10),
//                 ),
//                 color: Colors.white,
//               ),
//               width: MediaQuery.of(context).size.width,
//               child: Text(
//                 Constants.textCancel.toUpperCase(),
//                 style: TextStyle(
//                   fontWeight: FontWeight.w700,
//                   color: Theme.of(context).buttonColor,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _imgFromGallery() async {
//     final selectedImages = await imagePicker.pickMultiImage();
//     if (selectedImages == null) return;

//     imageFileList!.addAll(selectedImages);

//     // setState(() {});
//   }

//   // TODO: delete
//   // Future getImageFromGallery() async {
//   //   final pickedFile = await picker.getImage(source: ImageSource.gallery);

//   //   setState(
//   //     () {
//   //       if (pickedFile != null) {
//   //         _image = File(pickedFile.path);
//   //       }
//   //     },
//   //   );
//   // }

//   Future getImageFromCamera() async {
//     final pickedFile = await picker.getImage(source: ImageSource.camera);
//     setState(() {
//       if (pickedFile != null) {
//         imageFileList!.add(XFile(pickedFile.path));
//       }
//     });
//   }

//   // TODO: Clarify the functionality of the "file" button. At the moment it performs actions similar to the "Photo" button.
//   // multiple file selected
//   // navigate user to 2nd screen to show selected files
//   // void loadSelectedFiles(List<PlatformFile> files) {
//   //   Navigator.of(context).push(MaterialPageRoute(
//   //       builder: (context) => FileList(files: files, onOpenedFile: viewFile)));
//   // }

//   // open the picked file
//   // void viewFile(PlatformFile file) {
//   //   OpenFile.open(file.path);
//   // }
// }
