import 'package:flutter/material.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/widgets/add_sight_screen/gallery/add_sight_image_button.dart';
import 'package:places/ui/widgets/add_sight_screen/gallery/sight_image.dart';

class SightGallery extends StatefulWidget {
  const SightGallery({Key? key}) : super(key: key);
  @override
  _SightGalleryState createState() => _SightGalleryState();
}

class _SightGalleryState extends State<SightGallery> {
  List<String> images = [
    mocks[0].url,
    mocks[0].url,
    mocks[0].url,
    mocks[0].url,
  ];

  void deleteImage(String imgUrl) {
    setState(() {
      images.remove(imgUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const AddSightImageButton(),
        Container(
          padding: EdgeInsets.only(left: 5),
          width: MediaQuery.of(context).size.width * .75,
          height: 72,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction){
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
      ],
    );
  }
}
