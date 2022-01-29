import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/blocs/map/places_map_bloc.dart';
import 'package:places/data/cubits/theme/theme_cubit.dart';
import 'package:places/domain/location.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/constants.dart' as constants;
import 'package:places/ui/res/icons.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:places/data/blocs/geolocation/geolocation_bloc.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final MapObjectId cameraMapObjectId =
      const MapObjectId(constants.textCameraMapObjectId);

  final animation = const MapAnimation(
    type: MapAnimationType.smooth,
    duration: 2.0,
  );

  late YandexMapController controller;
  bool nightModeEnabled = false;

  @override
  Widget build(BuildContext context) {
    nightModeEnabled = context.read<ThemeCubit>().themeStatus;
    final style = constants.lightStyleYandexMap;
    final mapObjects = <Placemark>[
      Placemark(
        mapId: cameraMapObjectId,
        point: Point(
          latitude: constants.defaultLocation.lat,
          longitude: constants.defaultLocation.lng,
        ),
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(
              constants.pathIconPlusDark,
            ),
            scale: 3,
          ),
        ),
        opacity: 1,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          constants.textLocation,
          style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
        ),
        leadingWidth: 100,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            constants.textCancel,
            style: TextStyle(
              color: myLightSecondaryTwo,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              final cameraPosition = await controller.getCameraPosition();

              // ignore: use_build_context_synchronously
              Navigator.of(context).pop(
                Location(
                  lat: cameraPosition.target.latitude,
                  lng: cameraPosition.target.longitude,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Text(
                constants.textReady,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).colorScheme.primaryVariant,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 68,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                constants.textDescLocationScreen,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                BlocBuilder<PlacesMapBloc, PlacesMapState>(
                  buildWhen: (context, state) {
                    return state is LoadPlacesMapSuccess;
                  },
                  builder: (context, state) {
                    if (state is LoadPlacesMapSuccess) {
                      mapObjects.clear();

                      if (state.userPosition != null) {
                        mapObjects.add(
                          Placemark(
                            mapId: cameraMapObjectId,
                            point: Point(
                              latitude: state.userPosition!.latitude,
                              longitude: state.userPosition!.longitude,
                            ),
                            icon: PlacemarkIcon.single(
                              PlacemarkIconStyle(
                                image: BitmapDescriptor.fromAssetImage(
                                  nightModeEnabled
                                      ? constants.pathIconPlusLight
                                      : constants.pathIconPlusDark,
                                ),
                                scale: 3,
                              ),
                            ),
                            opacity: 1,
                          ),
                        );

                        controller.moveCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: mapObjects.first.point,
                              zoom: 14,
                            ),
                          ),
                          animation: animation,
                        );
                      }
                    }

                    return YandexMap(
                      mapObjects: mapObjects,
                      nightModeEnabled: nightModeEnabled,
                      onMapCreated: (yandexMapController) async {
                        final placemark = mapObjects
                            .firstWhere((el) => el.mapId == cameraMapObjectId);

                        controller = yandexMapController;
                        await controller.setMapStyle(style);

                        await controller.moveCamera(
                          CameraUpdate.newCameraPosition(
                            CameraPosition(
                              target: placemark.point,
                              zoom: 17,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                GeolocationButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class GeolocationButton extends StatelessWidget {
  const GeolocationButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeolocationBloc, GeolocationState>(
      builder: (context, state) {
        return Positioned(
          bottom: 26,
          right: 16,
          child: RawMaterialButton(
            onPressed: () async {
              if (state is LoadGeolocationSuccess) {
                BlocProvider.of<PlacesMapBloc>(context)
                    .add(const LoadPlacesMapEvent(defineUserLocation: true));
              } else {
                const snackBar = SnackBar(
                  content: Text(
                    constants.textGeolocationError,
                  ),
                );

                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
              }
            },
            shape: const CircleBorder(),
            fillColor: Theme.of(context).cardColor,
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            child: SvgPicture.asset(
              iconGeolocation,
              color: (state is LoadGeolocationSuccess)
                  ? Theme.of(context)
                      .bottomNavigationBarTheme
                      .unselectedItemColor
                  : myLightSecondaryTwo.withOpacity(0.56),
            ),
          ),
        );
      },
    );
  }
}
