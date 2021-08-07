import 'package:flutter/material.dart';
import 'package:places/domains/sight.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/screens/sight_details_screen.dart';

class SearchResult extends StatelessWidget {
  final Sight sight;
  final String searchString;
  const SearchResult({
    Key? key,
    required this.sight,
    required this.searchString,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 11),
      child: InkWell(
        onTap: (){
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => SightDetails(sight: sight) ));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _SightImage(sight: sight),
            SizedBox(width: 16),
            _SightDesc(
              sight: sight,
              searchString: searchString,
            ),
          ],
        ),
      ),
    );
  }
}

class _SightDesc extends StatelessWidget {
  final Sight sight;
  final String searchString;
  const _SightDesc({
    Key? key,
    required this.sight,
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
              name: sight.name,
              searchString: searchString,
            )
          ],
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text(
              sight.type,
              style: TextStyle(color: textColorSecondary),
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
    String richText = widget.name.substring(0, index);
    String text = widget.name.substring(index);

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: <TextSpan>[
          TextSpan(
            text: richText,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextSpan(
              text: text,
              style: TextStyle(
                fontSize: 16,
                color: favoriteColor,
              )),
        ],
      ),
    );
  }
}

class _SightImage extends StatelessWidget {
  const _SightImage({
    Key? key,
    required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: 56,
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        child: Image.network(
          sight.url,
          fit: BoxFit.cover,
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12.0)),
        color: Colors.red,
      ),
    );
  }
}
