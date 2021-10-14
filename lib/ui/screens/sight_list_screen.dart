import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/widgets/list_screen/add_sight_button.dart';
import 'package:places/ui/widgets/list_screen/sliver_app_bar_list.dart';
import 'package:places/ui/widgets/list_screen/sliver_sights.dart';
import 'package:places/ui/screens/res/colors.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  SightListScreenState createState() => SightListScreenState();
}

class SightListScreenState extends State<SightListScreen> {
  PlaceRepository placeRepository = PlaceRepository();
  late Future<Places> sightList;

  @override
  void initState() {
    super.initState();
    sightList = placeRepository.getListPlaces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: FutureBuilder<Places>(
        future: sightList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData && !snapshot.hasError) {
            return Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                SafeArea(
                  child: CustomScrollView(
                    slivers: [
                      const SliverAppBarList(),
                      SliverSights(places: snapshot.data!.places),
                    ],
                  ),
                ),
                const AddSightButton(),
              ],
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    iconErrorRound,
                    height: 64,
                    width: 64,
                    color: myLightSecondaryTwo.withOpacity(0.56),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Ошибка',
                    style: TextStyle(
                      color: myLightSecondaryTwo,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Что то пошло не так\nПопробуйте позже.',
                    style: TextStyle(
                      color: myLightSecondaryTwo,
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}