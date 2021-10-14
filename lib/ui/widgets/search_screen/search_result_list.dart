import 'package:flutter/material.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/ui/widgets/search_screen/search_result.dart';

class SearchResultList extends StatelessWidget {
  final List<PlaceDto> _filteredSights;
  final String searchString;

  const SearchResultList({
    Key? key,
    required List<PlaceDto> filteredSights,
    required this.searchString,
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
        );
      },
    );
  }
}
