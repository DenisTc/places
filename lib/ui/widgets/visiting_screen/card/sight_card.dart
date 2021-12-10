import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/redux/action/favorite_places_action.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/screens/res/constants.dart' as constants;
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/sight_details_screen.dart';
import 'package:places/ui/widgets/sight_cupertino_date_picker.dart';
import 'package:places/ui/widgets/visiting_screen/card/favorite_card_bottom.dart';
import 'package:places/ui/widgets/visiting_screen/card/favorite_card_top.dart';

class SightCard extends StatefulWidget {
  final GlobalKey globalKey;
  final bool visited;
  final Place place;
  const SightCard({
    required this.visited,
    required this.place,
    required this.globalKey,
    Key? key,
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
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 197,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [
                      Colors.red,
                      Theme.of(context).colorScheme.secondary,
                    ],
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(18)),
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
                          constants.textBtnDelete,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Dismissible(
                key: ValueKey(widget.place),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  StoreProvider.of<AppState>(context)
                      .dispatch(ToggleInFavoriteAction(widget.place));
                },
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        onTap: () {
                          _showSight(widget.place.id!);
                        },
                      ),
                    ),
                    Positioned(
                      right: 4,
                      child: Row(
                        children: [
                          Material(
                            color: Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            clipBehavior: Clip.antiAlias,
                            child: IconButton(
                              onPressed: () async {
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
                                              primary: Theme.of(context)
                                                  .colorScheme
                                                  .primaryVariant,
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
                                        return const SightCupertinoDatePicker();
                                      },
                                    );
                                  }
                                }
                              },
                              icon: SvgPicture.asset(
                                widget.visited ? iconShare : iconCalendar,
                                width: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 2),
                          Material(
                            color: Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            clipBehavior: Clip.antiAlias,
                            child: IconButton(
                              onPressed: () {
                                StoreProvider.of<AppState>(context).dispatch(
                                    ToggleInFavoriteAction(widget.place));
                              },
                              icon: const Icon(
                                Icons.clear_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
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

  Future<void> _showSight(int id) async {
    await showModalBottomSheet<Place>(
      context: context,
      builder: (_) {
        return SightDetails(id: id);
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
