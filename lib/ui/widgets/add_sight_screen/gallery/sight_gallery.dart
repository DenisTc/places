import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places/ui/widgets/add_sight_screen/gallery/add_sight_image_button.dart';
import 'package:places/ui/widgets/add_sight_screen/gallery/sight_image.dart';

class SightGallery extends StatefulWidget {
  const SightGallery({Key? key}) : super(key: key);
  @override
  _SightGalleryState createState() => _SightGalleryState();
}

class _SightGalleryState extends State<SightGallery> {
  List<String> images = [];
  List<XFile>? xFileList = [];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AddSightImageButton(
          addImage: (xFileList) {
            addImage(xFileList);
          },
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 5),
            width: MediaQuery.of(context).size.width * .75,
            height: 72,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: images.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    images.remove(images[index]);
                  },
                  direction: DismissDirection.up,
                  background: Container(),
                  child: SightImage(
                    image: images[index],
                    notifyParent: (imgUrl) {
                      deleteImage(imgUrl);
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  void deleteImage(String imgUrl) {
    setState(() {
      images.remove(imgUrl);
    });
  }

  void addImage(List<XFile>? xFileList) {
    setState(() {
      images.addAll(xFileList!.map((image) => image.path));
    });
  }
}
