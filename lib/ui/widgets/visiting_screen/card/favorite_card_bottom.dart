import 'package:flutter/material.dart';
import 'package:places/domain/place.dart';

class FavoriteCardBottom extends StatelessWidget {
  final Place place;
  final bool visited;

  const FavoriteCardBottom({
    required this.place,
    required this.visited,
    Key? key,
  }) : super(key: key);

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
            place.name,
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
                    color: Theme.of(context).colorScheme.primaryVariant,
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