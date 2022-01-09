import 'package:flutter/material.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/screens/place_details_screen.dart';

class SearchResult extends StatelessWidget {
  final Place place;
  final String searchString;
  final Function(String name) addPlaceToSearchHistory;

  const SearchResult({
    required this.place,
    required this.searchString,
    required this.addPlaceToSearchHistory,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: InkWell(
        onTap: () {
          Navigator.push<List?>(
            context,
            MaterialPageRoute(
              builder: (context) => PlaceDetails(
                place: place,
              ),
            ),
          );
          addPlaceToSearchHistory(place.name);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (place.urls.isNotEmpty)
              _PlaceImage(imgUrl: place.urls.first)
            else
              Container(
                height: 56,
                width: 56,
                color: Colors.white,
                child: const Center(
                  child: Icon(
                    Icons.photo_size_select_actual_outlined,
                    color: Colors.grey,
                    size: 30.0,
                  ),
                ),
              ),
            const SizedBox(width: 16),
            _PlaceDesc(
              name: place.name,
              placeType: place.placeType,
              searchString: searchString,
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceDesc extends StatelessWidget {
  final String name;
  final String placeType;
  final String searchString;

  const _PlaceDesc({
    required this.name,
    required this.placeType,
    required this.searchString,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichName(
            name: name,
            searchString: searchString,
          ),
          const SizedBox(height: 8),
          Text(
            Category.getCategoryByType(placeType).name,
            style: const TextStyle(color: myLightSecondaryTwo),
          ),
          const SizedBox(height: 8),
          const Divider(height: 2),
        ],
      ),
    );
  }
}

class RichName extends StatefulWidget {
  final String name;
  final String searchString;

  const RichName({
    required this.name,
    required this.searchString,
    Key? key,
  }) : super(key: key);

  @override
  _RichNameState createState() => _RichNameState();
}

class _RichNameState extends State<RichName> {
  @override
  Widget build(BuildContext context) {
    final startIndex =
        widget.name.toLowerCase().indexOf(widget.searchString.toLowerCase());
    final endIndex = startIndex + widget.searchString.length;
    final textStart = widget.name.substring(0, startIndex);
    final richText = widget.name.substring(startIndex, endIndex);
    final textEnd = widget.name.substring(endIndex);

    return RichText(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(
            text: textStart,
            style: const TextStyle(
              fontSize: 16,
              color: myLightMain,
            ),
          ),
          TextSpan(
            text: richText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: textEnd,
            style: const TextStyle(
              fontSize: 16,
              color: myLightMain,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlaceImage extends StatelessWidget {
  final String imgUrl;

  const _PlaceImage({
    required this.imgUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      width: 56,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        child: Image.network(
          imgUrl,
          fit: BoxFit.cover,
          loadingBuilder: (
            context,
            child,
            loadingProgress,
          ) {
            if (loadingProgress == null) return child;

            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.white,
              child: const Center(
                child: Icon(
                  Icons.photo_size_select_actual_outlined,
                  color: Colors.grey,
                  size: 30.0,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
