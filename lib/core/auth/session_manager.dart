import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'session_manager.g.dart';

/// Events emitted by [SessionManager].
enum SessionEvent {
  /// The user's session has expired due to inactivity.
  sessionExpired,

  /// A session was explicitly ended (logout).
  sessionEnded,
}

/// Tracks user session activity and emits [SessionEvent]s via a broadcast stream.
class SessionManager {
  SessionManager({Duration? inactivityTimeout})
    : _inactivityTimeout = inactivityTimeout ?? const Duration(minutes: 30);

  final Duration _inactivityTimeout;

  final _controller = StreamController<SessionEvent>.broadcast();
  Timer? _inactivityTimer;
  bool _active = false;

  /// Stream of [SessionEvent]s — subscribe before calling [startSession].
  Stream<SessionEvent> get events => _controller.stream;

  /// Whether a session is currently active.
  bool get isActive => _active;

  // ---------------------------------------------------------------------------
  // Session lifecycle
  // ---------------------------------------------------------------------------

  /// Starts a new session and kicks off the inactivity timer.
  void startSession() {
    if (_active) return;
    _active = true;
    _resetTimer();
  }

  /// Records user activity — resets the inactivity countdown.
  void recordActivity() {
    if (!_active) return;
    _resetTimer();
  }

  /// Ends the session explicitly (e.g. user logout) and emits [SessionEvent.sessionEnded].
  void endSession() {
    if (!_active) return;
    _cancelTimer();
    _active = false;
    _emit(SessionEvent.sessionEnded);
  }

  /// Releases all resources. Call once when the app is disposed (if ever).
  void dispose() {
    _cancelTimer();
    _controller.close();
  }

  // ---------------------------------------------------------------------------
  // Internal helpers
  // ---------------------------------------------------------------------------

  void _resetTimer() {
    _cancelTimer();
    _inactivityTimer = Timer(_inactivityTimeout, _onInactivityTimeout);
  }

  void _cancelTimer() {
    _inactivityTimer?.cancel();
    _inactivityTimer = null;
  }

  void _onInactivityTimeout() {
    _active = false;
    _emit(SessionEvent.sessionExpired);
  }

  void _emit(SessionEvent event) {
    if (!_controller.isClosed) {
      _controller.add(event);
    }
  }
}

@Riverpod(keepAlive: true)
SessionManager sessionManager(Ref ref) {
  final manager = SessionManager();
  ref.onDispose(() => manager.dispose());
  return manager;
}
