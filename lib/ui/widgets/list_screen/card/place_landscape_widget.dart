// import 'package:flutter/material.dart';
// import 'package:places/mocks.dart';
// import 'package:places/ui/widgets/list_screen/card/place_card.dart';

// // Widget for displaying a list of favorites in landscape orientation
// class PlaceLandscapeWidget extends StatelessWidget {
//   const PlaceLandscapeWidget({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return SliverGrid(
//       delegate: SliverChildBuilderDelegate(
//         (context, index) {
//           final place = mocks[index];
//           return Padding(
//             padding: const EdgeInsets.only(bottom: 16),
//             child: PlaceCard(place: place, refreshPlacesList: refreshPlacesList,),
//           );
//         },
//         childCount: mocks.length,
//       ),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         mainAxisSpacing: 20,
//         crossAxisSpacing: 36,
//         childAspectRatio: 1.8,
//       ),
//     );
//   }
// }