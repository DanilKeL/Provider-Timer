import 'dart:async';

import 'package:flutter/material.dart';

class TimerProvider extends ChangeNotifier {
  Timer? _timer;
  int _currentWaitTime = 30;
  final int _waitTime = 30;
  bool _isStart = false;
  double _percent = 3.0;
  late String _timeStr;

  int get currentWaitTime => _currentWaitTime;
  int get waitTime => _waitTime;
  bool get isStart => _isStart;
  double get percent => _percent;
  String get timeStr => _timeStr;


  void start(BuildContext context) {
    if (currentWaitTime > 0) {
        _isStart = true;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _currentWaitTime -= 1;
        notifyListeners();
        calculationTime();
        if (currentWaitTime <= 0) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Finish')));
          pause();
        }
      });
    }
  }

  void restart() {
    _currentWaitTime = waitTime;
    calculationTime();
    notifyListeners();
  }

  void pause() {
    _timer?.cancel();
    _isStart = false;
    notifyListeners();
  }

  void calculationTime() {
    var minuteStr = (currentWaitTime ~/ 60).toString().padLeft(2, '0');
    var secondStr = (currentWaitTime % 60).toString().padLeft(2, '0');
      _percent = currentWaitTime / 30;
      _timeStr = '$minuteStr:$secondStr';
  }

}
