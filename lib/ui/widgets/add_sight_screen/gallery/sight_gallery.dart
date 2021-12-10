import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places/ui/widgets/add_sight_screen/gallery/add_sight_image_button.dart';
import 'package:places/ui/widgets/add_sight_screen/gallery/sight_image.dart';

class SightGallery extends StatefulWidget {
  final List<String> images;
  final Function(List<XFile>? xFileList) addImage;
  final Function(String imgUrl) deleteImage;

  const SightGallery({
    Key? key,
    required this.addImage,
    required this.deleteImage,
    required this.images,
  }) : super(key: key);

  @override
  _SightGalleryState createState() => _SightGalleryState();
}

class _SightGalleryState extends State<SightGallery> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AddSightImageButton(
          addImage: (xFileList) {
            widget.addImage(xFileList);
          },
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(left: 5),
            width: MediaQuery.of(context).size.width * .75,
            height: 72,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) {
                    setState(() {
                      widget.images.remove(widget.images[index]);
                    });
                  },
                  direction: DismissDirection.up,
                  background: Container(),
                  child: SightImage(
                    image: widget.images[index],
                    notifyParent: (imgUrl) {
                      widget.deleteImage(imgUrl);
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
}
