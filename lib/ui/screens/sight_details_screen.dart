import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domains/sight.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/icons.dart';

/// A screen with a detailed description of the place
class SightDetails extends StatefulWidget {
  final Sight sight;

  const SightDetails({Key? key, required this.sight}) : super(key: key);

  @override
  _SightDetailsState createState() => _SightDetailsState();
}

class _SightDetailsState extends State<SightDetails> {
  final PageController _pageController = PageController();
  double currentPage = 0;

  void setCurrentPage(double page) {
    setState(() {
      currentPage = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Column(
        children: [
          Container(
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
                  itemCount: widget.sight.urls.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _PlaceImage(imgUrl: widget.sight.urls[index]);
                  },
                ),
                const _ArrowBackButton(),
                if (widget.sight.urls.length > 1)
                  PageIndicator(
                    widget: widget,
                    currentPage: currentPage,
                  ),
              ],
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
              ),
              child: _Description(sight: widget.sight),
            ),
          ),
        ],
      ),
    );
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
          for (int i = 0; i < widget.sight.urls.length; i++)
            Container(
              height: 10,
              decoration: BoxDecoration(
                borderRadius: (currentPage == 0)
                    ? startIndicator
                    : (currentPage == widget.sight.urls.length - 1)
                        ? endIndicator
                        : middleIndicator,
                color: i == currentPage ? favoriteColor : Colors.transparent,
              ),
              width:
                  MediaQuery.of(context).size.width / widget.sight.urls.length,
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
          color: textColorSecondary,
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
          flex: 1,
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
    return InkWell(
      child: Container(
        height: 48,
        width: 328,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          color: lightGreen,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: SvgPicture.asset(iconRoute, color: Colors.white),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 10),
              child: Text(
                'ПОСТРОИТЬ МАРШРУТ',
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
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
      loadingBuilder: (
        BuildContext context,
        Widget child,
        ImageChunkEvent? loadingProgress,
      ) {
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
    return Align(
      alignment: Alignment.topLeft,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Container(
          margin: const EdgeInsets.only(
            left: 16,
            top: 36,
          ),
          child: Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 17,
            color: Theme.of(context).iconTheme.color,
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          width: 32,
          height: 32,
        ),
      ),
    );
  }
}
