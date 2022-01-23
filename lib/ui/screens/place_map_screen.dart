import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:places/data/blocs/favorite_place/bloc/favorite_place_bloc.dart';
import 'package:places/data/blocs/map/places_map_bloc.dart';
import 'package:places/data/blocs/visited_place/visited_place_bloc.dart';
import 'package:places/data/extensions/open_map_sheet.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/place.dart';
import 'package:places/domain/theme_app.dart';
import 'package:places/services/location_service.dart';
import 'package:places/ui/res/constants.dart' as constants;
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/screens/place_details_screen.dart';
import 'package:places/ui/widgets/list_screen/add_place_button.dart';
import 'package:places/ui/widgets/list_screen/search_bar.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class PlaceMapScreen extends StatefulWidget {
  const PlaceMapScreen({Key? key}) : super(key: key);

  @override
  State<PlaceMapScreen> createState() => _PlaceMapScreenState();
}

class _PlaceMapScreenState extends State<PlaceMapScreen>
    with AutomaticKeepAliveClientMixin {
  final MapObjectId cameraMapObjectId = MapObjectId(constants.textCameraMapObjectId);
  final animation = const MapAnimation(
    type: MapAnimationType.smooth,
    duration: 2.0,
  );
  final List<MapObject> mapObjects = [];

  bool nightModeEnabled = false;
  int? selectedPlaceId;
  Placemark? userPmk;

  late YandexMapController controller;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    BlocProvider.of<PlacesMapBloc>(context).add(LoadPlacesMapEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final String style = nightModeEnabled
        ? constants.darkStyleYandexMap
        : constants.lightStyleYandexMap;

    nightModeEnabled = Provider.of<ThemeApp>(context).isDark;

    return Scaffold(
      appBar: const MapAppBar(),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: 8.0,
                right: 16.0,
                bottom: 14,
                left: 16.0,
              ),
              child: SearchBar(),
            ),
            Expanded(
              child: Stack(
                children: [
                  BlocBuilder<PlacesMapBloc, PlacesMapState>(
                    buildWhen: (context, state) {
                      return state is LoadPlacesMapSuccess;
                    },
                    builder: (context, state) {
                      if (state is LoadPlacesMapSuccess) {
                        mapObjects.clear();
                        if (userPmk != null) {
                          mapObjects.add(userPmk!);
                        }
                        state.places.forEach(
                          (place) {
                            mapObjects.add(placePlacemark(place));
                          },
                        );

                        return YandexMap(
                          mapObjects: mapObjects,
                          nightModeEnabled: nightModeEnabled,
                          onMapCreated:
                              (YandexMapController yandexMapController) async {
                            final defaultPosition =
                                mapObjects.first as Placemark;

                            controller = yandexMapController;
                            controller.setMapStyle(style);

                            await controller.moveCamera(
                              CameraUpdate.newCameraPosition(
                                CameraPosition(
                                  target: defaultPosition.point,
                                  zoom: 14,
                                ),
                              ),
                            );
                          },
                        );
                      }

                      return SizedBox.shrink();
                    },
                  ),
                  Positioned(
                    width: MediaQuery.of(context).size.width,
                    bottom: 16,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              refreshButton(),
                              selectedPlaceId == null
                                  ? AddPlaceButton()
                                  : SizedBox.shrink(),
                              geolocationButton(),
                            ],
                          ),
                          const MapPlaceCard(),
                        ],
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

  RawMaterialButton geolocationButton() {
    return RawMaterialButton(
      onPressed: () async {
        LocationService.checkGeoPermission();
        Future.delayed(Duration(seconds: 5));
        final permission = await LocationService.checkGeoPermission();
        if (permission != LocationPermission.denied &&
            permission != LocationPermission.deniedForever) {
          final location =
              await LocationService.getCurrentUserPosition(timeout: 15);
          setState(() {
            userPmk = userPlacemark(
              lat: location.latitude,
              lng: location.longitude,
            );
          });

          controller.moveCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: Point(
                  latitude: location.latitude,
                  longitude: location.longitude,
                ),
              ),
            ),
            animation: animation,
          );
        } else {
          const snackBar = SnackBar(
            content: Text(
              constants.textGeolocationError,
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      shape: CircleBorder(),
      fillColor: Theme.of(context).cardColor,
      constraints: BoxConstraints(minWidth: 48, minHeight: 48),
      child: SvgPicture.asset(
        iconGeolocation,
        color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      ),
    );
  }

  RawMaterialButton refreshButton() {
    return RawMaterialButton(
      onPressed: () {
        BlocProvider.of<PlacesMapBloc>(context).add(LoadPlacesMapEvent());
      },
      shape: CircleBorder(),
      fillColor: Theme.of(context).cardColor,
      constraints: BoxConstraints(minWidth: 48, minHeight: 48),
      child: SvgPicture.asset(
        iconRefresh,
        color: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
      ),
    );
  }

  Placemark placePlacemark(Place place) {
    final isSelectedPlace = selectedPlaceId == place.id;
    return Placemark(
      onTap: (Placemark self, Point point) {
        selectedPlaceId = place.id;
        setState(() {});
        BlocProvider.of<PlacesMapBloc>(context).add(LoadPlaceCardEvent(place));
      },
      mapId: MapObjectId(place.id.toString()),
      point: Point(
        latitude: place.lat!,
        longitude: place.lng!,
      ),
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(
            isSelectedPlace
                ? constants.pathIconSelectedPlaceMap
                : nightModeEnabled
                    ? constants.pathIconLightDotMap
                    : constants.pathIconDarkDotMap,
          ),
          scale: isSelectedPlace ? 2 : 4,
        ),
      ),
      opacity: 1,
    );
  }

  Placemark userPlacemark({
    required double lat,
    required double lng,
  }) {
    return Placemark(
      mapId: MapObjectId('camera_placemark'),
      point: Point(
        latitude: lat,
        longitude: lng,
      ),
      icon: PlacemarkIcon.single(
        PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(constants.pathIconUserMap),
          scale: 2,
        ),
      ),
      opacity: 1,
    );
  }
}

class MapPlaceCard extends StatefulWidget {
  const MapPlaceCard({Key? key}) : super(key: key);

  @override
  State<MapPlaceCard> createState() => _MapPlaceCardState();
}

class _MapPlaceCardState extends State<MapPlaceCard> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlacesMapBloc, PlacesMapState>(
      buildWhen: (context, state) {
        return state is LoadPlaceCardSuccess || state is HidePlaceCardState;
      },
      builder: (context, state) {
        if (state is LoadPlaceCardSuccess) {
          BlocProvider.of<FavoritePlaceBloc>(context)
              .add(LoadListFavoritePlaces());
          final place = state.place;

          return Dismissible(
            key: ValueKey(place),
            direction: DismissDirection.down,
            resizeDuration: const Duration(milliseconds: 1),
            onDismissed: (direction) {
              BlocProvider.of<PlacesMapBloc>(context).add(HidePlaceCardEvent());
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Container(
                height: 170,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Hero(
                  tag: place.id.toString(),
                  child: Stack(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16)),
                          onTap: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) {
                                  return PlaceDetails(place: place);
                                },
                                transitionDuration: Duration(milliseconds: 200),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: Column(
                            children: [
                              // Card Top
                              Expanded(
                                flex: 3,
                                child: Material(
                                  color: Colors.transparent,
                                  child: Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(16),
                                            topRight: Radius.circular(16),
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.only(
                                                topLeft: Radius.circular(16),
                                                topRight: Radius.circular(16),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl: place.urls.first,
                                                fadeOutDuration: const Duration(
                                                    milliseconds: 200),
                                                imageBuilder:
                                                    (context, imageProvider) {
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
                                                  return Center(
                                                    child: Icon(
                                                      Icons
                                                          .photo_size_select_actual_outlined,
                                                      color: Colors.grey[300],
                                                      size: 70.0,
                                                    ),
                                                  );
                                                },
                                                errorWidget:
                                                    (context, url, error) {
                                                  return const ImagePlaceholder();
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 8,
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              Category.getCategoryByType(
                                                      place.placeType)
                                                  .name,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                            BlocBuilder<FavoritePlaceBloc,
                                                FavoritePlaceState>(
                                              buildWhen: (context, state) {
                                                return state !=
                                                    ListFavoritePlacesLoaded;
                                              },
                                              builder: (context, state) {
                                                if (state
                                                    is ListFavoritePlacesLoaded) {
                                                  return Material(
                                                    color: Colors.transparent,
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                50)),
                                                    clipBehavior:
                                                        Clip.antiAlias,
                                                    child: GestureDetector(
                                                      onTap: () {
                                                        BlocProvider.of<
                                                                    FavoritePlaceBloc>(
                                                                context)
                                                            .add(
                                                          TogglePlaceInFavorites(
                                                              place),
                                                        );
                                                      },
                                                      child: AnimatedSwitcher(
                                                        duration:
                                                            const Duration(
                                                          milliseconds: 400,
                                                        ),
                                                        child: SvgPicture.asset(
                                                          state.places.contains(
                                                                  place)
                                                              ? iconFavoriteSelected
                                                              : iconFavorite,
                                                          key: UniqueKey(),
                                                          width: 24,
                                                          height: 24,
                                                          color: Colors.white,
                                                        ),
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
                                      Positioned(
                                        top: 6,
                                        child: Container(
                                          width: 30,
                                          height: 5,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[50],
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(12.0),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              // Card Bottom
                              Expanded(
                                flex: 2,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      bottomLeft: Radius.circular(16),
                                      bottomRight: Radius.circular(16),
                                    ),
                                    color: Theme.of(context).cardColor,
                                  ),
                                  width: MediaQuery.of(context).size.width,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // Place description
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                place.name,
                                                maxLines: 1,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headline1
                                                    ?.copyWith(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 2),
                                              Text(
                                                place.description,
                                                maxLines: 1,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ],
                                          ),
                                        ),
                                        // RouteButton
                                        ElevatedButton(
                                          onPressed: () {
                                            openMapsSheet(
                                              context: context,
                                              target: Coords(
                                                place.lat!,
                                                place.lng!,
                                              ),
                                              name: place.name,
                                            );

                                            BlocProvider.of<VisitedPlaceBloc>(
                                                    context)
                                                .add(
                                              AddPlaceToVisitedList(
                                                place: place,
                                                date: DateTime.now(),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            minimumSize: Size.zero,
                                            padding: EdgeInsets.zero,
                                            primary: Theme.of(context)
                                                .colorScheme
                                                .primaryVariant,
                                            fixedSize: const Size(40, 40),
                                            elevation: 0.0,
                                            shadowColor: Colors.transparent,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                          child: SvgPicture.asset(
                                            iconRoute,
                                            width: 22,
                                            height: 22,
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }

        return SizedBox.shrink();
      },
    );
  }
}

class MapAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56);

  const MapAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        constants.textMap,
        style: TextStyle(
          color: Theme.of(context).secondaryHeaderColor,
        ),
      ),
    );
  }
}
