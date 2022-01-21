import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:map_launcher/map_launcher.dart';

openMapsSheet({
  required BuildContext context,
  required Coords target,
  required String name,
}) async {
  try {
    final coords = target;
    final title = name;
    final availableMaps = await MapLauncher.installedMaps;

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.white,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Container(
                    width: 30,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.all(
                        Radius.circular(12.0),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    child: Wrap(
                      children: <Widget>[
                        for (var map in availableMaps)
                          ListTile(
                            onTap: () => map.showMarker(
                              coords: coords,
                              title: title,
                            ),
                            title: Text(map.mapName),
                            leading: SvgPicture.asset(
                              map.icon,
                              height: 30.0,
                              width: 30.0,
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
      },
    );
  } catch (e) {
    print(e);
  }
}
