import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/sight_details_screen.dart';

class SearchResult extends StatelessWidget {
  final PlaceDto place;
  final String searchString;
  const SearchResult({
    Key? key,
    required this.place,
    required this.searchString,
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
              builder: (context) => SightDetails(
                id: place.id,
              ),
            ),
          );
        },
        child: Row(
          children: [
            _SightImage(imgUrl: place.urls.first),
            const SizedBox(width: 16),
            _SightDesc(
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

class _SightDesc extends StatelessWidget {
  final String name;
  final String placeType;
  final String searchString;
  const _SightDesc({
    Key? key,
    required this.name,
    required this.placeType,
    required this.searchString, 
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
            placeType,
            style: const TextStyle(color: myLightSecondaryTwo),
          ),
          // const SizedBox(height: 8),
          //if(index != widget.historyList.length-1)
          // const Divider(height: 2),
        ],
      ),
    );
  }
}

class RichName extends StatefulWidget {
  final String name;
  final String searchString;

  const RichName({
    Key? key,
    required this.name,
    required this.searchString,
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
    final richText = widget.name.substring(0, endIndex);
    final text = widget.name.substring(endIndex);

    return RichText(
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          TextSpan(
            text: richText,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
            text: text,
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

class _SightImage extends StatelessWidget {
  final String imgUrl;

  const _SightImage({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 56,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        child: Image.network(
          imgUrl,
          fit: BoxFit.cover,
        ),
      ),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        color: Colors.red,
      ),
    );
  }
}