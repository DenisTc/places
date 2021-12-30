import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:places/domain/place.dart';

class FavoriteCardTop extends StatefulWidget {
  final Place place;
  final bool visited;

  const FavoriteCardTop({
    required this.place,
    required this.visited,
    Key? key,
  }) : super(key: key);

  @override
  _FavoriteCardTopState createState() => _FavoriteCardTopState();
}

class _FavoriteCardTopState extends State<FavoriteCardTop> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: CachedNetworkImage(
                imageUrl: widget.place.urls.first,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                placeholder: (context, url) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                errorWidget: (context, url, error) {
                  return ImagePlaceholder();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.place.placeType,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).secondaryHeaderColor,
      child: const Center(
        child: Icon(
          Icons.photo_size_select_actual_outlined,
          color: Colors.grey,
          size: 50.0,
        ),
      ),
    );
  }
}
