import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/model/place.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/screens/res/colors.dart';
import 'package:places/ui/screens/res/icons.dart';
import 'package:places/ui/widgets/search_screen/empty_search_result.dart';
import 'package:places/ui/widgets/search_screen/search_bar.dart';
import 'package:places/ui/widgets/list_screen/sight_app_bar.dart';
import 'package:places/ui/widgets/search_screen/search_result_list.dart';

List<String> historyList = [];

final searchInteractor = SearchInteractor();

class SightSearchScreen extends StatefulWidget {
  final Future<List<PlaceDto>>? filteredList;
  const SightSearchScreen({
    Key? key,
    required this.filteredList,
  }) : super(key: key);

  @override
  _SightSearchScreenState createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  final _controllerSearch = TextEditingController();
  late Future<List<PlaceDto>>? _filteredSights;

  @override
  Widget build(BuildContext context) {
    _filteredSights = widget.filteredList ??
        searchInteractor.searchPlaces(name: _controllerSearch.text);
    return Scaffold(
      appBar: const SightAppBar(),
      body: ListView(
        children: [
          SearchBar(
            controllerSearch: _controllerSearch,
            notifyParent: () {
              setState(() {});
            },
          ),
          const SizedBox(height: 38),
          FutureBuilder<List<PlaceDto>>(
            future: _filteredSights,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (historyList.isNotEmpty && _controllerSearch.text == '') {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'ВЫ ИСКАЛИ',
                          style: TextStyle(
                            color: myLightSecondaryTwo.withOpacity(0.56),
                            fontSize: 12,
                          ),
                        ),
                      ),
                      _HistoryList(
                        historyList: historyList.toList(),
                        updateHistory: (history) {
                          updateHistory(history);
                        },
                        controllerSearch: _controllerSearch,
                      ),
                      _ClearHistoryButton(
                        historyList: historyList.toList(),
                        updateHistory: (history) {
                          updateHistory(history);
                        },
                      ),
                    ],
                  ),
                );
              } else if (historyList.isEmpty &&
                  _controllerSearch.text.isEmpty) {
                return const SizedBox.shrink();
              }

              if (snapshot.hasData &&
                  !snapshot.hasError &&
                  snapshot.data!.isNotEmpty) {
                _updateHistoryList(snapshot.data!);
                final searchRes =
                    filteredByName(_controllerSearch.text, snapshot.data!);
                return SearchResultList(
                  filteredSights: searchRes,
                  searchString: _controllerSearch.text,
                );
              } else {
                return const EmptySearchResult();
              }
            },
          ),
        ],
      ),
    );
  }

  void updateHistory(List<String> newHistoryList) {
    setState(() {
      historyList = newHistoryList;
    });
  }

  List<PlaceDto> filteredByName(String name, List<PlaceDto> places) {
    final _filredPlaces = <PlaceDto>[];
    for (final place in places) {
      final _indexName = place.name.toLowerCase().indexOf(name.toLowerCase());
      if (_indexName == 0) {
        _filredPlaces.add(place);
      }
    }

    return _filredPlaces;
  }

  void _updateHistoryList(List<PlaceDto> places) {
    final query = _controllerSearch.text;
    if (query.isNotEmpty) {
      for (var place in places) {
        historyList.add(place.name);
      }
      historyList = historyList.toSet().toList();
    }
  }
}

class _HistoryList extends StatefulWidget {
  final List<String> historyList;
  final TextEditingController controllerSearch;
  final Function(List<String>) updateHistory;

  const _HistoryList({
    Key? key,
    required this.historyList,
    required this.updateHistory,
    required this.controllerSearch,
  }) : super(key: key);

  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<_HistoryList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
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
                        setState(
                          () {
                            widget.historyList
                                .remove(widget.historyList[index]);
                            widget.updateHistory(widget.historyList);
                          },
                        );
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
  final Function(List<String>) updateHistory;

  const _ClearHistoryButton({
    Key? key,
    required this.historyList,
    required this.updateHistory,
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
              widget.updateHistory([]);
            },
          );
        },
        child: Text(
          'Очистить историю',
          style: TextStyle(
            color: Theme.of(context).buttonColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}