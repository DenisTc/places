import 'dart:convert';

import 'package:places/domain/search_filter.dart';
import 'package:places/ui/res/constants.dart' as constants;
import 'package:shared_preferences/shared_preferences.dart';

// Class fow work with shared preferences storage
class SharedStorage {
  late SharedPreferences _storage;

  Future<SearchFilter> getSearchFilter() async {
    await _init();

    // Check if there is a saved filter in SP
    if (_storage.containsKey(constants.keySPFilter)) {
      // If there is, then decode it and return it.
      final json = _storage.getString(constants.keySPFilter)!;
      final filter = jsonDecode(json) as Map<String, dynamic>;

      return SearchFilter.fromJson(filter);
    } else {
      // If there is no saved filter in the SP,
      // then check whether there is a saved geolocation in the SP.
      if (_storage.containsKey(constants.keySPUserLocation)) {
        // If the SP has a saved geolocation, then create a filter based on it
        final userLocation = await getCurrentLocation();

        return SearchFilter(
          lat: double.parse(userLocation![0]),
          lng: double.parse(userLocation[1]),
          distance: constants.defaultDistanceRange,
          typeFilter: [...constants.selectedCategories],
        );
      } else {
        return SearchFilter(typeFilter: [...constants.selectedCategories]);
      }
    }
  }

  Future<SearchFilter> getSavedSearchFilter() async {
    await _init();

    // Check if there is a saved filter in SP
    if (_storage.containsKey(constants.keySPFilter)) {
      // If there is, then decode it and return it.
      final json = _storage.getString(constants.keySPFilter)!;
      final filter = jsonDecode(json) as Map<String, dynamic>;

      return SearchFilter.fromJson(filter);
    } else {
      return SearchFilter(typeFilter: constants.selectedCategories);
    }
  }

  Future<void> setSearchFilter(SearchFilter searchFilter) async {
    await _init();

    final json = jsonEncode(searchFilter);

    await _storage.setString(constants.keySPFilter, json);
  }

  Future<void> setTheme({required bool isDark}) async {
    await _init();
    await _storage.setBool(constants.keySPTheme, isDark);
  }

  Future<bool> getTheme() async {
    await _init();

    return _storage.getBool(constants.keySPTheme) ?? false;
  }

  Future<bool> getOnboardingStatus() async {
    await _init();

    return _storage.getBool(constants.keySPOnboarding) ?? false;
  }

  Future<bool> setOnboardingStatus() async {
    await _init();

    return _storage.setBool(constants.keySPOnboarding, true);
  }

  // Geolocation
  Future<void> setUserLocation({
    required double lat,
    required double lng,
  }) async {
    await _init();
    await _storage.setStringList(
      constants.keySPUserLocation,
      [
        lat.toString(),
        lng.toString(),
      ],
    );
  }

  Future<List<String>?> getCurrentLocation() async {
    await _init();

    return _storage.getStringList(constants.keySPUserLocation);
  }

  Future<void> deleteKey(String name) => _storage.remove(name);

  Future<void> _init() async =>
      _storage = await SharedPreferences.getInstance();
}
