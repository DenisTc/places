// import 'package:flutter/material.dart';
// import 'package:places/mocks.dart';
// import 'package:places/ui/widgets/list_screen/card/place_card.dart';

// // Widget for displaying a list of favorites in vertical orientation
// class PlacePortraitWidget extends StatelessWidget {
//   const PlacePortraitWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SliverList(
//       delegate: SliverChildBuilderDelegate(
//         (context, index) {
//           final place = mocks[index];
//           return Padding(
//             padding: const EdgeInsets.only(bottom: 16),
//             child: PlaceCard(place: place),
//           );
//         },
//         childCount: mocks.length,
//       ),
//     );
//   }
// }