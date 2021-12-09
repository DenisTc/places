import 'package:places/data/redux/action/filter_action.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/data/redux/state/filter_state.dart';

AppState resultFilterReducer(AppState state, ResultFilterAction action){
  return state.copyWith(filterState: FilterLoadSuccessState(action.filter, action.count));
}