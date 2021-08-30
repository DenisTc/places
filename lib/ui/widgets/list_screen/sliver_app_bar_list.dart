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
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    return SliverAppBar(
      centerTitle: false,
      pinned: true,
      elevation: 0.0,
      expandedHeight: isPortrait ? 160.0 : 130,
      backgroundColor: Theme.of(context).accentColor,
      flexibleSpace: LayoutBuilder(
        builder: (context, constraints) {
          final top = constraints.biggest.height;
          return FlexibleSpaceBar(
            title: Opacity(
              opacity: top < 110 ? 1.0 : 0.0,
              child: const MiniTitle(),
            ),
            background: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: isPortrait ? const BigTitle() : const MiniTitle(),
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

class MiniTitle extends StatelessWidget {
  const MiniTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Список интересных мест',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline1,
    );
  }
}

class BigTitle extends StatelessWidget {
  const BigTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Список\nинтересных мест',
      style: Theme.of(context)
          .textTheme
          .headline1!
          .copyWith(fontSize: 32, fontWeight: FontWeight.w700),
    );
  }
}
