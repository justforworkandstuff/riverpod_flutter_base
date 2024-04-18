import 'package:dumbdumb_flutter_app/app/features/counter/controllers/counter_controller.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import '../../../mock_listener.dart';
import '../../../riverpod_utility_provider_container_test.dart';

void main() {
  group('counterController group tests', () {
    test(
        'GIVEN a providerNotifier of [CounterController] class '
        'WHEN instance of the providerNotifier is initialized '
        'THEN the corresponding initialization value of 0 of type [int] should be returned.', () {
      // Given
      final container = createContainer();
      final listener = MockListener<int?>();
      // When
      container.listen<int?>(counterControllerProvider, listener.call, fireImmediately: true);
      // Then
      verify(() => listener(null, 0));
      verifyNoMoreInteractions(listener);
    });

    test(
        'GIVEN a providerNotifier of [CounterController] class '
        'WHEN the [increment()] method of providerNotifier is called '
        'THEN the corresponding initialization value of 1 of type [int] should be returned.', () {
      // Given
      final container = createContainer();
      final listener = MockListener<int?>();

      // Initialization
      container.listen<int?>(counterControllerProvider, listener.call, fireImmediately: true);
      verify(() => listener(null, 0));

      // Method call
      final notifier = container.read(counterControllerProvider.notifier);
      notifier.increment();
      verify(() => listener(0, 1));

      // Ends
      verifyNoMoreInteractions(listener);
    });

    test(
        'GIVEN a providerNotifier of [CounterController] class '
        'WHEN the [decrement()] method of providerNotifier is called '
        'THEN the corresponding initialization value of -1 of type [int] should be returned.', () {
      // Given
      final container = createContainer();
      final listener = MockListener<int?>();

      // Initialization
      container.listen<int?>(counterControllerProvider, listener.call, fireImmediately: true);
      verify(() => listener(null, 0));

      // Method call
      final notifier = container.read(counterControllerProvider.notifier);
      notifier.decrement();
      verify(() => listener(0, -1));

      // Ends
      verifyNoMoreInteractions(listener);
    });
  }, tags: ['mobile', 'unit']);
}
