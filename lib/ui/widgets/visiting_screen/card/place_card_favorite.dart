import 'package:flutter/material.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/widgets/visiting_screen/card/place_card.dart';

class FavoritePlaceCard extends StatefulWidget {
  final DateTime? visitDate;
  final Place place;
  final Function(Place data, Place place, bool visited) moveItemInList;

  const FavoritePlaceCard({
    Key? key,
    required this.place,
    required this.moveItemInList,
    this.visitDate,
  }) : super(key: key);

  @override
  _FavoritePlaceCardState createState() => _FavoritePlaceCardState();
}

class _FavoritePlaceCardState extends State<FavoritePlaceCard> {
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
              child: PlaceCard(
                globalKey: globalKey,
                place: widget.place,
                visitDate: widget.visitDate,
              ),
            ),
          ),
          child: isDrag
              ? const SizedBox.shrink()
              : PlaceCard(
                  globalKey: globalKey,
                  place: widget.place,
                  visitDate: widget.visitDate,
                ),
        );
      },
      onWillAccept: (data) {
        return true;
      },
      onAccept: (data) {
        setState(
          () {
            // widget.moveItemInList(
            //   data,
            //   widget.place,
            //   widget.visited,
            // );
          },
        );
      },
    );
  }
}
