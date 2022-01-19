import 'package:flutter/material.dart';
import 'package:places/ui/res/constants.dart' as constants;
import 'package:yandex_mapkit/yandex_mapkit.dart';

class PlaceMapScreen extends StatefulWidget {
  const PlaceMapScreen({Key? key}) : super(key: key);

  @override
  State<PlaceMapScreen> createState() => _PlaceMapScreenState();
}

class _PlaceMapScreenState extends State<PlaceMapScreen> {
  @override
  Widget build(BuildContext context) {
    late YandexMapController controller;

    final MapObjectId cameraMapObjectId = MapObjectId('camera_placemark');
    late final List<MapObject> mapObjects = [
      Placemark(
        mapId: cameraMapObjectId,
        point: Point(latitude: 57.817029184, longitude: 28.339347297),
        icon: PlacemarkIcon.single(
          PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(constants.pathIconPlaceMap),
            scale: 2,
          ),
        ),
        opacity: 3,
      )
    ];

    return Scaffold(
      appBar: const MapAppBar(),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Stack(
        children: [
          YandexMap(
            mapObjects: mapObjects,
            onCameraPositionChanged:
                (CameraPosition cameraPosition, _, __) async {
              final placemark =
                  mapObjects.firstWhere((el) => el.mapId == cameraMapObjectId)
                      as Placemark;

              setState(() {
                mapObjects[mapObjects.indexOf(placemark)] =
                    placemark.copyWith(point: cameraPosition.target);
              });
            },
            onMapCreated: (YandexMapController yandexMapController) async {
              final placemark =
                  mapObjects.firstWhere((el) => el.mapId == cameraMapObjectId)
                      as Placemark;

              controller = yandexMapController;

              await controller.moveCamera(CameraUpdate.newCameraPosition(
                  CameraPosition(target: placemark.point, zoom: 15)));
            },
          ),
        ],
      ),
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
