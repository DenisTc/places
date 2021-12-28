import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/redux/action/favorite_places_action.dart';
import 'package:places/data/redux/action/place_action.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/data/redux/state/favorite_places_state.dart';
import 'package:places/data/redux/state/place_state.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/constants.dart' as constants;
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/res/styles.dart';
import 'package:places/ui/screens/place_map_screen.dart';
import 'package:places/ui/widgets/network_exception.dart';
import 'package:places/ui/widgets/place_cupertino_date_picker.dart';
import 'package:places/ui/widgets/place_details_screen/photo_view.dart';

/// A screen with a detailed description of the place
class PlaceDetails extends StatelessWidget {
  final int id;

  const PlaceDetails({
    required this.id,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PageController _pageController = PageController();

    return Material(
      child: Container(
        color: Theme.of(context).colorScheme.secondary,
        child: StoreConnector<AppState, PlaceState>(
          onInit: (store) {
            store.dispatch(LoadPlaceDetailsAction(id));
          },
          converter: (store) {
            return store.state.placeState;
          },
          builder: (BuildContext context, PlaceState vm) {
            if (vm is PlaceLoadingState) {
              return Center(child: CircularProgressIndicator());
            }

            if (vm is PlaceErrorState) {
              return const NetworkException();
            }

            if (vm is PlaceDataState) {
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                child: CustomScrollView(
                  slivers: [
                    _GalleryPlace(
                      pageController: _pageController,
                      place: vm.place,
                    ),
                    _DescriptionPlace(place: vm.place),
                  ],
                ),
              );
            }

            return SizedBox.shrink();
          },
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
        background: Container(
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
        const _CreateRouteButton(),
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

class _FunctionButtons extends StatelessWidget {
  final Place place;

  _FunctionButtons({
    required this.place,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            onTap: () async {
              await showModalBottomSheet<void>(
                context: context,
                builder: (builder) {
                  return const PlaceCupertinoDatePicker();
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                const SizedBox(width: 14),
              ],
            ),
          ),
        ),
        Expanded(
          child: InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StoreConnector<AppState, FavoritePlacesState>(
                  onInit: (store) {
                    store.dispatch(LoadFavoritePlacesAction());
                  },
                  converter: (store) {
                    return store.state.favoritePlacesState;
                  },
                  builder: (BuildContext context, FavoritePlacesState vm) {
                    if (vm is FavoritePlacesLoadingState) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: CircularProgressIndicator(color: Colors.green),
                      );
                    }

                    if (vm is FavoritePlacesDataState) {
                      return Material(
                        color: Colors.transparent,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        clipBehavior: Clip.antiAlias,
                        child: TextButton.icon(
                          onPressed: () {
                            StoreProvider.of<AppState>(context)
                                .dispatch(ToggleInFavoriteAction(place));
                          },
                          icon: SvgPicture.asset(
                            vm.places.contains(place)
                                ? iconFavoriteSelected
                                : iconFavorite,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          label: Text(
                            vm.places.contains(place)
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
}

class _CreateRouteButton extends StatelessWidget {
  const _CreateRouteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute(
            builder: (context) => const PlaceMapScreen(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        primary: Theme.of(context).colorScheme.primaryVariant,
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
            iconRoute,
            width: 22,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            constants.textBtnRoute,
            style: activeBtnTextStyle,
          ),
        ],
      ),
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
    return imgUrl.isNotEmpty
        ? Image.network(
            imgUrl,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            loadingBuilder: (context, child, loadingProgress) {
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
            errorBuilder: (context, error, stackTrace) {
              return const ImagePlaceholder();
            },
          )
        : const ImagePlaceholder();
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
    );
  }
}