import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mwwm/mwwm.dart';
import 'package:places/domain/category.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/constants.dart' as constants;
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/place_category_screen/place_category_screen_wm.dart';
import 'package:places/ui/widgets/network_exception.dart';
import 'package:relation/relation.dart';

class PlaceCategoryScreen
    extends CoreMwwmWidget<PlaceCategoryScreenWidgetModel> {
  final String? placeType;

  PlaceCategoryScreen([this.placeType])
      : super(widgetModelBuilder: PlaceCategoryScreenWidgetModel.builder);

  @override
  WidgetState<CoreMwwmWidget<PlaceCategoryScreenWidgetModel>,
          PlaceCategoryScreenWidgetModel>
      createWidgetState() => _PlaceCategoryScreenState();
}

class _PlaceCategoryScreenState
    extends WidgetState<PlaceCategoryScreen, PlaceCategoryScreenWidgetModel> {
  String? selectedType;
  @override
  void initState() {
    super.initState();
    selectedType = widget.placeType;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Column(
        children: [
          const SizedBox(height: 24),
          Expanded(
            child: Scrollbar(
              child: EntityStateBuilder<List<String>>(
                streamedState: wm.categoriesState,
                builder: (ctx, places) {
                  return ListView.builder(
                    itemCount: places.length,
                    itemBuilder: (context, index) {
                      final categoryName =
                          Category.getCategoryByType(places[index]).name;
                      final categoryType =
                          Category.getCategoryByType(places[index]).type;
                      return InkWell(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Column(
                            children: [
                              const SizedBox(height: 14),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    categoryName[0].toUpperCase() +
                                        categoryName.substring(1),
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                  if (selectedType == categoryType)
                                    SvgPicture.asset(
                                      iconCheck,
                                      height: 15,
                                      width: 15,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryVariant,
                                    ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              Divider(
                                height: 1,
                                color: myLightSecondaryTwo.withOpacity(0.56),
                              ),
                            ],
                          ),
                        ),
                        onTap: () => {
                          setState(() {
                            if (selectedType != categoryType) {
                              selectedType = categoryType;
                            } else {
                              selectedType = null;
                            }
                          }),
                        },
                      );
                    },
                  );
                },
                loadingBuilder: (context, data) {
                  return const Center(
                      child: CircularProgressIndicator(color: Colors.green));
                },
                loadingChild: const Center(
                  child: CircularProgressIndicator(color: Colors.green),
                ),
                errorDataBuilder: (context, data, e) {
                  return const NetworkException();
                },
                errorChild: SizedBox.shrink(),
              ),
              // StoreConnector<AppState, CategoryState>(
              //   onInit: (store) {
              //     store.dispatch(LoadCategoriesAction());
              //   },
              //   converter: (store) {
              //     return store.state.categoryState;
              //   },
              //   builder: (BuildContext context, CategoryState vm) {
              //     if (vm is CategoriesLoadingState) {
              //       return const Center(child: CircularProgressIndicator());
              //     }

              //     if (vm is CategoriesErrorState) {
              //       return const NetworkException();
              //     }

              //     if (vm is CategoriesDataState) {
              //       final categories = vm.categories;
              //       return ListView.builder(
              //         itemCount: categories.length,
              //         itemBuilder: (context, index) {
              //           final categoryName =
              //               Category.getCategoryByType(categories[index]).name;
              //           final categoryType =
              //               Category.getCategoryByType(categories[index]).type;
              //           return InkWell(
              //             child: Padding(
              //               padding: const EdgeInsets.symmetric(horizontal: 16),
              //               child: Column(
              //                 children: [
              //                   const SizedBox(height: 14),
              //                   Row(
              //                     mainAxisAlignment:
              //                         MainAxisAlignment.spaceBetween,
              //                     children: [
              //                       Text(
              //                         categoryName[0].toUpperCase() +
              //                             categoryName.substring(1),
              //                         style: TextStyle(
              //                           color: Theme.of(context)
              //                               .secondaryHeaderColor,
              //                           fontSize: 16,
              //                         ),
              //                       ),
              //                       if (selectedType == categoryType)
              //                         SvgPicture.asset(
              //                           iconCheck,
              //                           height: 15,
              //                           width: 15,
              //                           color: Theme.of(context)
              //                               .colorScheme
              //                               .primaryVariant,
              //                         ),
              //                     ],
              //                   ),
              //                   const SizedBox(height: 14),
              //                   Divider(
              //                     height: 1,
              //                     color: myLightSecondaryTwo.withOpacity(0.56),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             onTap: () => {
              //               setState(() {
              //                 if (selectedType != categoryType) {
              //                   selectedType = categoryType;
              //                 } else {
              //                   selectedType = null;
              //                 }
              //               }),
              //             },
              //           );
              //         },
              //       );
              //     }

              //     return const SizedBox.shrink();
              //   },
              // ),
            ),
          ),
          _SaveButton(selectedType: selectedType),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _SaveButton extends StatefulWidget {
  final String? selectedType;
  const _SaveButton({
    required this.selectedType,
    Key? key,
  }) : super(key: key);

  @override
  __SaveButtonState createState() => __SaveButtonState();
}

class __SaveButtonState extends State<_SaveButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pop(context, widget.selectedType);
        },
        child: Text(
          constants.textBtnSave,
          style: TextStyle(
            color: (widget.selectedType == null)
                ? myLightSecondaryTwo.withOpacity(0.56)
                : Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            (widget.selectedType == null)
                ? Theme.of(context).primaryColor
                : Theme.of(context).colorScheme.primaryVariant,
          ),
          minimumSize:
              MaterialStateProperty.all(const Size(double.infinity, 48)),
          shadowColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        constants.textCategory,
        style: TextStyle(color: Theme.of(context).secondaryHeaderColor),
      ),
      leading: IconButton(
        icon: const Icon(Icons.navigate_before_rounded),
        color: Theme.of(context).secondaryHeaderColor,
        onPressed: () => Navigator.of(context).pop(),
        iconSize: 35,
      ),
    );
  }
}
