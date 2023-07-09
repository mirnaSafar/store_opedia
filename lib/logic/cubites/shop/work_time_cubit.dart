import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shopesapp/main.dart';

part 'work_time_state.dart';

class WorkTimeCubit extends Cubit<WorkTimeState> {
  WorkTimeCubit() : super(WorkTimeState(isOpen: false));

  TimeOfDay timeConvert(String normTime) {
    int hour;
    int minute;
    String ampm = normTime.substring(normTime.length - 2);
    String result = normTime.substring(0, normTime.indexOf(' '));
    if (ampm == 'AM' && int.parse(result.split(":")[1]) != 12) {
      hour = int.parse(result.split(':')[0]);
      if (hour == 12) hour = 0;
      minute = int.parse(result.split(":")[1]);
    } else {
      hour = int.parse(result.split(':')[0]) - 12;
      if (hour <= 0) {
        hour = 24 + hour;
      }
      minute = int.parse(result.split(":")[1]);
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  void testOpenTime(
      {required String? openTime, required String? closeTime}) async {
    if (openTime != null && closeTime != null) {
      TimeOfDay _startTime = timeConvert(openTime);

      TimeOfDay _endTime = timeConvert(closeTime);

      DateTime now = DateTime.now();
      DateTime _startDateTime = DateTime(
          now.year, now.month, now.day, _startTime.hour, _startTime.minute);

      DateTime _endDateTime = DateTime(
          now.year, now.month, now.day, _endTime.hour, _endTime.minute);
      if (now.isAfter(_startDateTime) && now.isBefore(_endDateTime)) {
        //    print("open");
        emit(WorkTimeState(isOpen: true));
      } else {
        //    print("close");
        emit(WorkTimeState(isOpen: false));
      }
    } else {
      // print("close outside the if");
      emit(WorkTimeState(isOpen: false));
    }
  }
}
