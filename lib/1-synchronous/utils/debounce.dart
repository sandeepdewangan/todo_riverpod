import 'dart:async';
import 'dart:ui';

class Debounce {
  final int ms;
  Timer? _timer;

  Debounce({this.ms = 500});

  void run(VoidCallback action) {
    close();
    _timer = Timer(Duration(milliseconds: ms), action);
  }

  void close() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }
}
