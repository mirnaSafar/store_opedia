import 'package:bloc/bloc.dart';

part 'work_time_state.dart';

class WorkTimeCubit extends Cubit<WorkTimeState> {
  WorkTimeCubit() : super(WorkTimeState(isOpen: false));

  void switchToOpenStatus() => emit(WorkTimeState(isOpen: true));
  void switchToCloseStatus() => emit(WorkTimeState(isOpen: false));
}
