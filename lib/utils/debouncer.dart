import 'dart:async';

class Debouncer {
  Debouncer({
    required this.duration,
  });
  final Duration duration;
  void Function()? _action;

  Timer? _timer;

  void pushTask(void Function() callback) {
    _timer?.cancel();
    _action = callback;
    _timer = Timer(duration, debounce);
  }


  void forceTask() {
    if (_action != null) {
      _action!();
      _timer!.cancel();
      _timer = null;
      _action = null;
    }
  }

  void debounce() {
    _action!.call();
    _action = null;
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    _timer?.cancel();
  }
}