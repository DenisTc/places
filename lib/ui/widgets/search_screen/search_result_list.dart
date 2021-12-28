import 'package:flutter/material.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/widgets/search_screen/search_result.dart';

class SearchResultList extends StatelessWidget {
  final String searchString;
  final Function(String name) addPlaceToSearchHistory;
  final List<Place> _filteredPlaces;

  const SearchResultList({
    required List<Place> filteredPlaces,
    required this.searchString,
    required this.addPlaceToSearchHistory,
    Key? key,
  })  : _filteredPlaces = filteredPlaces,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      itemCount: _filteredPlaces.length,
      itemBuilder: (context, index) {
        final place = _filteredPlaces[index];
        return SearchResult(
          place: place,
          searchString: searchString,
          addPlaceToSearchHistory: addPlaceToSearchHistory,
        );
      },
    );
  }
}
