import 'package:flutter/material.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/widgets/visiting_screen/card/sight_card.dart';

/// A card of an interesting place to display on the favourites' screen
class FavoriteSightCard extends StatefulWidget {
  final bool visited;
  final Place place;
  final Function(Place data, Place place, bool visited) moveItemInList;

  const FavoriteSightCard({
    required this.visited,
    required this.place,
    required this.moveItemInList,
    Key? key,
    
  }) : super(key: key);

  @override
  _FavoriteSightCardState createState() => _FavoriteSightCardState();
}

class _FavoriteSightCardState extends State<FavoriteSightCard> {
  GlobalKey globalKey = GlobalKey();
  bool isDrag = false;
  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return DragTarget<Place>(
      builder: (context, candidateItems, rejectedItems) {
        return LongPressDraggable<Place>(
          data: widget.place,
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
              width: isPortrait ? MediaQuery.of(context).size.width : 328,
              decoration: BoxDecoration(
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
                place: widget.place,
                visited: widget.visited,
              ),
            ),
          ),
          child: isDrag
              ? const SizedBox.shrink()
              : SightCard(
                  globalKey: globalKey,
                  place: widget.place,
                  visited: widget.visited,
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
              widget.place,
              widget.visited,
            );
          },
        );
      },
    );
  }
}