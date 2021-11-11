import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:places/ui/screens/res/icons.dart';

class PhotoView extends StatefulWidget {
  final List<String> imageList;
  final int currentImage;
  const PhotoView({
    Key? key,
    required this.imageList,
    required this.currentImage,
  }) : super(key: key);

  @override
  _PhotoViewState createState() => _PhotoViewState();
}

class _PhotoViewState extends State<PhotoView> {
  late int currentPage;
  late PageController _pageController;

  @override
  void initState() {
    currentPage = widget.currentImage;
    _pageController = PageController(initialPage: currentPage);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            '${currentPage + 1}/${widget.imageList.length}',
            style: TextStyle(
              color: Theme.of(context).secondaryHeaderColor,
            ),
          ),
          actions: [
            SizedBox(
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.only(right: 21),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    borderRadius: const BorderRadius.all(Radius.circular(50)),
                    child: SizedBox(
                      height: 20,
                      width: 40,
                      child: Center(
                        child: SvgPicture.asset(
                          iconClose,
                          height: 20,
                          width: 20,
                          color: Theme.of(context).buttonColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: PhotoViewGallery.builder(
        onPageChanged: (page) {
          setState(() {
            currentPage = page;
          });
        },
        pageController: _pageController,
        itemCount: widget.imageList.length,
        builder: (context, index) {
          return PhotoViewGalleryPageOptions(
            imageProvider: NetworkImage(
              widget.imageList[index],
            ),
            minScale: PhotoViewComputedScale.contained * 0.8,
            maxScale: PhotoViewComputedScale.covered * 2,
          );
        },
        scrollPhysics: const BouncingScrollPhysics(),
        backgroundDecoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          color: Theme.of(context).accentColor,
        ),
        enableRotation: true,
        loadingBuilder: (context, event) => const Center(
          child: SizedBox(
            width: 30.0,
            height: 30.0,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
