import 'package:places/ui/res/constants.dart' as constants;

class Category {
  static List<Category> catList = constants.categories;

  final String type;
  final String name;
  final String icon;

  const Category({
    required this.type,
    required this.name,
    required this.icon,
  });

  static Category getCategoryByType(String type) {
    return catList.where((element) => element.type == type).single;
  }

  static Category getCategoryByName(String name) {
    return catList
        .where((element) => element.name == name.toLowerCase())
        .single;
  }
}
