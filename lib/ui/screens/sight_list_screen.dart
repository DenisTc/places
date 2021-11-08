import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/store/place_list/place_list_store.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/widgets/list_screen/add_sight_button.dart';
import 'package:places/ui/widgets/list_screen/sliver_app_bar_list.dart';
import 'package:places/ui/widgets/list_screen/sliver_sights.dart';
import 'package:places/ui/widgets/network_exception.dart';
import 'package:provider/provider.dart';

class SightListScreen extends StatefulWidget {
  const SightListScreen({Key? key}) : super(key: key);

  @override
  SightListScreenState createState() => SightListScreenState();
}

class SightListScreenState extends State<SightListScreen> {
  late PlaceListStore _store;

  @override
  void initState() {
    super.initState();
    _store = PlaceListStore(context.read<PlaceInteractor>());
    _store.loadList();
  }

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
                Observer(
                  builder: (_) {
                    final future = _store.placeList;

                    switch (future.status) {
                      case FutureStatus.pending:
                        return const SliverFillRemaining(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );

                      case FutureStatus.rejected:
                        return const SliverFillRemaining(
                          child: NetworkException(),
                        );

                      case FutureStatus.fulfilled:
                        return SliverSights(
                          places: future.result as List<Place>,
                        );
                    }
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
