import 'package:places/data/redux/action/place_action.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/data/redux/state/place_state.dart';

AppState loadPlaceDetailsReducer(AppState state, LoadPlaceDetailsAction action){
  return state.copyWith(placeState: PlaceLoadingState());
}

AppState errorPlaceReducer(AppState state, ErrorPlaceAction action){
  return state.copyWith(placeState: PlaceErrorState(action.message));
}

AppState resultPlaceDetailsReducer(AppState state, ResultPlaceDetailsAction action){
  return state.copyWith(placeState: PlaceDataState(action.place));
}

AppState processAddNewPlaceReducer(AppState state, AddNewPlaceAction action){
  return state.copyWith(placeState: AddnewPlaceInProcessState());
}

AppState resultAddNewPlaceReducer(AppState state, ResultAddNewPlaceAction action){
  return state.copyWith(placeState: AddnewPlaceSuccessState());
}

AppState errorAddNewPlaceReducer(AppState state, ErrorAddNewPlaceAction action){
  return state.copyWith(placeState: AddnewPlaceErrorState(action.message));
}