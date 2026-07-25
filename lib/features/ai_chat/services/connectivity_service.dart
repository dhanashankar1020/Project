import 'dart:async';
import 'dart:io';

/// Lightweight connectivity monitor that works without any third-party package.
///
/// It performs a DNS lookup to 8.8.8.8 (Google DNS) and considers the device
/// online only if that succeeds. The check is run periodically and whenever
/// explicitly requested.
class ConnectivityService {
  ConnectivityService._();
  static final ConnectivityService instance = ConnectivityService._();

  // Internal state
  bool _isConnected = false;
  Timer? _pollTimer;

  final StreamController<bool> _controller =
      StreamController<bool>.broadcast();

  /// Stream of connectivity changes. Emits `true` when online, `false` when not.
  Stream<bool> get onConnectivityChanged => _controller.stream;

  bool get isConnected => _isConnected;

  /// Start polling connectivity every [intervalSeconds] seconds (default: 15).
  void startMonitoring({int intervalSeconds = 15}) {
    _pollTimer?.cancel();
    _checkAndNotify(); // immediate first check
    _pollTimer = Timer.periodic(
      Duration(seconds: intervalSeconds),
      (_) => _checkAndNotify(),
    );
  }

  /// Stop background polling.
  void stopMonitoring() {
    _pollTimer?.cancel();
    _pollTimer = null;
  }

  /// Force a connectivity check immediately.
  Future<bool> checkNow() async {
    await _checkAndNotify();
    return _isConnected;
  }

  Future<void> _checkAndNotify() async {
    final wasConnected = _isConnected;
    _isConnected = await _canReach();
    if (_isConnected != wasConnected) {
      _controller.add(_isConnected);
    }
  }

  Future<bool> _canReach() async {
    try {
      final result = await InternetAddress.lookup('google.com')
          .timeout(const Duration(seconds: 4));
      return result.isNotEmpty && result.first.rawAddress.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  void dispose() {
    stopMonitoring();
    _controller.close();
  }
}
