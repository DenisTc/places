import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/blocs/filtered_places/bloc/filtered_places_bloc.dart';
import 'package:places/data/blocs/filtered_places/bloc/filtered_places_event.dart';
import 'package:places/data/blocs/filtered_places/bloc/filtered_places_state.dart';
import 'package:places/domain/place.dart';
import 'package:places/domain/search_filter.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/constants.dart' as constants;
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/widgets/list_screen/place_app_bar.dart';
import 'package:places/ui/widgets/network_exception.dart';
import 'package:places/ui/widgets/search_screen/empty_search_result.dart';
import 'package:places/ui/widgets/search_screen/search_bar.dart';
import 'package:places/ui/widgets/search_screen/search_result_list.dart';

List<String> historyList = [];

class SearchScreen extends StatefulWidget {
  final SearchFilter? settingsFilter;

  const SearchScreen({
    required this.settingsFilter,
    Key? key,
  }) : super(key: key);

  @override
  _PlaceSearchScreenState createState() => _PlaceSearchScreenState();
}

class _PlaceSearchScreenState extends State<SearchScreen> {
  final _controllerSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FilteredPlacesBloc>(context)
        .add(LoadFilteredPlaces(widget.settingsFilter));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PlaceAppBar(),
      backgroundColor: Theme.of(context).colorScheme.secondary,
      body: Column(
        children: [
          SearchBar(
            controllerSearch: _controllerSearch,
            notifyParent: () {
              setState(() {});
            },
          ),
          const SizedBox(height: 38),
          Expanded(
            child: Builder(
              builder: (context) {
                if (historyList.isNotEmpty && _controllerSearch.text == '') {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          constants.textHistory,
                          style: TextStyle(
                            color: myLightSecondaryTwo.withOpacity(0.56),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            _HistoryList(
                              historyList: historyList.toList(),
                              deletePlaceFromHistory: (name) {
                                _deletePlaceFromHistory(name);
                              },
                              controllerSearch: _controllerSearch,
                              notifyParent: () {
                                setState(() {});
                              },
                            ),
                            _ClearHistoryButton(
                              historyList: historyList.toList(),
                              clearHistory: _clearHistory,
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (historyList.isEmpty &&
                    _controllerSearch.text.isEmpty) {
                  return const SizedBox.shrink();
                }

                return BlocBuilder<FilteredPlacesBloc, FilteredPlacesState>(
                  builder: (context, state) {
                    if (state is LoadFilteredPlacesInProgress) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (state is LoadFilteredPlacesSuccess) {
                      final searchRes = _filterPlacesByName(
                        _controllerSearch.text,
                        state.places,
                      );

                      if (searchRes.length == 0)
                        return const EmptySearchResult();

                      return SearchResultList(
                        filteredPlaces: searchRes,
                        searchString: _controllerSearch.text,
                        addPlaceToSearchHistory: (name) {
                          _addPlaceToSearchHistory(name);
                        },
                      );
                    }

                    if (state is LoadFilteredPlacesError) {
                      return const SliverFillRemaining(
                        child: NetworkException(),
                      );
                    }

                    return const EmptySearchResult();
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addPlaceToSearchHistory(String name) {
    setState(() {
      if (!historyList.contains(name)) historyList.add(name);
    });
  }

  void _deletePlaceFromHistory(String name) {
    setState(() {
      historyList.remove(name);
    });
  }

  void _clearHistory() {
    setState(() {
      historyList.clear();
    });
  }

  List<Place> _filterPlacesByName(String name, List<Place> places) {
    final _filredPlaces = <Place>[];
    for (final place in places) {
      final _indexName = place.name.toLowerCase().indexOf(name.toLowerCase());

      if (_indexName >= 0) {
        _filredPlaces.add(place);
      }
    }

    return _filredPlaces;
  }
}

class _HistoryList extends StatefulWidget {
  final List<String> historyList;
  final TextEditingController controllerSearch;
  final Function(String) deletePlaceFromHistory;
  final Function() notifyParent;

  const _HistoryList({
    required this.historyList,
    required this.deletePlaceFromHistory,
    required this.controllerSearch,
    required this.notifyParent,
    Key? key,
  }) : super(key: key);

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<_HistoryList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: widget.historyList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Column(
            children: [
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(
                          () {
                            widget.controllerSearch.text =
                                widget.historyList[index];
                            widget.controllerSearch.selection =
                                TextSelection.fromPosition(
                              TextPosition(
                                offset: widget.controllerSearch.text.length,
                              ),
                            );
                          },
                        );
                        widget.notifyParent();
                      },
                      child: Text(
                        widget.historyList[index],
                        style: const TextStyle(
                          color: myLightMain,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.zero,
                    height: 15,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        widget
                            .deletePlaceFromHistory(widget.historyList[index]);
                      },
                      icon: SvgPicture.asset(
                        iconClose,
                        height: 15,
                        color: myLightSecondaryTwo,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              if (index != widget.historyList.length - 1)
                const Divider(height: 1),
            ],
          ),
        );
      },
    );
  }
}

class _ClearHistoryButton extends StatefulWidget {
  final List<String> historyList;
  final Function() clearHistory;

  const _ClearHistoryButton({
    required this.historyList,
    required this.clearHistory,
    Key? key,
  }) : super(key: key);

  @override
  __ClearHistoryButtonState createState() => __ClearHistoryButtonState();
}

class __ClearHistoryButtonState extends State<_ClearHistoryButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: () {
          setState(
            () {
              widget.clearHistory();
            },
          );
        },
        style: const ButtonStyle(alignment: Alignment.centerLeft),
        child: Text(
          constants.textBtnClearHistory,
          style: TextStyle(
            color: Theme.of(context).colorScheme.primaryVariant,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
