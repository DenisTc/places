import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domains/sight.dart';
import 'package:places/ui/icons.dart';

/// A card of an interesting place to be displayed on the main screen of the application.
class SightCard extends StatelessWidget {
  final Sight sight;
  //const SightCard({Key? key, required this.sight}) : super(key: key);
  const SightCard(this.sight);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 188,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _SightCardTop(sight: sight),
              _SightCardBottom(sight: sight),
            ],
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              onTap: () {},
            ),
          ),
        ],
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
      height: 92,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        color: Theme.of(context).primaryColor,
      ),
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
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
          const SizedBox(height: 2),
          Text(
            sight.details,
            maxLines: 2,
            style: Theme.of(context).textTheme.bodyText2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 16),
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
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: Image.network(
              sight.url,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
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
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sight.type,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SvgPicture.asset(iconFavorite, color: Colors.white),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
