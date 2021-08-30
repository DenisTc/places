import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domains/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/models/filters.dart';
import 'package:places/models/location.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/icons.dart';

class FiltersScreen extends StatefulWidget {
  final Filters filters;
  const FiltersScreen({Key? key, required this.filters}) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  final Location userPosition =
      const Location(57.814183984654186, 28.347436646133506);

  RangeValues currentRangeValues = const RangeValues(100, 10000);
  List<Sight> filteredPlaces = [];
  int countPlaces = 0;

  Map<String, bool> filters = {};

  bool calculateDistance(
    Sight place,
  ) {
    double ky = 40000 / 360;
    double kx = cos(pi * userPosition.lat / 180.0) * ky;
    double dx = (userPosition.lon - place.lon).abs() * kx;
    double dy = (userPosition.lat - place.lat).abs() * ky;
    double distance = sqrt(dx * dx + dy * dy) * 1000;

    return (currentRangeValues.start <= distance) &&
        (distance <= currentRangeValues.end);
  }

  int countPlacesNear() {
    filteredPlaces = [];
    bool inAria = false;
    bool inCategory = false;

    for (Sight place in mocks) {
      inAria = calculateDistance(place);
      inCategory = filters[place.type.toLowerCase()]!;

      if (inAria && inCategory) {
        filteredPlaces.add(place);
      } else if (filteredPlaces.contains(place) && !inCategory) {
        filteredPlaces.remove(place);
      }
    }
    return filteredPlaces.length;
  }

  @override
  Widget build(BuildContext context) {
    filters = widget.filters.categories;
    currentRangeValues = widget.filters.currentRangeValues;
    refresh();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            filters.updateAll((key, value) => value = false);
            widget.filters.currentRangeValues = const RangeValues(100, 10000);
            countPlaces = countPlacesNear();
            Navigator.pop(context, mocks);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                filters.updateAll((key, value) => value = false);
                widget.filters.currentRangeValues =
                    const RangeValues(100, 10000);
                countPlaces = countPlacesNear();
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
                  refresh();
                },
                filters: filters,
              ),
              const SizedBox(height: 20),
              _Distance(
                notifyParent: () {
                  refresh();
                },
                currentRangeValues: currentRangeValues,
                updateRangeVal: (currentRangeValues) {
                  updateRangeVal(currentRangeValues);
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

    void refresh() {
    setState(() {
      countPlaces = countPlacesNear();
    });
  }

  void updateRangeVal(RangeValues newRangeValues) {
    setState(() {
      widget.filters.currentRangeValues = newRangeValues;
    });
  }
}

class _Distance extends StatefulWidget {
  final Function() notifyParent;
  final Function(RangeValues rangeValues) updateRangeVal;
  final RangeValues currentRangeValues;

  const _Distance({
    Key? key,
    required this.notifyParent,
    required this.updateRangeVal,
    required this.currentRangeValues,
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
          mainAxisSize: MainAxisSize.max,
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
                      text: widget.currentRangeValues.start.round().toString(),
                      style: const TextStyle(color: myLightSecondaryTwo),
                    ),
                    const TextSpan(
                      text: ' до ',
                      style: TextStyle(color: myLightSecondaryTwo),
                    ),
                    TextSpan(
                      text: widget.currentRangeValues.end.round().toString(),
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
        Container(
          width: MediaQuery.of(context).size.width - 32,
          child: RangeSlider(
            values: widget.currentRangeValues,
            min: 100,
            max: 10000,
            divisions: 100,
            onChanged: (values) {
              setState(
                () {
                  widget.updateRangeVal(values);
                  widget.notifyParent();
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _ShowButton extends StatefulWidget {
  final int countPlaces;
  final List<Sight> filteredPlaces;
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
    return ElevatedButton(
      onPressed: () {
        if (widget.countPlaces != 0) {
          Navigator.pop(context, widget.filteredPlaces);
        }
      },
      style: ElevatedButton.styleFrom(
        primary: widget.countPlaces != 0 ? Theme.of(context).buttonColor : myLightBackground,
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
            'ПОКАЗАТЬ (${widget.countPlaces})',
            style: TextStyle(
              color: widget.countPlaces != 0
                  ? Colors.white
                  : myLightSecondaryTwo.withOpacity(0.56),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
            mainAxisSpacing: 30,
          ),
          itemCount: mocks.length,
          itemBuilder: (BuildContext context, int index) {
            final category = mocks[index];
            return _CategoryCircle(
              title: category.type,
              icon: SvgPicture.asset(
                category.icon != null ? category.icon! : iconParticularPlace,
                height: 40,
                width: 40,
                color: Theme.of(context).buttonColor,
              ),
              notifyParent: widget.notifyParent,
              filters: widget.filters,
            );
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
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(40)),
      onTap: () {
        setState(() {
          widget.filters[widget.title.toLowerCase()] =
              !widget.filters[widget.title.toLowerCase()]!;
          widget.notifyParent();
        });
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: 90,
            width: 90,
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
                if (widget.filters[widget.title.toLowerCase()]!)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: const EdgeInsets.all(3),
                      height: 22,
                      width: 22,
                      decoration: const BoxDecoration(
                        color: myLightMain,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset(
                        iconCheck,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.title,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
