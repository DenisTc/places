import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/place.dart';
import 'package:places/main.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/constants.dart' as Constants;
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/widgets/list_screen/add_sight_button.dart';
import 'package:places/ui/widgets/list_screen/sliver_app_bar_list.dart';
import 'package:places/ui/widgets/list_screen/sliver_sights.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  SightListScreenState createState() => SightListScreenState();
}

class SightListScreenState extends State<SightListScreen> {
  late Stream<List<Place>> places;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Stack(
        alignment: AlignmentDirectional.topCenter,
        children: [
          SafeArea(
            child: CustomScrollView(
              slivers: [
                const SliverAppBarList(),
                StreamBuilder<List<Place>>(
                  stream: placeInteractor.getStreamPlaces,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const SliverFillRemaining(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    if (snapshot.hasData && !snapshot.hasError) {
                      return SliverSights(places: snapshot.data!);
                    }

                    return SliverFillRemaining(
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
                            Constants.textError,
                            style: TextStyle(
                              color: myLightSecondaryTwo,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            Constants.textTryLater,
                            style: TextStyle(
                              color: myLightSecondaryTwo,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const AddSightButton(),
        ],
      ),
    );
  }
}
