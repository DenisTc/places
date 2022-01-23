import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:places/domain/location.dart';
import 'package:places/domain/theme_app.dart';
import 'package:places/services/location_service.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/icons.dart';
import 'package:provider/provider.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'package:places/ui/res/constants.dart' as constants;

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late YandexMapController controller;
  bool nightModeEnabled = false;
  final MapObjectId cameraMapObjectId = MapObjectId(constants.textCameraMapObjectId);
  final animation = const MapAnimation(
    type: MapAnimationType.smooth,
    duration: 2.0,
  );
  late List<MapObject> mapObjects = [
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
    )
  ];

  late String style = nightModeEnabled
      ? constants.darkStyleYandexMap
      : constants.lightStyleYandexMap;

  @override
  Widget build(BuildContext context) {
    nightModeEnabled = Provider.of<ThemeApp>(context).isDark;

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
          Container(
            height: 68,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                constants.textDescLocationScreen,
              ),
            ),
          ),
          Expanded(
            child: Stack(
              fit: StackFit.expand,
              children: [
                YandexMap(
                  mapObjects: mapObjects,
                  onCameraPositionChanged: (CameraPosition cameraPosition,
                      CameraUpdateReason _, bool __) async {
                    final placemark = mapObjects.firstWhere(
                        (el) => el.mapId == cameraMapObjectId) as Placemark;

                    setState(() {
                      mapObjects[mapObjects.indexOf(placemark)] =
                          placemark.copyWith(point: cameraPosition.target);
                    });
                  },
                  onMapCreated:
                      (YandexMapController yandexMapController) async {
                    final placemark = mapObjects.firstWhere(
                        (el) => el.mapId == cameraMapObjectId) as Placemark;

                    controller = yandexMapController;
                    controller.setMapStyle(style);

                    await controller.moveCamera(CameraUpdate.newCameraPosition(
                        CameraPosition(target: placemark.point, zoom: 14)));
                  },
                ),
                geolocationButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget geolocationButton() {
    return Positioned(
      bottom: 26,
      right: 16,
      child: RawMaterialButton(
        onPressed: () async {
          final permission = await LocationService.checkGeoPermission();
          if (permission != LocationPermission.denied &&
              permission != LocationPermission.deniedForever) {
            final location =
                await LocationService.getCurrentUserPosition(timeout: 15);
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
      ),
    );
  }
}
