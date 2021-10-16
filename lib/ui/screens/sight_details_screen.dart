import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/place_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/repository/place_repository.dart';
import 'package:places/main.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/sight_map_screen.dart';
import 'package:places/ui/screens/res/styles.dart';
import 'package:places/ui/widgets/sight_cupertino_date_picker.dart';

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
    return Material(
      child: Container(
        color: Theme.of(context).accentColor,
        child: FutureBuilder<Place>(
          future: placeInteractor.getPlaceDetails(widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasData && !snapshot.hasError) {
              final place = snapshot.data!;
              return ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
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
                                itemCount: place.urls.length,
                                itemBuilder: (context, index) {
                                  return _PlaceImage(
                                    imgUrl: place.urls[index],
                                  );
                                },
                              ),
                              const _ArrowBackButton(),
                              if (place.urls.length > 1)
                                PageIndicator(
                                  countImages: place.urls.length,
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
                            child: _Description(place: place),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
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
  final int countImages;
  final double currentPage;

  const PageIndicator({
    Key? key,
    required this.countImages,
    required this.currentPage,
  }) : super(key: key);

  

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
          for (int i = 0; i < countImages; i++)
            Container(
              height: 10,
              decoration: BoxDecoration(
                borderRadius: (currentPage == 0)
                    ? startIndicator
                    : (currentPage == countImages - 1)
                        ? endIndicator
                        : middleIndicator,
                color: i == currentPage ? myLightMain : Colors.transparent,
              ),
              width:
                  MediaQuery.of(context).size.width / countImages,
            ),
        ],
      ),
    );
  }
}

class _Description extends StatelessWidget {
  const _Description({
    Key? key,
    required this.place,
  }) : super(key: key);

  final Place place;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        Row(
          children: [
            Text(
              place.name,
              style:
                  Theme.of(context).textTheme.headline1?.copyWith(fontSize: 24),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Row(
          children: [
            Text(
              place.placeType,
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
          place.description,
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
        _FunctionButtons(place: place),
        const SizedBox(height: 11),
      ],
    );
  }
}

class _FunctionButtons extends StatelessWidget {
  final Place place;
  const _FunctionButtons({
    Key? key,
    required this.place,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          flex: 1,
          child: InkWell(
            onTap: () async {
              await showModalBottomSheet<void>(
                context: context,
                builder: (builder) {
                  return const SightCupertinoDatePicker();
                },
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SvgPicture.asset(
                  iconCalendar,
                  color: Theme.of(context).iconTheme.color,
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
              children: [
                const SizedBox(width: 14),
                TextButton.icon(
                  onPressed: () {
                    placeInteractor.addToFavorites(place);
                  },
                  icon: SvgPicture.asset(
                    iconFavorite,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  label: Text(
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
        primary: Theme.of(context).buttonColor,
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
