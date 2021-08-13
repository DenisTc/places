import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domains/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/icons.dart';

/// A card of an interesting place to display on the favourites' screen
class FavoriteSightCard extends StatefulWidget {
  final bool visited;
  final Sight sight;
  final Function() notifyParent;

  const FavoriteSightCard({
    required this.visited,
    required this.sight,
    Key? key,
    required this.notifyParent,
  }) : super(key: key);

  @override
  _FavoriteSightCardState createState() => _FavoriteSightCardState();
}

class _FavoriteSightCardState extends State<FavoriteSightCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 216,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _FavoriteCardTop(sight: widget.sight, visited: widget.visited),
                _FavoriteCardBottom(
                  sight: widget.sight,
                  visited: widget.visited,
                ),
              ],
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                onTap: () {},
              ),
            ),
            Positioned(
              right: 16,
              top: 10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    widget.visited ? iconShare : iconCalendar,
                    width: 25,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 16),
                  InkWell(
                    child: const Icon(
                      Icons.clear_outlined,
                      color: Colors.white,
                    ),
                    onTap: () {
                      setState(() {
                        mocks.remove(widget.sight);
                        widget.notifyParent();
                      });
                    },
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

class _FavoriteCardBottom extends StatelessWidget {
  const _FavoriteCardBottom({
    Key? key,
    required this.sight,
    required this.visited,
  }) : super(key: key);

  final Sight sight;
  final bool visited;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        color: Theme.of(context).primaryColor,
      ),
      width: double.infinity,
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        bottom: 16,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          Text(
            sight.name,
            maxLines: 2,
            style: Theme.of(context)
                .textTheme
                .headline1
                ?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
            textAlign: TextAlign.left,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          if (visited)
            Text(
              'Цель достигнута 12 окт. 2020',
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyText2,
              overflow: TextOverflow.ellipsis,
            )
          else
            Text(
              'Запланировано на 12 окт. 2020',
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: lightGreen,
                  ),
              overflow: TextOverflow.ellipsis,
            ),
          const SizedBox(height: 16),
          Text(
            'закрыто до 09:00',
            maxLines: 2,
            style: Theme.of(context).textTheme.bodyText2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _FavoriteCardTop extends StatefulWidget {
  const _FavoriteCardTop({
    Key? key,
    required this.sight,
    required this.visited,
  }) : super(key: key);

  final Sight sight;
  final bool visited;

  @override
  __FavoriteCardTopState createState() => __FavoriteCardTopState();
}

class __FavoriteCardTopState extends State<_FavoriteCardTop> {
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
              widget.sight.url,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              loadingBuilder: (
                BuildContext context,
                Widget child,
                ImageChunkEvent? loadingProgress,
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
              children: [
                Expanded(
                  child: Text(
                    widget.sight.type,
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
    );
  }
}
