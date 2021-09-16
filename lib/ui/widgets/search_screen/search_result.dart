import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/sight_details_screen.dart';

class SearchResult extends StatelessWidget {
  final Place place;
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
                id: mocks.indexOf(place),
              ),
            ),
          );
        },
        child: Row(
          children: [
            _SightImage(place: place),
            const SizedBox(width: 16),
            _SightDesc(
              place: place,
              searchString: searchString,
            ),
          ],
        ),
      ),
    );
  }
}

class _SightDesc extends StatelessWidget {
  final Place place;
  final String searchString;
  const _SightDesc({
    Key? key,
    required this.place,
    required this.searchString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            RichName(
              name: place.name,
              searchString: searchString,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Text(
              place.placeType,
              style: const TextStyle(color: myLightSecondaryTwo),
            ),
          ],
        ),
        //if(index != widget.historyList.length-1)
        const Divider(height: 2),
      ],
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
    final int index =
        widget.name.toLowerCase().indexOf(widget.searchString.toLowerCase()) +
            widget.searchString.length;
    final String richText = widget.name.substring(0, index);
    final String text = widget.name.substring(index);

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
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
  final Place place;

  const _SightImage({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 56,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(12.0)),
        child: Image.network(
          place.urls.first,
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
