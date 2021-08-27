import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domains/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/icons.dart';
import 'package:places/ui/screens/sight_map_screen.dart';
import 'package:places/ui/styles.dart';

/// A screen with a detailed description of the place
class SightDetails extends StatefulWidget {
  final int id;

  const SightDetails({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  _SightDetailsState createState() => _SightDetailsState();
}

class _SightDetailsState extends State<SightDetails> {
  final PageController _pageController = PageController();
  double currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor,
      child: ConstrainedBox(
        constraints:
            BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              expandedHeight: 360,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  height: 360,
                  color: Colors.brown,
                  child: Stack(
                    children: [
                      PageView.builder(
                        onPageChanged: (int page) {
                          setState(() {
                            setCurrentPage(page.toDouble());
                          });
                        },
                        controller: _pageController,
                        itemCount: mocks[widget.id].urls.length,
                        itemBuilder: (context, index) {
                          return _PlaceImage(
                            imgUrl: mocks[widget.id].urls[index],
                          );
                        },
                      ),
                      const _ArrowBackButton(),
                      if (mocks[widget.id].urls.length > 1)
                        PageIndicator(
                          widget: widget,
                          currentPage: currentPage,
                        ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: _Description(sight: mocks[widget.id]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setCurrentPage(double page) {
    setState(() {
      currentPage = page;
    });
  }
}

class PageIndicator extends StatelessWidget {
  const PageIndicator({
    Key? key,
    required this.widget,
    required this.currentPage,
  }) : super(key: key);

  final SightDetails widget;
  final double currentPage;

  @override
  Widget build(BuildContext context) {
    const startIndicator = BorderRadius.only(
      topRight: Radius.circular(10),
      bottomRight: Radius.circular(10),
    );

    const endIndicator = BorderRadius.only(
      topLeft: Radius.circular(10),
      bottomLeft: Radius.circular(10),
    );

    const middleIndicator = BorderRadius.all(
      Radius.circular(10),
    );

    return Positioned(
      bottom: 0,
      child: Row(
        children: [
          for (int i = 0; i < mocks[widget.id].urls.length; i++)
            Container(
              height: 10,
              decoration: BoxDecoration(
                borderRadius: (currentPage == 0)
                    ? startIndicator
                    : (currentPage == mocks[widget.id].urls.length - 1)
                        ? endIndicator
                        : middleIndicator,
                color: i == currentPage ? myLightMain : Colors.transparent,
              ),
              width: MediaQuery.of(context).size.width /
                  mocks[widget.id].urls.length,
            ),
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    Key? key,
    required this.sight,
  }) : super(key: key);

  final Sight sight;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Row(
          children: [
            Text(
              sight.name,
              style:
                  Theme.of(context).textTheme.headline1?.copyWith(fontSize: 24),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Text(
              sight.type,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
              ),
              child: Opacity(
                opacity: 0.56,
                child: Text(
                  'закроется в 20:00',
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Text(
          sight.details,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        const SizedBox(height: 24),
        const _CreateRouteButton(),
        const SizedBox(height: 24),
        const Divider(
          height: 4,
          color: myLightSecondaryTwo,
        ),
        const SizedBox(height: 19),
        const _FunctionButtons(),
        const SizedBox(height: 11)
      ],
    );
  }
}

class _FunctionButtons extends StatelessWidget {
  const _FunctionButtons({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: SvgPicture.asset(
                    iconCalendar,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                const SizedBox(width: 9),
                Text(
                  'Запланировать',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                const SizedBox(width: 14),
              ],
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: InkWell(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 14),
                Container(
                  child: SvgPicture.asset(
                    iconFavorite,
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 9),
                  child: Text(
                    'В избранное',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _CreateRouteButton extends StatelessWidget {
  const _CreateRouteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement<void, void>(
          context,
          MaterialPageRoute(
            builder: (context) => const SightMapScreen(),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        primary: myLightGreen,
        fixedSize: const Size(double.infinity, 48),
        elevation: 0.0,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            iconRoute,
            width: 22,
            color: Colors.white,
          ),
          const SizedBox(width: 10),
          Text(
            'ПОСТРОИТЬ МАРШРУТ',
            style: activeBtnTextStyle,
          ),
        ],
      ),
    );
  }
}

class _PlaceImage extends StatelessWidget {
  final String imgUrl;

  const _PlaceImage({
    Key? key,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imgUrl,
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }
}

class _ArrowBackButton extends StatelessWidget {
  const _ArrowBackButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16.0,
      right: 16.0,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          width: 40,
          height: 40,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Align(
            child: SvgPicture.asset(
              iconClose,
              height: 20,
              width: 20,
              color: myLightMain,
            ),
          ),
        ),
      ),
    );
  }
}
