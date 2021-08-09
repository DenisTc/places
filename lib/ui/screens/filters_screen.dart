import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domains/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/models/location.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/icons.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({Key? key}) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  final Location userPosition =
      Location(57.814183984654186, 28.347436646133506);

  late RangeValues currentRangeValues = const RangeValues(100, 10000);
  List<Sight> filteredPlaces = [];
  int countPlaces = 0;

  Map<String, bool> filters = {
    'отель': false,
    'ресторан': false,
    'особое место': false,
    'парк': false,
    'музей': false,
    'кафе': false,
  };

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

  refresh() {
    setState(() {
      countPlaces = countPlacesNear();
    });
  }

  updateRangeVal(newRangeValues) {
    setState(() {
      currentRangeValues = newRangeValues;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () {
            //Navigator.pop(context, filteredPlaces);
            Navigator.pop(context, mocks);
          },
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                filters.updateAll((key, value) => value = false);
                countPlaces = countPlacesNear();
              });
            },
            child: Text(
              'Очистить',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: lightGreen,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Категории'.toUpperCase(),
                    style: TextStyle(
                      color: textColorSecondary.withOpacity(0.56),
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
              const SizedBox(height: 60),
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
            Expanded(
              flex: 1,
              child: Text(
                'Расстояние',
                style: TextStyle(fontSize: 16),
              ),
            ),
            Expanded(
              flex: 1,
              child: RichText(
                textAlign: TextAlign.end,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'от ',
                        style: TextStyle(color: textColorSecondary)),
                    TextSpan(
                        text:
                            widget.currentRangeValues.start.round().toString(),
                        style: TextStyle(color: textColorSecondary)),
                    TextSpan(
                        text: ' до ',
                        style: TextStyle(color: textColorSecondary)),
                    TextSpan(
                        text: widget.currentRangeValues.end.round().toString(),
                        style: TextStyle(color: textColorSecondary)),
                    TextSpan(
                        text: ' м',
                        style: TextStyle(color: textColorSecondary)),
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
            onChanged: (RangeValues values) {
              setState(
                () {
                  //widget.currentRangeValues = values;
                  widget.updateRangeVal(values);
                  widget.notifyParent();
                },
              );
            },
          ),
        )
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
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        color: lightGreen,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Показать ('.toUpperCase() +
                    widget.countPlaces.toString() +
                    ')',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            onTap: () {
              Navigator.pop(context, widget.filteredPlaces);
            },
          )
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
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CategoryCircle(
              title: 'Отель',
              icon: SvgPicture.asset(
                iconHotel,
                height: 40,
                width: 40,
                color: lightGreen,
              ),
              notifyParent: widget.notifyParent,
              filters: widget.filters,
            ),
            _CategoryCircle(
              title: 'Ресторан',
              icon: SvgPicture.asset(
                iconCafe,
                height: 40,
                width: 40,
                color: lightGreen,
              ),
              notifyParent: widget.notifyParent,
              filters: widget.filters,
            ),
            _CategoryCircle(
              title: 'Особое место',
              icon: SvgPicture.asset(
                iconParticularPlace,
                height: 40,
                width: 40,
                color: lightGreen,
              ),
              notifyParent: widget.notifyParent,
              filters: widget.filters,
            ),
          ],
        ),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _CategoryCircle(
              title: 'Парк',
              icon: SvgPicture.asset(
                iconPark,
                height: 40,
                width: 40,
                color: lightGreen,
              ),
              notifyParent: widget.notifyParent,
              filters: widget.filters,
            ),
            _CategoryCircle(
              title: 'Музей',
              icon: SvgPicture.asset(
                iconMuseum,
                height: 40,
                width: 40,
                color: lightGreen,
              ),
              notifyParent: widget.notifyParent,
              filters: widget.filters,
            ),
            _CategoryCircle(
              title: 'Кафе',
              icon: SvgPicture.asset(
                iconCafe,
                height: 40,
                width: 40,
                color: lightGreen,
              ),
              notifyParent: widget.notifyParent,
              filters: widget.filters,
            ),
          ],
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
      borderRadius: BorderRadius.all(Radius.circular(40)),
      onTap: () {
        setState(() {
          widget.filters[widget.title.toLowerCase()] =
              !widget.filters[widget.title.toLowerCase()]!;
          widget.notifyParent();
        });
        //print(widget.filters);
      },
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              color: lightGreen.withOpacity(0.16),
              shape: BoxShape.circle,
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: widget.icon,
                  ),
                ),
                if (widget.filters[widget.title.toLowerCase()]!)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      padding: EdgeInsets.all(3),
                      height: 22,
                      width: 22,
                      decoration: BoxDecoration(
                        color: favoriteColor,
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
          Text(widget.title, style: TextStyle(fontSize: 16))
        ],
      ),
    );
  }
}
