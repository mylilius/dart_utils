library dart_utils;

import 'dart:async';

import 'package:dart_utils/state/state.dart';


class TimedState<T> extends SingleState<T> {

  late final Timer _timer;
  late int _duration;

  TimedState(Function fn, int period, [int? duration]) {
    if (duration != null) {
      _duration = duration;
    }
    _timer = Timer.periodic(Duration(seconds: period), (Timer _t) {
      T? _value = fn();
      print("Timer Value: ${_value}");
      if (_value != null) {
        print("Setting State");
        setState(_value);
      }
      if (duration != null) {
        _duration -= period;
        if (_duration == 0) {
          dispose();
        }
      }

    });
  }

  @override
  Future<void> dispose() async {
    await super.dispose();
    _timer.cancel();
  }
}