import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:places/data/blocs/favorite_place/bloc/favorite_place_bloc.dart';
import 'package:places/data/blocs/visited_place/visited_place_bloc.dart';
import 'package:places/data/extensions/open_map_sheet.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/constants.dart' as constants;
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/res/styles.dart';
import 'package:places/ui/widgets/place_details_screen/photo_view.dart';

/// A screen with a detailed description of the place
class PlaceDetails extends StatelessWidget {
  final Place place;

  const PlaceDetails({
    required this.place,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _pageController = PageController();

    return Material(
      child: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.9,
          ),
          child: CustomScrollView(
            slivers: [
              _GalleryPlace(
                pageController: _pageController,
                place: place,
              ),
              _DescriptionPlace(place: place),
            ],
          ),
        ),
      ),
    );
  }
}

class _DescriptionPlace extends StatelessWidget {
  final Place place;

  const _DescriptionPlace({
    required this.place,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildListDelegate(
        [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _Description(place: place),
          ),
        ],
      ),
    );
  }
}

class _GalleryPlace extends StatefulWidget {
  final Place place;
  final PageController _pageController;

  const _GalleryPlace({
    required PageController pageController,
    required this.place,
    Key? key,
  })  : _pageController = pageController,
        super(key: key);

  @override
  State<_GalleryPlace> createState() => _GalleryPlaceState();
}

class _GalleryPlaceState extends State<_GalleryPlace> {
  double currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      automaticallyImplyLeading: false,
      expandedHeight: 360,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: widget.place.id.toString(),
          child: Container(
            height: 360,
            color: Colors.white,
            child: Stack(
              children: [
                if (widget.place.urls.isNotEmpty)
                  PageView.builder(
                    onPageChanged: (page) {
                      setState(() {
                        currentPage = page.toDouble();
                      });
                    },
                    allowImplicitScrolling: true,
                    physics: const ClampingScrollPhysics(),
                    controller: widget._pageController,
                    itemCount: widget.place.urls.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          if (widget.place.urls.isNotEmpty) {
                            Navigator.of(context).push<void>(
                              MaterialPageRoute(
                                builder: (context) => PhotoView(
                                  imageList: widget.place.urls,
                                  currentImage: 0,
                                ),
                              ),
                            );
                          }
                        },
                        child: _PlaceImage(
                          imgUrl: widget.place.urls[index],
                        ),
                      );
                    },
                  )
                else
                  Container(
                    color: Colors.white,
                    child: const Center(
                      child: Icon(
                        Icons.photo_size_select_actual_outlined,
                        color: Colors.grey,
                        size: 100.0,
                      ),
                    ),
                  ),
                const _ArrowBackButton(),
                if (widget.place.urls.length > 1)
                  PageIndicator(
                    countImages: widget.place.urls.length,
                    currentPage: currentPage,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  final int countImages;
  final double currentPage;

  const PageIndicator({
    required this.countImages,
    required this.currentPage,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const startIndicator = BorderRadius.only(
      topRight: Radius.circular(10),
      bottomRight: Radius.circular(10),
    );

    const endIndicator = BorderRadius.only(
      topLeft: Radius.circular(10),
      bottomLeft: Radius.circular(10),
    );

    const middleIndicator = BorderRadius.all(
      Radius.circular(10),
    );

    return Positioned(
      bottom: 0,
      child: Row(
        children: [
          for (int i = 0; i < countImages; i++)
            Container(
              height: 10,
              decoration: BoxDecoration(
                borderRadius: (currentPage == 0)
                    ? startIndicator
                    : (currentPage == countImages - 1)
                        ? endIndicator
                        : middleIndicator,
                color: i == currentPage
                    ? Theme.of(context)
                        .bottomNavigationBarTheme
                        .selectedItemColor
                    : Colors.transparent,
              ),
              width: MediaQuery.of(context).size.width / countImages,
            ),
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  final Place place;

  const _Description({
    required this.place,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Text(
                place.name,
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(fontSize: 24),
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          Category.getCategoryByType(place.placeType).name,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        const SizedBox(height: 24),
        Text(
          place.description,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(height: 24),
        CreateRouteButton(place: place),
        const SizedBox(height: 24),
        const Divider(
          height: 4,
          color: myLightSecondaryTwo,
        ),
        const SizedBox(height: 19),
        _FunctionButtons(place: place),
        const SizedBox(height: 11),
      ],
    );
  }
}

class _FunctionButtons extends StatefulWidget {
  final Place place;

  const _FunctionButtons({
    required this.place,
    Key? key,
  }) : super(key: key);

  @override
  State<_FunctionButtons> createState() => _FunctionButtonsState();
}

class _FunctionButtonsState extends State<_FunctionButtons> {
  DateTime? date;
  bool isUpdate = false;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<VisitedPlaceBloc>(context).add(LoadListVisitedPlaces());
    BlocProvider.of<FavoritePlaceBloc>(context).add(LoadListFavoritePlaces());
    initializeDateFormatting();

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: BlocBuilder<VisitedPlaceBloc, VisitedPlaceState>(
            builder: (context, state) {
              if (state is ListVisitedPlacesLoaded &&
                  state.visitedPlaces.isNotEmpty) {
                final visitedPlaces = state.visitedPlaces
                    .where((row) => row.place.id == widget.place.id);
                date =
                    visitedPlaces.isNotEmpty ? visitedPlaces.first.date : null;
              }

              if (date != null) {
                if (date!.isBefore(DateTime.now())) {
                  return TextButton(
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          iconShare,
                          color: Theme.of(context).iconTheme.color,
                        ),
                        const SizedBox(width: 9),
                        Text(
                          constants.textShare,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  );
                }

                return TextButton(
                  onPressed: shedulePlace,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        iconCalendarFilled,
                        color: Theme.of(context).colorScheme.primaryVariant,
                      ),
                      const SizedBox(width: 9),
                      Text(
                        DateFormat(
                          constants.textDateFormat,
                          constants.textLocale,
                        ).format(date!),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primaryVariant,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return TextButton(
                  onPressed: shedulePlace,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        iconCalendar,
                        color: Theme.of(context).iconTheme.color,
                      ),
                      const SizedBox(width: 9),
                      Text(
                        constants.textBtnSchedule,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
        Expanded(
          child: InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<FavoritePlaceBloc, FavoritePlaceState>(
                  buildWhen: (context, state) {
                    return state is ListFavoritePlacesLoaded;
                  },
                  builder: (context, state) {
                    if (state is ListFavoritePlacesLoaded) {
                      return Material(
                        color: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        clipBehavior: Clip.antiAlias,
                        child: TextButton.icon(
                          onPressed: () {
                            BlocProvider.of<FavoritePlaceBloc>(context)
                                .add(TogglePlaceInFavorites(widget.place));
                          },
                          icon: SvgPicture.asset(
                            state.places.contains(widget.place)
                                ? iconFavoriteSelected
                                : iconFavorite,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          label: Text(
                            state.places.contains(widget.place)
                                ? constants.textInFavorite
                                : constants.textToFavorite,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> shedulePlace() async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (builder) {
        return PlaceCupertinoDatePicker(
          initialDateTime: date,
          onValueChanged: (newDate) {
            date = newDate;
          },
        );
      },
    ).whenComplete(
      () {
        BlocProvider.of<VisitedPlaceBloc>(context).add(
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

class CreateRouteButton extends StatelessWidget {
  final Place place;
  const CreateRouteButton({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isVisited = false;

    return BlocBuilder<VisitedPlaceBloc, VisitedPlaceState>(
      builder: (context, state) {
        if (state is ListVisitedPlacesLoaded &&
            state.visitedPlaces.isNotEmpty) {
          final currentPlace =
              state.visitedPlaces.where((row) => row.place.id == place.id);

          isVisited = currentPlace.isNotEmpty &&
              currentPlace.first.date != null &&
              currentPlace.first.date!.isBefore(DateTime.now());
        }

        return Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  if (!isVisited) {
                    openMapsSheet(
                      context: context,
                      target: Coords(place.lat!, place.lng!),
                      name: place.name,
                    );
                    BlocProvider.of<VisitedPlaceBloc>(context).add(
                      AddPlaceToVisitedList(
                        place: place,
                        date: DateTime.now(),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: isVisited
                      ? Theme.of(context).primaryColor
                      : Theme.of(context).colorScheme.primaryVariant,
                  fixedSize: const Size(double.infinity, 48),
                  elevation: 0.0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      isVisited ? iconCheck : iconRoute,
                      width: 18,
                      color: isVisited
                          ? Theme.of(context).colorScheme.primaryVariant
                          : Colors.white,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      isVisited ? constants.textPassed : constants.textBtnRoute,
                      style: isVisited
                          ? disableGreenBtnTextStyle
                          : activeBtnTextStyle,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: isVisited ? 16 : 0),
            if (isVisited)
              ElevatedButton(
                onPressed: () {
                  openMapsSheet(
                    context: context,
                    target: Coords(place.lat!, place.lng!),
                    name: place.name,
                  );
                  BlocProvider.of<VisitedPlaceBloc>(context).add(
                    AddPlaceToVisitedList(
                      place: place,
                      date: DateTime.now(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.primaryVariant,
                  fixedSize: const Size(48, 48),
                  elevation: 0.0,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: SvgPicture.asset(
                  iconRoute,
                  width: 22,
                  height: 22,
                  color: Colors.white,
                ),
              )
            else
              const SizedBox.shrink(),
          ],
        );
      },
    );
  }
}

class _PlaceImage extends StatelessWidget {
  final String imgUrl;

  const _PlaceImage({
    required this.imgUrl,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
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
      errorWidget: (context, url, dynamic error) {
        return const ImagePlaceholder();
      },
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
      color: Colors.white,
      child: const Center(
        child: Icon(
          Icons.photo_size_select_actual_outlined,
          color: Colors.grey,
          size: 100.0,
        ),
      ),
    );
  }
}

class _ArrowBackButton extends StatelessWidget {
  const _ArrowBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16.0,
      right: 16.0,
      child: Material(
        color: Colors.transparent,
        child: SafeArea(
          child: InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Align(
                child: SvgPicture.asset(
                  iconClose,
                  height: 20,
                  width: 20,
                  color: myLightMain,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class PlaceCupertinoDatePicker extends StatelessWidget {
  final DateTime? initialDateTime;
  final ValueChanged<DateTime> onValueChanged;
  const PlaceCupertinoDatePicker({
    Key? key,
    required this.onValueChanged,
    this.initialDateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.secondary,
      height: 250,
      child: CupertinoTheme(
        data: CupertinoThemeData(
          textTheme: CupertinoTextThemeData(
            dateTimePickerTextStyle:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 18),
          ),
        ),
        child: CupertinoDatePicker(
          initialDateTime: initialDateTime ?? DateTime.now(),
          onDateTimeChanged: onValueChanged,
        ),
      ),
    );
  }
}
