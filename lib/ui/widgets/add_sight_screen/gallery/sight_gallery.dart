import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:places/ui/widgets/add_sight_screen/gallery/add_sight_image_button.dart';
import 'package:places/ui/widgets/add_sight_screen/gallery/sight_image.dart';
import 'package:relation/relation.dart';

class SightGallery extends StatelessWidget {
  final Function(List<XFile>? xFileList) addImage;
  final Function(String imgUrl) deleteImage;
  final StreamedState<List<String>> galleryState;

  const SightGallery({
    Key? key,
    required this.addImage,
    required this.deleteImage,
    required this.galleryState,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamedStateBuilder<List<String>>(
      streamedState: galleryState,
      builder: (context, images) {
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
                        deleteImage: (imgUrl) {
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
      },
    );
  }
}
