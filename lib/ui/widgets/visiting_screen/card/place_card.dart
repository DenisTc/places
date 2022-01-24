import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:places/data/blocs/favorite_place/bloc/favorite_place_bloc.dart';
import 'package:places/data/blocs/visited_place/visited_place_bloc.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/constants.dart' as constants;
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/screens/place_details_screen.dart';

class PlaceCard extends StatefulWidget {
  final GlobalKey globalKey;
  final DateTime? visitDate;
  final Place place;
  const PlaceCard({
    Key? key,
    required this.place,
    required this.globalKey,
    this.visitDate,
  }) : super(key: key);

  @override
  __PlaceCardState createState() => __PlaceCardState();
}

class __PlaceCardState extends State<PlaceCard> {
  @override
  Widget build(BuildContext context) {
    DateTime? date;

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
                direction: (widget.visitDate == null)
                    ? DismissDirection.endToStart
                    : DismissDirection.none,
                onDismissed: (direction) {
                  BlocProvider.of<FavoritePlaceBloc>(context)
                      .add(TogglePlaceInFavorites(widget.place));
                },
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FavoriteCardTop(
                          place: widget.place,
                          visited: widget.visitDate != null,
                        ),
                        FavoriteCardBottom(
                          place: widget.place,
                          visitDate: widget.visitDate,
                        ),
                      ],
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                        onTap: () {
                          Navigator.of(context).push<dynamic>(
                            PageRouteBuilder<dynamic>(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return PlaceDetails(
                                  place: widget.place,
                                );
                              },
                              transitionDuration:
                                  const Duration(milliseconds: 200),
                              transitionsBuilder: (
                                context,
                                animation,
                                secondaryAnimation,
                                child,
                              ) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      right: 4,
                      child: Row(
                        children: [
                          // Action buttons : planned or share
                          Material(
                            color: Colors.transparent,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(50)),
                            clipBehavior: Clip.antiAlias,
                            child: IconButton(
                              onPressed: () async {
                                if (widget.visitDate == null ||
                                    widget.visitDate!.isAfter(DateTime.now())) {
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
                                        return PlaceCupertinoDatePicker(
                                          initialDateTime: widget.visitDate,
                                          onValueChanged: (newDate) {
                                            date = newDate;
                                          },
                                        );
                                      },
                                    ).whenComplete(
                                      () {
                                        BlocProvider.of<VisitedPlaceBloc>(
                                          context,
                                        ).add(
                                          AddPlaceToVisitedList(
                                            place: widget.place,
                                            date: date ?? DateTime.now(),
                                          ),
                                        );

                                        setState(() {});
                                      },
                                    );
                                  }
                                }
                              },
                              icon: SvgPicture.asset(
                                // If the scheduled date is not null, then...
                                (widget.visitDate == null ||
                                        widget.visitDate!
                                            .isAfter(DateTime.now()))
                                    ? iconCalendar
                                    : iconShare,
                                width: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),

                          const SizedBox(width: 2),

                          // Delete button.
                          // Not shown in the place card where the planned date of visit has already passed.
                          if (widget.visitDate != null)
                            const SizedBox.shrink()
                          else
                            Material(
                              color: Colors.transparent,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              clipBehavior: Clip.antiAlias,
                              child: IconButton(
                                onPressed: () {
                                  BlocProvider.of<FavoritePlaceBloc>(context)
                                      .add(
                                    TogglePlaceInFavorites(widget.place),
                                  );
                                },
                                icon: const Icon(
                                  Icons.clear_outlined,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          // : ,
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
}

class FavoriteCardTop extends StatefulWidget {
  final Place place;
  final bool visited;

  const FavoriteCardTop({
    required this.place,
    required this.visited,
    Key? key,
  }) : super(key: key);

  @override
  _FavoriteCardTopState createState() => _FavoriteCardTopState();
}

class _FavoriteCardTopState extends State<FavoriteCardTop> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Hero(
                tag: widget.place.id.toString(),
                child: CachedNetworkImage(
                  imageUrl: widget.place.urls.first,
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                        ),
                      ),
                    );
                  },
                  placeholder: (context, url) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  // ignore: avoid_annotating_with_dynamic
                  errorWidget: (context, url, dynamic error) {
                    return const ImagePlaceholder();
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      Category.getCategoryByType(widget.place.placeType).name,
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
      ),
    );
  }
}

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).secondaryHeaderColor,
      child: const Center(
        child: Icon(
          Icons.photo_size_select_actual_outlined,
          color: Colors.grey,
          size: 50.0,
        ),
      ),
    );
  }
}

class FavoriteCardBottom extends StatelessWidget {
  final Place place;
  final DateTime? visitDate;

  const FavoriteCardBottom({
    Key? key,
    required this.place,
    this.visitDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    initializeDateFormatting();

    var date = '';

    if (visitDate != null) {
      date = DateFormat(
        constants.textDateFormat,
        constants.textLocale,
      ).format(visitDate!).toString();
    }

    return Expanded(
      child: Container(
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
              place.name,
              maxLines: 2,
              style: Theme.of(context)
                  .textTheme
                  .headline1
                  ?.copyWith(fontSize: 16, fontWeight: FontWeight.w500),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 6),
            if (visitDate != null)
              if (visitDate!.isBefore(DateTime.now()))
                Text(
                  '${constants.textTheGoalIsAchieved} $date',
                  maxLines: 2,
                  style: const TextStyle(color: myLightSecondaryTwo),
                  overflow: TextOverflow.ellipsis,
                )
              else
                Text(
                  '${constants.textScheduledFor} $date',
                  maxLines: 2,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        color: Theme.of(context).colorScheme.primaryVariant,
                      ),
                  overflow: TextOverflow.ellipsis,
                ),
            const SizedBox(height: 4),
            Expanded(
              child: Text(
                place.description,
                maxLines: visitDate != null ? 1 : 2,
                style: const TextStyle(color: myLightSecondaryTwo),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
