import 'package:places/ui/screens/res/icons.dart';

class Category {
  final String type;
  final String name;
  final String icon;

  Category({
    required this.type,
    required this.name,
    required this.icon,
  });

  static List<Category> catList = [
    Category(type: 'other', name: 'прочее', icon: iconParticularPlace),
    Category(type: 'monument', name: 'памятник', icon: iconParticularPlace),
    Category(type: 'park', name: 'парк', icon: iconPark),
    Category(type: 'hotel', name: 'отель', icon: iconHotel),
    Category(type: 'museum', name: 'музей', icon: iconMuseum),
    Category(type: 'theatre', name: 'театр', icon: iconParticularPlace),
    Category(type: 'cafe', name: 'кафе', icon: iconCafe),
    Category(type: 'temple', name: 'храм', icon: iconParticularPlace),
    Category(type: 'restaurant', name: 'ресторан', icon: iconRestourant),
  ];

  static Category getCategory(String type) {
    return catList.where((element) => element.type == type).single;
  }
}
