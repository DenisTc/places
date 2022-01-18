import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/blocs/filter/bloc/filter_bloc.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/res/colors.dart';
import 'package:places/ui/res/constants.dart' as constants;
import 'package:places/ui/res/icons.dart';
import 'package:places/ui/widgets/network_exception.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    Key? key,
  }) : super(key: key);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  List<Place> filteredPlaces = [];
  int countPlaces = 0;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FilterBloc>(context).add(LoadFilterEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: Theme.of(context).iconTheme,
        actions: [
          TextButton(
            onPressed: () {
              BlocProvider.of<FilterBloc>(context).add(ClearFilterEvent());
            },
            child: Text(
              constants.textBtnClear,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.primaryVariant,
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
          child: BlocBuilder<FilterBloc, FilterState>(
            buildWhen: (context, state) {
              return state is LoadFilterCategoriesSuccess;
            },
            builder: (context, state) {
              if (state is LoadFilterCategoriesSuccess) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Text(
                            constants.textCategories,
                            style: TextStyle(
                              color: myLightSecondaryTwo.withOpacity(0.56),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      _FiltersCategory(
                        categories: state.categories,
                      ),
                      const SizedBox(height: 20),
                      _Distance(),
                      const SizedBox(height: 50),
                      _ShowButton(
                        countPlaces: countPlaces,
                        filteredPlaces: filteredPlaces,
                      ),
                    ],
                  ),
                );
              }

              if(state is LoadFilterCategoriesError){
                return const NetworkException();
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }
}

class _Distance extends StatefulWidget {
  const _Distance({Key? key}) : super(key: key);

  @override
  State<_Distance> createState() => _DistanceState();
}

class _DistanceState extends State<_Distance> {
  RangeValues _rangeValues = constants.defaultDistanceRange;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      builder: (context, state) {
        if (state is LoadFiltersSuccess) {
          _rangeValues = state.filter.distance!;
        }

        return Column(
          children: [
            Row(
              children: [
                const Expanded(
                  child: Text(
                    constants.textDistance,
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
                          text: _rangeValues.start.round().toString(),
                          style: const TextStyle(color: myLightSecondaryTwo),
                        ),
                        const TextSpan(
                          text: ' до ',
                          style: TextStyle(color: myLightSecondaryTwo),
                        ),
                        TextSpan(
                          text: _rangeValues.end.round().toString(),
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
                values: _rangeValues,
                max: constants.defaultDistanceRange.end,
                divisions: 100,
                onChanged: (value) {
                  setState(() {});

                  _rangeValues = value;

                  BlocProvider.of<FilterBloc>(context)
                      .add(UpdateFilterDistanceEvent(value));
                },
              ),
            ),
          ],
        );
      },
    );
  }
}

class _ShowButton extends StatelessWidget {
  final int countPlaces;
  final List<Place> filteredPlaces;
  const _ShowButton({
    required this.countPlaces,
    required this.filteredPlaces,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FilterBloc, FilterState>(
      buildWhen: (context, state) {
        return state is LoadCountFilteredPlacesSuccess;
      },
      builder: (context, state) {
        if (state is LoadCountFilteredPlacesSuccess) {
          int count = state.count;
          return ElevatedButton(
            onPressed: () {
              if (count != 0) {
                BlocProvider.of<FilterBloc>(context).add(SaveFilterEvent());
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              primary: count != 0
                  ? Theme.of(context).colorScheme.primaryVariant
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
                  '${constants.textBtnShow} ${count.toString()}',
                  style: TextStyle(
                    color: count != 0
                        ? Colors.white
                        : myLightSecondaryTwo.withOpacity(0.56),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          );
        } else if (state is LoadCountFilteredPlacesSuccess) {
          int count = state.count;
          return ElevatedButton(
            onPressed: () {
              if (count != 0) {
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(
              primary: count != 0
                  ? Theme.of(context).colorScheme.primaryVariant
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
                  '${constants.textBtnShow} ${count.toString()}',
                  style: TextStyle(
                    color: count != 0
                        ? Colors.white
                        : myLightSecondaryTwo.withOpacity(0.56),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          );
        }
        return ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
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
                constants.textBtnShow,
                style: TextStyle(
                  color: myLightSecondaryTwo.withOpacity(0.56),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _FiltersCategory extends StatefulWidget {
  final List<String>? categories;

  const _FiltersCategory({
    required this.categories,
    Key? key,
  }) : super(key: key);

  @override
  _FiltersCategoryState createState() => _FiltersCategoryState();
}

class _FiltersCategoryState extends State<_FiltersCategory> {
  @override
  Widget build(BuildContext context) {
    final displayHeight = MediaQuery.of(context).size.height;

    if (displayHeight > 580) {
      if (widget.categories != null) {
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: MediaQuery.of(context).size.width / 3,
            mainAxisSpacing: 30,
          ),
          itemCount: widget.categories!.length,
          itemBuilder: (context, index) {
            return _CategoryCircle(
              category: Category.getCategoryByType(widget.categories![index]),
            );
          },
        );
      }
    }

    return SizedBox(
      height: 100,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: widget.categories!.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _CategoryCircle(
            category: Category.getCategoryByType(widget.categories![index]),
          );
        },
      ),
    );
  }
}

class _CategoryCircle extends StatelessWidget {
  final Category category;

  const _CategoryCircle({
    required this.category,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final displayHeight = MediaQuery.of(context).size.height;
    final double iconSize = displayHeight > 600 ? 90 : 60;
    final double checkSize = displayHeight > 600 ? 22 : 17;

    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(40)),
      onTap: () {
        BlocProvider.of<FilterBloc>(context)
            .add(ToggleCategoryEvent(category.type.toLowerCase()));
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            height: iconSize,
            width: iconSize,
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primaryVariant
                  .withOpacity(0.16),
              shape: BoxShape.circle,
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Align(
                    child: SvgPicture.asset(
                      category.icon,
                      height: 40,
                      width: 40,
                      color: Theme.of(context).colorScheme.primaryVariant,
                    ),
                  ),
                ),
                BlocBuilder<FilterBloc, FilterState>(
                  buildWhen: (context, state) {
                    return state is LoadFiltersSuccess;
                  },
                  builder: (context, state) {
                    if (state is LoadFiltersSuccess) {
                      if (state.filter.typeFilter!
                          .contains(category.type.toLowerCase())) {
                        return IconCheck(checkSize: checkSize);
                      }
                    }
                    return SizedBox.shrink();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: Text(
              capitalize(category.name),
              softWrap: false,
              overflow: TextOverflow.fade,
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}

class IconCheck extends StatelessWidget {
  const IconCheck({
    Key? key,
    required this.checkSize,
  }) : super(key: key);

  final double checkSize;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
