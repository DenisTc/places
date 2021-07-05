import 'package:flutter/material.dart';
import 'package:places/domains/sight.dart';
import 'package:places/ui/colors.dart';

class SightCard extends StatelessWidget {
  final Sight sight;

  const SightCard(this.sight);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Container(
        margin: EdgeInsets.all(20),
        alignment: Alignment.topLeft,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: const Radius.circular(16)),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.blue,
                      cardBackgroundColor,
                    ],
                  )),
              height: 96,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                      alignment: Alignment.topLeft,
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 250),
                        child: Text(
                          sight.type,
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w700),
                        ),
                      )),
                  Align(
                    alignment: Alignment.topRight,
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: const Radius.circular(16),
                      bottomRight: const Radius.circular(16)),
                  color: cardBackgroundColor),
              width: double.infinity,
              height: 92,
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 16,
                  ),
                  Text(sight.name,
                      maxLines: 2,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis),
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(sight.details,
                        maxLines: 2,
                        style: TextStyle(color: textColorSecondary),
                        overflow: TextOverflow.ellipsis),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}