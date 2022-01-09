import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/blocs/favorite_place/bloc/favorite_place_bloc.dart';
import 'package:places/domain/category.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/screens/place_details_screen.dart';
import 'package:places/ui/screens/res/icons.dart';

class SliverPlaces extends StatelessWidget {
  final List<Place> places;

  const SliverPlaces({
    required this.places,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return SliverPadding(
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isPortrait ? 1 : 2,
          mainAxisSpacing: 0,
          crossAxisSpacing: 36,
          childAspectRatio: 1.8,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            final place = places[index];
            return Padding(
              padding: const EdgeInsets.only(top: 15),
              child: PlaceCard(place: place),
            );
          },
          childCount: places.length,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }
}

class PlaceCard extends StatelessWidget {
  final Place place;
  PlaceCard({required this.place, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FavoritePlaceBloc>(context).add(LoadListFavoritePlaces());
    return Stack(
      children: [
        Hero(
          tag: place.id.toString(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PlaceCardTop(place: place),
              _PlaceCardBottom(place: place),
            ],
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return PlaceDetails(place: place);
                  },
                  transitionDuration: Duration(milliseconds: 200),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Category.getCategoryByType(place.placeType).name,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              BlocBuilder<FavoritePlaceBloc, FavoritePlaceState>(
                buildWhen: (context, state) {
                  return state != ListFavoritePlacesLoaded;
                },
                builder: (context, state) {
                  if (state is ListFavoritePlacesLoaded) {
                    return Material(
                      color: Colors.transparent,
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                      clipBehavior: Clip.antiAlias,
                      child: GestureDetector(
                        onTap: () {
                          BlocProvider.of<FavoritePlaceBloc>(context)
                              .add(TogglePlaceInFavorites(place));
                        },
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: state.places.contains(place)
                              ? favoriteIcon
                              : notFavoriteIcon,
                        ),
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget notFavoriteIcon = SvgPicture.asset(
    iconFavorite,
    key: UniqueKey(),
    width: 24,
    height: 24,
    color: Colors.white,
  );

  Widget favoriteIcon = SvgPicture.asset(
    iconFavoriteSelected,
    key: UniqueKey(),
    width: 24,
    height: 24,
    color: Colors.white,
  );
}

class _PlaceCardBottom extends StatelessWidget {
  final Place place;
  const _PlaceCardBottom({
    required this.place,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          color: Theme.of(context).primaryColor,
        ),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(
              place.name,
              maxLines: 1,
              style: Theme.of(context).textTheme.headline1?.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              place.description,
              maxLines: 2,
              style: Theme.of(context).textTheme.bodyText2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _PlaceCardTop extends StatelessWidget {
  final Place place;
  const _PlaceCardTop({
    required this.place,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: CachedNetworkImage(
                imageUrl: place.urls.first,
                fadeOutDuration: const Duration(milliseconds: 200),
                imageBuilder: (context, imageProvider) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                placeholder: (context, url) {
                  return Center(
                    child: Icon(
                      Icons.photo_size_select_actual_outlined,
                      color: Colors.grey[300],
                      size: 70.0,
                    ),
                  );
                },
                errorWidget: (context, url, error) {
                  return ImagePlaceholder();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ImagePlaceholder extends StatelessWidget {
  const ImagePlaceholder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).secondaryHeaderColor,
      child: const Center(
        child: Icon(
          Icons.photo_size_select_actual_outlined,
          color: Colors.grey,
          size: 50.0,
        ),
      ),
    );
  }
}
