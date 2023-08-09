import 'package:timer_count_down/timer_controller.dart';

class TimerController {
  var timeController = CountdownController();
  var countdownController = CountdownController(autoStart: true);
  late int timerDuration;
  int countdownDuration = 3;

  set duration(int seconds) => timerDuration = seconds;

  void resetControllers() {
    timeController = CountdownController();
    countdownController = CountdownController(autoStart: true);
  }

  void pauseControllers() {
    countdownController.pause();
    timeController.pause();
  }

  void resumeController() {
    if (countdownController.isCompleted!) {
      timeController.resume();
    } else {
      countdownController.resume();
    }
  }

  bool get isCountdownCompleted => countdownController.isCompleted ?? false;
}
