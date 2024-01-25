import 'package:dumbdumb_flutter_app/app/assets/importers/importer_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/importers/importer_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'to_do_list_notifier.g.dart';

@riverpod
class ToDoListNotifier extends _$ToDoListNotifier {
  @override
  FutureOr<List<ToDoModel>> build() async {
    /// Defines an initial value when we instantiate the ToDoListNotifier
    return [ToDoModel(description: 'Description 1', completed: true), ToDoModel(description: 'Description 2')];
  }

  /// Consider V1 as the example where we make a network request.
  /// However, as we can see, it is only performing the post action and we're not getting and using any callbacks
  /// to update the UI for the response.
  Future<void> addToDoV1(ToDoModel toDoModel) async {
    /// Simulate default expected api call
    // await http.post(
    //   Uri.https('your_api.com', '/todos'),
    //
    //   /// We serialize our to do object and POST it to the server.
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode(toDoModel.toJson()),
    // );
  }

  /// V2 simulates the api call returns response with [mockRawResponse]
  /// Then how can it be handle to update the UI with the new data.
  /// [Note]: This will only work IF the api returns us the new list of the response after
  /// the successful [POST] api call.
  Future<void> addToDoV2(ToDoModel toDoModel) async {
    /// Simulate default expected api call
    // final response = await http.post(
    //   Uri.https('your_api.com', '/todos'),
    //
    //   /// We serialize our to do object and POST it to the server.
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode(toDoModel.toJson()),
    // );

    /// Mock [POST] api call response data
    final mockRawResponse =
        '[{\"description\": \"Description 1\", \"completed\": true}, {\"description\": \"Description 2\", \"completed\": false}, {\"description\": \"This is a new todo v2\", \"completed\": true}]';

    /// Decode jsonString as List
    final mappedRawResponseList = List<Map<String, dynamic>>.from(jsonDecode(mockRawResponse));

    /// Map raw data as model object
    List<ToDoModel> mappedDataList = mappedRawResponseList.map((e) => ToDoModel.fromJson(e)).toList();

    state = AsyncValue.loading();

    /// Simulate api call delay
    await Future.delayed(Duration(seconds: 3));

    /// We update the local cache to match the new state.
    /// This will notify all listeners.
    state = AsyncData(mappedDataList);
  }

  /// V3 handles it in a way where we will be having two API calls:
  /// First being the [POST] api call, then the second being a [GET] api call
  /// to get the latest data.
  Future<void> addToDoV3(ToDoModel toDoModel) async {
    /// We don't care about the API response
    // await http.post(
    //   Uri.https('your_api.com', '/todos'),
    //
    //   /// We serialize our to do object and POST it to the server.
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode(toDoModel.toJson()),
    // );

    state = AsyncValue.loading();

    /// Simulate api call delay
    await Future.delayed(Duration(seconds: 3));

    /// Once the post request is done, we can mark the local cache as dirty.
    /// This will cause "build" on our notifier to asynchronously be called again,
    /// and will notify listeners when doing so.
    ref.invalidateSelf();

    /// Mock [GET] api call response data
    final mockRawResponse =
        '[{\"description\": \"Description 1\", \"completed\": true}, {\"description\": \"Description 2\", \"completed\": false}, {\"description\": \"This is a new todo v3\", \"completed\": true}]';

    /// Decode jsonString as List
    final mappedRawResponseList = List<Map<String, dynamic>>.from(jsonDecode(mockRawResponse));

    /// Map raw data as model object
    List<ToDoModel> mappedDataList = mappedRawResponseList.map((e) => ToDoModel.fromJson(e)).toList();

    /// Simulate api call delay
    await Future.delayed(Duration(seconds: 3));

    state = AsyncData(mappedDataList);

    /// (Optional) We can then wait for the new state to be computed.
    /// This ensures "addTodo" does not complete until the new state is available.
    await future;
  }

  /// V4 updates the state manually on the FE side.
  /// We will manually update the state by using previous state, then
  /// adding the [POST] object.
  /// [Note]: This will require us to know if the BE inserts the new object into
  /// the start or the end of the list.
  Future<void> addToDoV4(ToDoModel toDoModel) async {
    /// We don't care about the API response
    // await http.post(
    //   Uri.https('your_api.com', '/todos'),
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode(todo.toJson()),
    // );

    /// Simulate api call delay
    await Future.delayed(Duration(seconds: 3));

    /// We can then manually update the local cache. For this, we'll need to
    /// obtain the previous state.
    /// Caution: The previous state may still be loading or in error state.
    /// A graceful way of handling this would be to read `this.future` instead
    /// of `this.state`, which would enable awaiting the loading state, and
    /// throw an error if the state is in error state.
    final previousState = await future;

    /// We can then update the state, by creating a new state object.
    /// This will notify all listeners.
    state = AsyncData([...previousState, toDoModel]);
  }
}