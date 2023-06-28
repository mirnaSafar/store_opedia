import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'work_time_state.dart';

class WorkTimeCubit extends Cubit<WorkTimeState> {
  WorkTimeCubit() : super(WorkTimeState(isOpen: false));

  void switchToOpenStatus() => emit(WorkTimeState(isOpen: true));
  void switchToCloseStatus() => emit(WorkTimeState(isOpen: false));

  void testOpenTime({DateTime? openTime, DateTime? closeTime}) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    DateTime? _openTime = openTime ?? _pref.get("startWorkTime") as DateTime?;
    DateTime? _closeTime = closeTime ?? _pref.get("endWorkTime") as DateTime?;
    DateTime? now = DateTime.now();
    if (_openTime != null && _closeTime != null) {
      if (now.isAfter(_openTime) && now.isBefore(_closeTime)) {
        switchToOpenStatus();
      } else {
        switchToCloseStatus();
      }
    }
    switchToCloseStatus();
  }
}
