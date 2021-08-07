import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domains/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/colors.dart';
import 'package:places/ui/icons.dart';
import 'package:places/ui/screens/sight_bottom_nav_bar.dart';
import 'package:places/ui/widgets/search_screen/empty_search_result.dart';
import 'package:places/ui/widgets/search_screen/search_bar.dart';
import 'package:places/ui/widgets/main_list_screen/sight_app_bar.dart';
import 'package:places/ui/widgets/search_screen/search_result_list.dart';

List<String> historyList = [
  'Кофейня у Рустама',
  'Рускеала',
  'Музей истории Российской Федерации',
  'Зелёные рощи',
];

class SightSearchScreen extends StatefulWidget {
  const SightSearchScreen({Key? key}) : super(key: key);

  @override
  _SightSearchScreenState createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  final _controllerSearch = TextEditingController();

  final List<Sight> _sights = mocks;
  List<Sight> _filteredSights = [];

  void _searchSights() {
    final query = _controllerSearch.text;

    if (query.isNotEmpty) {
      _filteredSights = _sights.where((Sight sight) {
        return sight.name.toLowerCase().startsWith(query.toLowerCase());
        //return sight.name.toLowerCase().contains(query.toLowerCase());
      }).toList();

      if (_filteredSights.isNotEmpty) {
        _filteredSights.forEach((element) => historyList.add(element.name));
        historyList = historyList.toSet().toList();
      }
    } else {
      _filteredSights = [];
    }
  }

  refresh() {
    setState(() {
      _searchSights();
    });
  }

  updateHistory(newHistoryList) {
    setState(() {
      historyList = newHistoryList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SightAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          SearchBar(
            controllerSearch: _controllerSearch,
            notifyParent: () {
              refresh();
            },
          ),
          const SizedBox(height: 38),
          if (_controllerSearch.text.isNotEmpty && _filteredSights.length == 0)
            EmptySearchResult()
          else
            SearchResultList(
              filteredSights: _filteredSights,
              searchString: _controllerSearch.text,
            ),
          if (historyList.length > 0 && _controllerSearch.text == '')
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'ВЫ ИСКАЛИ',
                    style: TextStyle(
                      color: textColorSecondary.withOpacity(0.56),
                      fontSize: 12,
                    ),
                  ),
                ),
                _HistoryList(
                  historyList: historyList.toList(),
                  notifyParent: refresh,
                  updateHistory: (history) {
                    updateHistory(history);
                  },
                ),
                _ClearHistoryButton(
                  historyList: historyList.toList(),
                  notifyParent: () {
                    refresh();
                  },
                  updateHistory: (history) {
                    updateHistory(history);
                  },
                ),
              ],
            ),
        ],
      ),
      bottomNavigationBar: SightBottomNavBar(),
    );
  }
}

class _HistoryList extends StatefulWidget {
  final List<String> historyList;
  final Function() notifyParent;
  final Function(List<String>) updateHistory;

  const _HistoryList({
    Key? key,
    required this.historyList,
    required this.notifyParent,
    required this.updateHistory,
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
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 0,
          ),
          child: Column(
            children: [
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.historyList[index],
                    style: TextStyle(
                      color: favoriteColor,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(0.0),
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
                        color: textColorSecondary,
                      ),
                    ),
                  )
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
  final Function() notifyParent;
  final Function(List<String>) updateHistory;

  const _ClearHistoryButton({
    Key? key,
    required this.historyList,
    required this.notifyParent,
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
              color: lightGreen, fontSize: 16, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
