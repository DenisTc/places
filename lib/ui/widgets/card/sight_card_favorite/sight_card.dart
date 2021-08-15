import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domains/sight.dart';
import 'package:places/ui/icons.dart';
import 'package:places/ui/widgets/card/sight_card_favorite/favorite_card_bottom.dart';
import 'package:places/ui/widgets/card/sight_card_favorite/favorite_card_top.dart';

class SightCard extends StatefulWidget {
  final GlobalKey globalKey;
  final bool visited;
  final Sight sight;
  final Function(Sight sight, bool visited) removeSight;
  const SightCard({
    Key? key,
    required this.visited,
    required this.sight,
    required this.globalKey,
    required this.removeSight,
  }) : super(key: key);

  @override
  __SightCardState createState() => __SightCardState();
}

class __SightCardState extends State<SightCard> {
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: const BorderRadius.all(Radius.circular(16)),
      child: Container(
        key: widget.globalKey,
        height: 216,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Stack(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FavoriteCardTop(
                    sight: widget.sight,
                    visited: widget.visited,
                  ),
                  FavoriteCardBottom(
                    sight: widget.sight,
                    visited: widget.visited,
                  ),
                ],
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  onTap: () {},
                ),
              ),
              Positioned(
                right: 16,
                top: 10,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      widget.visited ? iconShare : iconCalendar,
                      width: 25,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 16),
                    InkWell(
                      child: const Icon(
                        Icons.clear_outlined,
                        color: Colors.white,
                      ),
                      onTap: () {
                        setState(() {
                          widget.removeSight(
                            widget.sight,
                            widget.visited,
                          );
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
