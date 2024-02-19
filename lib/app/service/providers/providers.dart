import 'package:dumbdumb_flutter_app/app/core/importers/importer_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// Necessary for code-generation to work
part 'providers.g.dart';

/// The file of [providers.dart] is mainly used to hold a list of providers values
/// that will be used in the View (UI) side.
/// The providers will be getting the value from the data source layer.

/// We create a "provider", which will store a value (here "Hello world").
/// By using a provider, this allows us to mock/override the value exposed.
@riverpod
String helloWorld(HelloWorldRef ref) {
  return 'Hello World';
}
