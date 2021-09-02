import 'package:flutter/material.dart';
import 'package:places/ui/screens/res/colors.dart';

class VisitingAppbar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(116);

  const VisitingAppbar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(52),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: Theme.of(context).primaryColor,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 6,
            horizontal: 16,
          ),
          child: Theme(
            data: ThemeData(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
            ),
            child: TabBar(
              tabs: const [
                Tab(
                  text: 'Хочу посетить',
                ),
                Tab(
                  text: 'Посетил',
                ),
              ],
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Theme.of(context).secondaryHeaderColor,
              ),
              labelStyle: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
              unselectedLabelColor: myLightSecondaryTwo.withOpacity(0.56),
              labelColor: Theme.of(context).accentColor,
            ),
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(
          'Избранное',
          style: Theme.of(context).textTheme.headline1?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
        ),
      ),
    );
  }
}
