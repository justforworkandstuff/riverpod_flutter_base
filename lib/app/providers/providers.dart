import 'package:dumbdumb_flutter_app/app/assets/importers/importer_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/importers/importer_model.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

/// Necessary for code-generation to work
part 'providers.g.dart';

/// We create a "provider", which will store a value (here "Hello world").
/// By using a provider, this allows us to mock/override the value exposed.
@riverpod
String helloWorld(HelloWorldRef ref) {
  return 'Hello World';
}

/// Technically a "functional" provider, as opposed to a notifier.
/// This will create a provider named `getItemModelProvider`
/// which will cache the result of this function.
@riverpod
Future<ItemModel> getItemModel(GetItemModelRef ref) async {
  /// Using package:http, we fetch a random activity from the Bored API.
  final response = await http.get(Uri.https('boredapi.com', '/api/activity/'));

  /// Using dart:convert, we then decode the JSON payload into a Map data structure.
  final json = jsonDecode(response.body) as Map<String, dynamic>;

  /// Finally, we convert the Map into an Activity instance.
  return ItemModel.fromJson(json);
}
