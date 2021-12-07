import 'package:places/data/redux/action/filtered_places_action.dart';
import 'package:places/data/redux/reducer/filtered_places_reducer.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/domain/place.dart';
import 'package:redux/redux.dart';

// AppState appReducer(AppState state, dynamic action,){
//   return AppState(filteredPlacesState: reducerApp(state.filteredPlacesState,));
// }

// AppState appReducer(AppState state, action) {
//   return state.copyWith( filteredPlacesState: reducerApp(state, action));
//     // isDataLoading: _isDataLoadingReducer(state.isDataLoading, action),
//     // isNextPageAvailable:
//     //     _isNextPageAvailableReducer(state.isNextPageAvailable, action),
//     // items: _itemsReducer(state.items, action),
//     // error: _errorReducer(state.error, action),
//   // );
// }

final reducerApp = combineReducers<AppState>([
  TypedReducer<AppState, LoadFilteredPlacesAction>(loadFilteredPlacesReducer),
  TypedReducer<AppState, ResultFilteredPlacesAction>(resultFilteredPlacesReducer),
]);