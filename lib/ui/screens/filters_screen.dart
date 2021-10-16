import 'dart:math';
import 'package:places/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/data/model/filters.dart';
import 'package:places/data/model/location.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/constants.dart' as Constants;
import 'package:places/ui/screens/res/icons.dart';

List<String> selectFilters = [];
RangeValues distanceRangeValues = Constants.defaultDistanceRange;
const Location userPosition = Constants.userLocation;

class FiltersScreen extends StatefulWidget {
  final Filters filters;
  const FiltersScreen({
    Key? key,
    required this.filters,
  }) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  List<Place> filteredPlaces = [];
  int countPlaces = 0;

  Map<String, bool> filters = {};

  @override
  Widget build(BuildContext context) {
    filters = widget.filters.categories;
    distanceRangeValues = widget.filters.distanceRangeValues;
    setState(() {});

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                filters.updateAll((key, value) => value = false);
                widget.filters.distanceRangeValues =
                    Constants.defaultDistanceRange;
                selectFilters.clear();
              });
            },
            child: Text(
              'Очистить',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).buttonColor,
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'КАТЕГОРИИ',
                    style: TextStyle(
                      color: myLightSecondaryTwo.withOpacity(0.56),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _FiltersCategory(
                notifyParent: () {
                  setState(() {});
                },
                filters: filters,
              ),
              const SizedBox(height: 20),
              _Distance(
                distanceRangeValues: distanceRangeValues,
                updateRangeVal: (distanceRangeValues) {
                  updateRangeVal(distanceRangeValues);
                },
              ),
              const SizedBox(height: 50),
              _ShowButton(
                countPlaces: countPlaces,
                filteredPlaces: filteredPlaces,
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool calculateDistance(Place place) {
    double ky = 40000 / 360;
    double kx = cos(pi * userPosition.lat / 180.0) * ky;
    double dx = (userPosition.lng - place.lng!).abs() * kx;
    double dy = (userPosition.lat - place.lat!).abs() * ky;
    double distance = sqrt(dx * dx + dy * dy) * 1000;

    return (distanceRangeValues.start <= distance) &&
        (distance <= distanceRangeValues.end);
  }

  void updateRangeVal(RangeValues newRangeValues) {
    setState(() {
      widget.filters.distanceRangeValues = newRangeValues;
    });
  }
}

class _Distance extends StatefulWidget {
  final Function(RangeValues rangeValues) updateRangeVal;
  final RangeValues distanceRangeValues;

  const _Distance({
    Key? key,
    required this.updateRangeVal,
    required this.distanceRangeValues,
  }) : super(key: key);

  @override
  __DistanceState createState() => __DistanceState();
}

class __DistanceState extends State<_Distance> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
              child: Text(
                'Расстояние',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              child: RichText(
                textAlign: TextAlign.end,
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'от ',
                      style: TextStyle(color: myLightSecondaryTwo),
                    ),
                    TextSpan(
                      text: widget.distanceRangeValues.start.round().toString(),
                      style: const TextStyle(color: myLightSecondaryTwo),
                    ),
                    const TextSpan(
                      text: ' до ',
                      style: TextStyle(color: myLightSecondaryTwo),
                    ),
                    TextSpan(
                      text: widget.distanceRangeValues.end.round().toString(),
                      style: const TextStyle(color: myLightSecondaryTwo),
                    ),
                    const TextSpan(
                      text: ' м',
                      style: TextStyle(color: myLightSecondaryTwo),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: MediaQuery.of(context).size.width - 32,
          child: RangeSlider(
            values: widget.distanceRangeValues,
            max: 10000,
            divisions: 100,
            onChanged: (values) {
              widget.updateRangeVal(values);
            },
          ),
        ),
      ],
    );
  }
}

class _ShowButton extends StatefulWidget {
  final int countPlaces;
  final List<Place> filteredPlaces;
  const _ShowButton({
    Key? key,
    required this.countPlaces,
    required this.filteredPlaces,
  }) : super(key: key);

  @override
  __ShowButtonState createState() => __ShowButtonState();
}

class __ShowButtonState extends State<_ShowButton> {
  @override
  Widget build(BuildContext context) {
    var countPlaces = 0;
    final listPlaces = getPlaces(
      selectFilters,
      distanceRangeValues.start,
      distanceRangeValues.end,
    );
    return FutureBuilder<List<PlaceDto>>(
      future: listPlaces,
      builder: (context, snapshot) {
        if (snapshot.hasData && !snapshot.hasError) {
          countPlaces = snapshot.data!.length;
          return ElevatedButton(
            onPressed: () {
              if (countPlaces != 0) {
                Navigator.pop(context, listPlaces);
              }
            },
            style: ElevatedButton.styleFrom(
              primary: countPlaces != 0
                  ? Theme.of(context).buttonColor
                  : Theme.of(context).primaryColor,
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
                Text(
                  'ПОКАЗАТЬ ($countPlaces)',
                  style: TextStyle(
                    color: countPlaces != 0
                        ? Colors.white
                        : myLightSecondaryTwo.withOpacity(0.56),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<List<PlaceDto>> getPlaces(
    List<String> selectFilters,
    double distanceStart,
    double distanceEnd,
  ) async {
    final placesList = await searchInteractor.searchPlaces(
      lat: userPosition.lat,
      lng: userPosition.lng,
      radius: 10000,
      typeFilter: selectFilters,
    );

    final _filredPlaces = <PlaceDto>[];

    for (final place in placesList) {
      if (place.distance! >= distanceStart) {
        _filredPlaces.add(place);
      }
    }

    return _filredPlaces;
  }
}

class _FiltersCategory extends StatefulWidget {
  final Function() notifyParent;
  final Map<String, bool> filters;

  const _FiltersCategory({
    Key? key,
    required this.notifyParent,
    required this.filters,
  }) : super(key: key);

  @override
  _FiltersCategoryState createState() => _FiltersCategoryState();
}

class _FiltersCategoryState extends State<_FiltersCategory> {
  final Future<List<String>> categoriesList = searchInteractor.getCategories();

  @override
  Widget build(BuildContext context) {
    final displayHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        FutureBuilder<List<String>>(
          future: categoriesList,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData && !snapshot.hasError) {
              if (displayHeight > 580) {
                return GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
                    mainAxisSpacing: 30,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return _CategoryCircle(
                      title: snapshot.data![index],
                      icon: SvgPicture.asset(
                        iconParticularPlace,
                        height: 40,
                        width: 40,
                        color: Theme.of(context).buttonColor,
                      ),
                      notifyParent: widget.notifyParent,
                      filters: widget.filters,
                    );
                  },
                );
              } else {
                return SizedBox(
                  height: 100,
                  width: MediaQuery.of(context).size.width,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return _CategoryCircle(
                        title: snapshot.data![index],
                        icon: SvgPicture.asset(
                          iconParticularPlace,
                          height: 40,
                          width: 40,
                          color: Theme.of(context).buttonColor,
                        ),
                        notifyParent: widget.notifyParent,
                        filters: widget.filters,
                      );
                    },
                  ),
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ],
    );
  }
}

class _CategoryCircle extends StatefulWidget {
  final String title;
  final SvgPicture icon;
  final Function() notifyParent;
  final Map<String, bool> filters;

  const _CategoryCircle({
    Key? key,
    required this.title,
    required this.icon,
    required this.notifyParent,
    required this.filters,
  }) : super(key: key);

  @override
  __CategoryCircleState createState() => __CategoryCircleState();
}

class __CategoryCircleState extends State<_CategoryCircle> {
  @override
  Widget build(BuildContext context) {
    final displayHeight = MediaQuery.of(context).size.height;
    final double iconSize = displayHeight > 600 ? 90 : 60;
    final double checkSize = displayHeight > 600 ? 22 : 17;

    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(40)),
      onTap: () {
        setState(() {
          if (selectFilters.contains(widget.title.toLowerCase())) {
            selectFilters.remove(widget.title.toLowerCase());
          } else {
            selectFilters.add(widget.title.toLowerCase());
          }
          widget.notifyParent();
        });
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: iconSize,
            width: iconSize,
            decoration: BoxDecoration(
              color: Theme.of(context).buttonColor.withOpacity(0.16),
              shape: BoxShape.circle,
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    child: widget.icon,
                  ),
                ),
                if (selectFilters.contains(widget.title.toLowerCase()))
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      height: checkSize,
                      width: checkSize,
                      decoration: BoxDecoration(
                        color: Theme.of(context).secondaryHeaderColor,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        iconCheck,
                        color: Theme.of(context).accentColor,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              widget.title,
              softWrap: false,
              overflow: TextOverflow.fade,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
