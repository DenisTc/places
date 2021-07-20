import 'package:flutter/material.dart';
import 'package:places/domains/sight.dart';

/// A card of an interesting place to be displayed on the main screen of the application.
class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard(this.sight);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.9,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            _SightCardTop(sight: sight),
            _SightCardBottom(sight: sight),
          ],
        ),
      ),
    );
  }
}

class _SightCardBottom extends StatelessWidget {
  const _SightCardBottom({
    Key? key,
    required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: const Radius.circular(16),
          bottomRight: const Radius.circular(16),
        ),
        color: Theme.of(context).primaryColor,
      ),
      width: double.infinity,
      height: 92,
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 16,
          ),
          Text(
            sight.name,
            maxLines: 2,
            style: Theme.of(context).textTheme.headline1?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 2,
          ),
          Text(
            sight.details,
            maxLines: 2,
            style: Theme.of(context).textTheme.bodyText2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}

class _SightCardTop extends StatelessWidget {
  const _SightCardTop({
    Key? key,
    required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(16),
              topRight: const Radius.circular(16),
            ),
            child: Image.network(
              sight.url,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sight.type,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Icon(
                  Icons.favorite_border,
                  color: Colors.white,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}