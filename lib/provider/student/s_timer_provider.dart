import 'dart:async';
import 'package:flutter/material.dart';

class STimerProvider with ChangeNotifier {
  int _timerDurationMinutes = 0;
  int _currentSeconds = 0;
  Timer? _timer;

  int get remainingMinutes => ((_timerDurationMinutes * 60) - _currentSeconds) ~/ 60;
  int get remainingSeconds => ((_timerDurationMinutes * 60) - _currentSeconds) % 60;

  void startTimer(int timeDuration, void Function() showTimeoutDialog) {
    _timerDurationMinutes = timeDuration;
    final totalSeconds = _timerDurationMinutes * 60;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      _currentSeconds++;

      if (_currentSeconds >= totalSeconds) {
        _timer?.cancel();
        showTimeoutDialog();
      }

      notifyListeners();
    });
  }
}
