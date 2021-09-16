import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/ui/widgets/list_screen/add_sight_button.dart';
import 'package:places/ui/widgets/list_screen/sliver_app_bar_list.dart';
import 'package:places/ui/widgets/list_screen/sliver_sights.dart';

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
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData && !snapshot.hasError) {
            return Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                SafeArea(
                  child: CustomScrollView(
                    slivers: [
                      SliverAppBarList(),
                      SliverSights(places: snapshot.data!.places),
                    ],
                  ),
                ),
                AddSightButton(),
              ],
            );
          } else {
            return Center(
              child: Container(
                child: Text('Error'),
              ),
            );
          }
        },
      ),
    );
  }
}
