import 'package:flutter/material.dart';
import 'package:places/domain/place.dart';
import 'package:places/ui/widgets/search_screen/search_result.dart';

class SearchResultList extends StatelessWidget {
  final String searchString;
  final Function(String name) addPlaceToSearchHistory;
  final List<Place> _filteredSights;

  const SearchResultList({
    required List<Place> filteredSights,
    required this.searchString,
    required this.addPlaceToSearchHistory,
    Key? key,
  })  : _filteredSights = filteredSights,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      itemCount: _filteredSights.length,
      itemBuilder: (context, index) {
        final place = _filteredSights[index];
        return SearchResult(
          place: place,
          searchString: searchString,
          addPlaceToSearchHistory: addPlaceToSearchHistory,
        );
      },
    );
  }
}
