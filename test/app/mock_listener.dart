import 'package:mocktail/mocktail.dart';

/// A generic Listener class used alongside of testing with Riverpod.
/// Used to keep track of when a provider notifies its listeners
class MockListener<T> extends Mock {
  void call(T? previous, T next);
}

void main() {}
