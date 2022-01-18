import 'dart:convert';
import 'package:places/domain/search_filter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:places/ui/res/constants.dart' as constants;

// Class fow work with shared preferences storage
class SharedStorage {
  late SharedPreferences _storage;

  Future<void> _init() async =>
      _storage = await SharedPreferences.getInstance();

  Future<SearchFilter> getSearchFilter() async {
    await _init();

    if (_storage.containsKey(constants.keySPFilter)) {
      final json = _storage.getString(constants.keySPFilter)!;
      final Map<String, dynamic> filter = jsonDecode(json);

      return SearchFilter.fromJson(filter);
    } else {
      await setSearchFilter(
        SearchFilter(
          lat: constants.userLocation.lat,
          lng: constants.userLocation.lng,
          distance: constants.defaultDistanceRange,
          typeFilter: constants.selectedCategories,
        ),
      );
    }

    final Map<String, dynamic> filter =
        await jsonDecode(_storage.getString(constants.keySPFilter)!);

    return SearchFilter.fromJson(filter);
  }

  Future<void> setSearchFilter(SearchFilter searchFilter) async {
    await _init();

    final json = jsonEncode(searchFilter);

    await _storage.setString(constants.keySPFilter, json);
  }

  Future<void> setTheme(bool isDark) async {
    await _init();
    await _storage.setBool(constants.keySPTheme, isDark);
  }

  Future<bool> getTheme() async {
    await _init();
    return _storage.getBool(constants.keySPTheme) ?? false;
  }

  Future<bool> getOnboardingStatus() async{
    await _init();
    return _storage.getBool(constants.keySPOnboarding) ?? false;
  }

  Future<bool> setOnboardingStatus() async{
    await _init();
    return _storage.setBool(constants.keySPOnboarding, true);
  }
}
