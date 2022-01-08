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
                    return PlaceDetails(id: place.id!);
                  },
                  transitionDuration: Duration(milliseconds: 200),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: Tween<double>(
                        begin: 0.0,
                        end: 1.0,
                      ).animate(animation),
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
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
                      child: IconButton(
                        onPressed: () {
                          BlocProvider.of<FavoritePlaceBloc>(context)
                              .add(TogglePlaceInFavorites(place));
                        },
                        icon: SvgPicture.asset(
                          state.places.contains(place)
                              ? iconFavoriteSelected
                              : iconFavorite,
                          color: Colors.white,
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

  Future<void> _showPlace(BuildContext context, int id) async {
    await showModalBottomSheet<Place>(
      context: context,
      builder: (_) {
        return PlaceDetails(id: id);
      },
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
    );
  }
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
                  return const Center(
                    child: CircularProgressIndicator(),
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
