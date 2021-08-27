import 'package:flutter/material.dart';
import 'package:places/domains/sight.dart';
import 'package:places/ui/widgets/card/sight_card_favorite/sight_card.dart';

/// A card of an interesting place to display on the favourites' screen
class FavoriteSightCard extends StatefulWidget {
  final bool visited;
  final Sight sight;
  final Function(Sight data, Sight sight, bool visited) moveItemInList;
  final Function(Sight sight, bool visited) removeSight;

  const FavoriteSightCard({
    required this.visited,
    required this.sight,
    Key? key,
    required this.moveItemInList,
    required this.removeSight,
  }) : super(key: key);

  @override
  _FavoriteSightCardState createState() => _FavoriteSightCardState();
}

class _FavoriteSightCardState extends State<FavoriteSightCard> {
  GlobalKey globalKey = GlobalKey();
  bool isDrag = false;
  @override
  Widget build(BuildContext context) {
    return DragTarget<Sight>(
      builder: (context, candidateItems, rejectedItems) {
        return LongPressDraggable<Sight>(
          data: widget.sight,
          onDragStarted: () {
            setState(() {
              isDrag = true;
            });
          },
          onDragEnd: (details) {
            setState(() {
              isDrag = false;
            });
          },
          feedback: Transform.scale(
            scale: 0.9,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 216,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: SightCard(
                globalKey: globalKey,
                sight: widget.sight,
                visited: widget.visited,
                removeSight: (sight, visited) {
                  widget.removeSight(
                    widget.sight,
                    widget.visited,
                  );
                },
              ),
            ),
          ),
          child: isDrag
              ? const SizedBox.shrink()
              : SightCard(
                  globalKey: globalKey,
                  sight: widget.sight,
                  visited: widget.visited,
                  removeSight: (sight, visited) {
                    widget.removeSight(
                      widget.sight,
                      widget.visited,
                    );
                  },
                ),
        );
      },
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) {
        setState(
          () {
            widget.moveItemInList(
              data,
              widget.sight,
              widget.visited,
            );
          },
        );
      },
    );
  }
}
