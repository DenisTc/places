import 'package:flutter/material.dart';
import 'package:places/domains/sight.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/screens/sight_card.dart';

/// A card of an interesting place to display on the favourites' screen
class FavoriteSightCard extends SightCard {
  final bool visited;
  FavoriteSightCard(Sight sight, this.visited) : super(sight);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Container(
        margin: EdgeInsets.all(20),
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Container(
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
                      children: [
                        Expanded(
                          child: Text(
                            sight.type,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        visited
                            ? Icon(
                                Icons.share,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.calendar_today_outlined,
                                color: Colors.white,
                              ),
                        SizedBox(
                          width: 23,
                        ),
                        Icon(
                          Icons.clear_outlined,
                          color: Colors.white,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: const Radius.circular(16),
                  bottomRight: const Radius.circular(16),
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
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    sight.name,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.headline1?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  visited
                      ? Text(
                          'Цель достигнута 12 окт. 2020',
                          maxLines: 2,
                          style: Theme.of(context).textTheme.bodyText2,
                          overflow: TextOverflow.ellipsis,
                        )
                      : Text(
                          'Запланировано на 12 окт. 2020',
                          maxLines: 2,
                          style: Theme.of(context).textTheme.bodyText2?.copyWith(
                            color: lightGreen,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'закрыто до 09:00',
                    maxLines: 2,
                    style: Theme.of(context).textTheme.bodyText2,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
