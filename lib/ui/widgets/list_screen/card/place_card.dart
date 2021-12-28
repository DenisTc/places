import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/redux/action/favorite_places_action.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/data/redux/state/favorite_places_state.dart';

import 'package:places/domain/category.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/screens/place_details_screen.dart';

/// A card of an interesting place to be displayed on the main screen of the application.
class PlaceCard extends StatelessWidget {
  final Place place;
  PlaceCard({required this.place, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 188,
      child: Stack(
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _PlaceCardTop(place: place),
              _PlaceCardBottom(place: place),
            ],
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: const BorderRadius.all(Radius.circular(16)),
              onTap: () {
                _showPlace(context, place.id!);
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
                // StoreConnector<AppState, FavoritePlacesState>(
                //   onInit: (store) {
                //     store.dispatch(LoadFavoritePlacesAction());
                //   },
                //   converter: (store) {
                //     return store.state.favoritePlacesState;
                //   },
                //   builder: (BuildContext context, FavoritePlacesState vm) {
                //     if (vm is FavoritePlacesLoadingState) {
                //       return Padding(
                //         padding: const EdgeInsets.only(top: 10),
                //         child: CircularProgressIndicator(color: Colors.green),
                //       );
                //     }

                //     if (vm is FavoritePlacesDataState) {
                //       return Material(
                //         color: Colors.transparent,
                //         borderRadius:
                //             const BorderRadius.all(Radius.circular(50)),
                //         clipBehavior: Clip.antiAlias,
                //         child: IconButton(
                //           onPressed: () {
                //             StoreProvider.of<AppState>(context)
                //                 .dispatch(ToggleInFavoriteAction(place));
                //           },
                //           icon: SvgPicture.asset(
                //             vm.places.contains(place)
                //                 ? iconFavoriteSelected
                //                 : iconFavorite,
                //             color: Colors.white,
                //           ),
                //         ),
                //       );
                //     }

                //     return const SizedBox.shrink();
                //   },
                // ),
              ],
            ),
          ),
        ],
      ),
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
    return Container(
      height: 92,
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
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      height: 96,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            child: place.urls.isNotEmpty
                ? Image.network(
                    place.urls.first,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                    loadingBuilder: (
                      context,
                      child,
                      loadingProgress,
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
                    errorBuilder: (context, error, stackTrace) {
                      return const ImagePlaceholder();
                    },
                  )
                : const ImagePlaceholder(),
          ),
        ],
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
