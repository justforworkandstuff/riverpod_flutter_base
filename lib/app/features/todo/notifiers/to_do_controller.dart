import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:dumbdumb_flutter_app/app/features/todo/model/to_do_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'to_do_controller.g.dart';

@riverpod
class ToDoController extends _$ToDoController {
  @override
  FutureOr<List<ToDoModel>> build() async {
    /// Defines an initial value when we instantiate the ToDoListNotifier
    return [
      const ToDoModel(description: 'Description 1', completed: true),
      const ToDoModel(description: 'Description 2')
    ];
  }

  Future<void> addToDo(ToDoModel toDoModel) async {
    final newList = state.valueOrNull;
    if (newList?.isNotEmpty == true) {
      final foundElement = newList?.firstWhereOrNull((element) => element.description == toDoModel.description);
      final foundElementIndex = newList?.indexWhere((element) => element.description == toDoModel.description);
      final newElement = foundElement?.copyWith(completed: toDoModel.completed);
      if (foundElement == null && foundElementIndex == -1) {
        newList?.add(toDoModel);
      } else if (newElement != null && foundElement != null && foundElementIndex != null && foundElementIndex != -1) {
        newList?.remove(foundElement);
        newList?.insert(foundElementIndex, newElement);
      }
      state = AsyncData(newList ?? List.empty());
    }

    await future;
  }

  /// ---------------------- AsyncValue handling example ----------------
  ///
  /// Consider V1 as the example where we make a network request.
  /// However, as we can see, it is only performing the post action and we're not getting nor
  /// using any callbacks to update the UI for the response.
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
  /// the successful [post] api call.
  /// *** Typically this method could be the most-preferable to use only IF the api returns us with
  /// a new response
  Future<void> addToDoV2(ToDoModel toDoModel) async {
    /// Simulate default expected api call
    // final response = await http.post(
    //   Uri.https('your_api.com', '/todos'),
    //
    //   /// We serialize our to do object and POST it to the server.
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode(toDoModel.toJson()),
    // );

    // Mock [POST] api call response data
    final mockRawResponse =
        '[{"description": "Description 1", "completed": true}, {"description": "Description 2", "completed": false}, {"description": "${toDoModel.description}", "completed": ${toDoModel.completed}}]';

    // Decode jsonString as List
    final mappedRawResponseList = List<Map<String, dynamic>>.from(jsonDecode(mockRawResponse));

    // Map raw data as model object
    List<ToDoModel> mappedDataList = mappedRawResponseList.map((e) => ToDoModel.fromJson(e)).toList();

    state = const AsyncValue.loading();

    // Simulate api call delay
    await Future.delayed(const Duration(seconds: 3));

    // We update the local cache to match the new state.
    // This will notify all listeners.
    state = AsyncData(mappedDataList);
  }

  /// V3 handles it in a way where we will be having two API calls:
  /// First being the [post] api call, then the second being a [get] api call
  /// to get the latest data.
  /// *** Typically the most preferable method to use
  Future<void> addToDoV3(ToDoModel toDoModel) async {
    /// We don't care about the API response
    // await http.post(
    //   Uri.https('your_api.com', '/todos'),
    //
    //   /// We serialize our to do object and POST it to the server.
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode(toDoModel.toJson()),
    // );

    state = const AsyncValue.loading();

    // Simulate api call delay
    await Future.delayed(const Duration(seconds: 3));

    // Once the post request is done, we can mark the local cache as dirty.
    // This will cause "build" on our notifier to asynchronously be called again,
    // and will notify listeners when doing so.
    ref.invalidateSelf();

    // ------- Unnecessary section in real scenario -------
    // Added this section to make sure the mock response returns a newer set of data after calling the [POST] api
    // Mock [GET] api call response data
    final mockRawResponse =
        '[{"description": "Description 1", "completed": true}, {"description": "Description 2", "completed": false}, {"description": "${toDoModel.description}", "completed": ${toDoModel.completed}}]';

    // Decode jsonString as List
    final mappedRawResponseList = List<Map<String, dynamic>>.from(jsonDecode(mockRawResponse));

    // Map raw data as model object
    List<ToDoModel> mappedDataList = mappedRawResponseList.map((e) => ToDoModel.fromJson(e)).toList();

    // Simulate api call delay
    await Future.delayed(const Duration(seconds: 3));

    state = AsyncData(mappedDataList);

    // ------- End -------

    // (Optional) We can then wait for the new state to be computed.
    // This ensures "addTodo" does not complete until the new state is available.
    await future;
  }

  /// V4 updates the state manually on the FE side.
  /// We will manually update the state by using previous state, then
  /// adding the [post] object.
  /// [Note]: This will require us to know if the BE inserts the new object into
  /// the start or the end of the list.
  /// *** Typically the most non-preferable method to use
  Future<void> addToDoV4(ToDoModel toDoModel) async {
    /// We don't care about the API response
    // await http.post(
    //   Uri.https('your_api.com', '/todos'),
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode(todo.toJson()),
    // );

    // Simulate api call delay
    await Future.delayed(const Duration(seconds: 3));

    // We can then manually update the local cache. For this, we'll need to
    // obtain the previous state.
    // Caution: The previous state may still be loading or in error state.
    // A graceful way of handling this would be to read `this.future` instead
    // of `this.state`, which would enable awaiting the loading state, and
    // throw an error if the state is in error state.
    final previousState = await future;

    // We can then update the state, by creating a new state object.
    // This will notify all listeners.
    state = AsyncData([...previousState, toDoModel]);
  }

  /// ---------------------- AsyncValue handling example ----------------
}
