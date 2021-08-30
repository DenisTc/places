import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:places/ui/widgets/list_screen/search_bar.dart';

class SliverAppBarList extends StatefulWidget {
  const SliverAppBarList({Key? key}) : super(key: key);

  @override
  _SliverAppBarListState createState() => _SliverAppBarListState();
}

class _SliverAppBarListState extends State<SliverAppBarList> {
  double appBarHeight = 0.0;
  bool isNotCollapsed = true;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      centerTitle: false,
      pinned: true,
      elevation: 0.0,
      expandedHeight: 160.0,
      backgroundColor: Theme.of(context).accentColor,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          var top = constraints.biggest.height;
          debugPrint(top.toString());
          return FlexibleSpaceBar(
            title: Opacity(
              opacity: top < 110 ? 1.0 : 0.0,
              child: Text(
                'Список интересных мест',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            background: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Список\nинтересных мест',
                    style: Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(fontSize: 32, fontWeight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height: 46.0,
                    width: double.infinity,
                    child: SearchBar(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
