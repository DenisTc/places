import 'package:places/data/redux/action/filtered_places_action.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/data/redux/state/filtered_places_state.dart';

AppState loadFilteredPlacesReducer(AppState state, LoadFilteredPlacesAction action){
  return state.copyWith(filteredPlacesState: FilteredPlacesLoadingState());
}

AppState errorFilteredPlacesReducer(AppState state, ErrorFilteredPlacesAction action){
  return state.copyWith(filteredPlacesState: FilteredPlacesErrorState(action.message));
}

AppState resultFilteredPlacesReducer(AppState state, ResultFilteredPlacesAction action){
  return state.copyWith(filteredPlacesState: FilteredPlacesDataState(action.places));
}

