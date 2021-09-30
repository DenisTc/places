import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/sight_details_screen.dart';
import 'package:places/ui/widgets/sight_cupertino_date_picker.dart';
import 'package:places/ui/widgets/visiting_screen/card/favorite_card_bottom.dart';
import 'package:places/ui/widgets/visiting_screen/card/favorite_card_top.dart';

class SightCard extends StatefulWidget {
  final GlobalKey globalKey;
  final bool visited;
  final Place place;
  final Function(Place place, bool visited) removeSight;
  const SightCard({
    Key? key,
    required this.visited,
    required this.place,
    required this.globalKey,
    required this.removeSight,
  }) : super(key: key);

  @override
  __SightCardState createState() => __SightCardState();
}

class __SightCardState extends State<SightCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: Container(
        key: widget.globalKey,
        height: 199,
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: Dismissible(
          key: ValueKey(widget.place),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            widget.removeSight(widget.place, widget.visited);
          },
          background: Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
                  Colors.red,
                  Theme.of(context).accentColor,
                ],
              ),
              borderRadius: const BorderRadius.all(Radius.circular(16)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      iconBasket,
                      width: 25,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Удалить',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FavoriteCardTop(
                    place: widget.place,
                    visited: widget.visited,
                  ),
                  FavoriteCardBottom(
                    place: widget.place,
                    visited: widget.visited,
                  ),
                ],
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  onTap: () {
                    _showSight(widget.place.id);
                  },
                ),
              ),
              Positioned(
                right: 16,
                top: 10,
                child: Row(
                  children: [
                    InkWell(
                      onTap: () async {
                        if (widget.visited) {
                        } else {
                          if (Platform.isAndroid) {
                            await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2101),
                              builder: (context, child) {
                                return Theme(
                                  data: ThemeData.light().copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: Theme.of(context).buttonColor,
                                    ),
                                  ),
                                  child: child!,
                                );
                              },
                            );
                          } else {
                            await showModalBottomSheet<void>(
                              context: context,
                              builder: (builder) {
                                return SightCupertinoDatePicker();
                              },
                            );
                          }
                        }
                      },
                      child: SvgPicture.asset(
                        widget.visited ? iconShare : iconCalendar,
                        width: 25,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 16),
                    InkWell(
                      child: const Icon(
                        Icons.clear_outlined,
                        color: Colors.white,
                      ),
                      onTap: () {
                        setState(() {
                          widget.removeSight(
                            widget.place,
                            widget.visited,
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSight(int id) async {
    final placeRepository = PlaceRepository();
    final place = await placeRepository.getPlaceDetails(id: id);
    await showModalBottomSheet<Place>(
      context: context,
      builder: (_) {
        return SightDetails(place: place);
      },
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
  }
}
