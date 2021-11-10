import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/domain/category.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/res/constants.dart' as Constants;
import 'package:places/ui/widgets/network_exception.dart';
import 'package:provider/provider.dart';

class SightCategoryScreen extends StatefulWidget {
  const SightCategoryScreen({Key? key}) : super(key: key);

  @override
  _SightCategoryScreenState createState() => _SightCategoryScreenState();
}

class _SightCategoryScreenState extends State<SightCategoryScreen> {
  late SearchInteractor _searchInteractor;
  String? selectedType;

  @override
  void initState() {
    _searchInteractor = Provider.of<SearchInteractor>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const _AppBar(),
      body: Column(
        children: [
          const SizedBox(height: 24),
          Expanded(
            child: Scrollbar(
              child: StreamBuilder<List<String>>(
                stream: _searchInteractor.getCategoriesStream(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasData && !snapshot.hasError) {
                    final categories = snapshot.data;
                    return ListView.builder(
                      itemCount: categories!.length,
                      itemBuilder: (context, index) {
                        final categoryName =
                            Category.getCategory(categories[index]).name;
                        final categoryType =
                            Category.getCategory(categories[index]).type;
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
                                      style: const TextStyle(
                                        color: myLightMain,
                                        fontSize: 16,
                                      ),
                                    ),
                                    if (selectedType == categoryType)
                                      SvgPicture.asset(
                                        iconCheck,
                                        height: 15,
                                        width: 15,
                                        color: Theme.of(context).buttonColor,
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 14),
                                const Divider(height: 1),
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
                  }

                  return const NetworkException();
                },
              ),
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
    Key? key,
    required this.selectedType,
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
          Constants.textBtnSave,
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
                ? myLightBackground
                : Theme.of(context).buttonColor,
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
  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Text(
        Constants.textCategory,
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
