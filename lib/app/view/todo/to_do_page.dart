import 'package:dumbdumb_flutter_app/app/assets/importers/importer_general.dart';
import 'package:dumbdumb_flutter_app/app/assets/importers/importer_model.dart';
import 'package:dumbdumb_flutter_app/app/assets/importers/importer_screens.dart';
import 'package:dumbdumb_flutter_app/app/assets/importers/importer_structural.dart';
import 'package:dumbdumb_flutter_app/app/utils/util.dart';

class ToDoPage extends BaseConsumerWidget {
  const ToDoPage({super.key});

  @override
  Widget body(BuildContext context, WidgetRef ref) {
    final toDoList = ref.watch(toDoListNotifierProvider);
    return switch (toDoList) {
      AsyncData(:final value) => ListView.builder(
          itemCount: value.length,
          itemBuilder: (context, index) {
            return CheckBoxItemWidget(
                itemTitle: value[index].description ?? '',
                action: (isChecked) => _actionUpdateState(ref, value[index], isChecked));
          }),
      AsyncError() => Text(S.current.generalError),
      _ => const Center(child: CircularProgressIndicator())
    };
  }

  Widget _buildCustomDialogWidget(BuildContext context) {
    var inputValue = '';
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          onChanged: (value) {
            inputValue = value;
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(child: Text(S.current.textOk), onPressed: () => context.pop(inputValue)),
            TextButton(child: Text(S.current.cancel), onPressed: () => context.pop()),
          ],
        ),
      ],
    );
  }

  void _actionUpdateState(WidgetRef ref, ToDoModel model, bool isChecked) {
    final updatedModel = model.copyWith(completed: isChecked);
    ref.read(toDoListNotifierProvider.notifier).addToDo(updatedModel);
  }

  void _actionAddNewToDo(WidgetRef ref, BuildContext context) async {
    final String? dialogCallback = await WidgetUtil.showAlertDialog(context,
        title: S.current.newToDo,
        dismissible: false,
        customWidget: _buildCustomDialogWidget(context));
    if (dialogCallback?.isNotEmpty == true) {
      final newToDoModel = ToDoModel(description: dialogCallback, completed: false);
      ref.read(toDoListNotifierProvider.notifier).addToDo(newToDoModel);
    }
  }

  @override
  AppBar? appBar() => AppBar(title: Text(S.current.todo), centerTitle: true);

  @override
  Widget? floatingActionButton(WidgetRef ref, BuildContext context) =>
      FloatingActionButton(onPressed: () => _actionAddNewToDo(ref, context), child: const Icon(Icons.add));
}

/// Sample usage of ConsumerStatefulWidget (handling local state changes together with Riverpod)
// class ToDoPage extends BaseConsumerStatefulWidget {
//   const ToDoPage({super.key});
//
//   @override
//   BaseConsumerStatefulWidgetState createState() => _ToDoPageState();
// }
//
// class _ToDoPageState extends BaseConsumerStatefulWidgetState<ToDoPage> {
//   /// The pending addTodo operation. Or null if none is pending.
//   Future<void>? _pendingAddToDo;
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: _pendingAddToDo,
//       builder: (context, snapshot) {
//         /// Compute whether there is an error state or not.
//         /// The connectionState check is here to handle when the operation is retried.
//         final isError = snapshot.hasError && snapshot.connectionState != ConnectionState.waiting;
//
//         /// Get the data
//         final AsyncValue<List<ToDoModel>> data = ref.watch(toDoListNotifierProvider);
//
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//                 onPressed: () {
//                   /// Using "ref.read" combined with "myProvider.notifier", we can
//                   /// obtain the class instance of our notifier. This enables us
//                   /// to call the "addTodo" method.
//                   ref
//                       .read(toDoListNotifierProvider.notifier)
//                       .addToDoV1(const ToDoModel(description: 'This is a new todo v1'));
//                 },
//                 child: const Text('Add to-do v1')),
//             ElevatedButton(
//                 style: ButtonStyle(backgroundColor: MaterialStateProperty.all(isError ? Colors.red : null)),
//                 onPressed: () {
//                   /// We keep the future returned by addTodo in a variable
//                   final future = ref
//                       .read(toDoListNotifierProvider.notifier)
//                       .addToDoV2(const ToDoModel(description: 'This is a new todo v2'));
//
//                   /// We store that future in the local state
//                   setState(() {
//                     _pendingAddToDo = future;
//                   });
//                 },
//                 child: const Text('Add to-do v2')),
//             ElevatedButton(
//                 style: ButtonStyle(backgroundColor: MaterialStateProperty.all(isError ? Colors.red : null)),
//                 onPressed: () {
//                   /// We keep the future returned by addTodo in a variable
//                   final future = ref
//                       .read(toDoListNotifierProvider.notifier)
//                       .addToDoV3(const ToDoModel(description: 'This is a new todo v3'));
//
//                   /// We store that future in the local state
//                   setState(() {
//                     _pendingAddToDo = future;
//                   });
//                 },
//                 child: const Text('Add to-do v3')),
//             ElevatedButton(
//                 style: ButtonStyle(backgroundColor: MaterialStateProperty.all(isError ? Colors.red : null)),
//                 onPressed: () {
//                   /// We keep the future returned by addTodo in a variable
//                   final future = ref
//                       .read(toDoListNotifierProvider.notifier)
//                       .addToDoV4(const ToDoModel(description: 'This is a new todo v4'));
//
//                   /// We store that future in the local state
//                   setState(() {
//                     _pendingAddToDo = future;
//                   });
//                 },
//                 child: const Text('Add to-do v4')),
//             Container(
//               height: height() * 0.5,
//               width: double.maxFinite,
//               alignment: Alignment.center,
//               child: data.when(data: (value) => _buildListView(value),
//                   error: (_, __) => const Text('Error!'),
//                   loading: () => const CircularProgressIndicator()),
//             )
//           ],
//         );
//       },
//     );
//   }
//
//   Widget _buildListView(List<ToDoModel> data) {
//     return Column(
//       children: [
//         const Align(
//             alignment: Alignment.center,
//             child: Text('To-do list',
//                 style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline))),
//         Expanded(
//           child: ListView.builder(
//               itemCount: data.length,
//               itemBuilder: (context, index) {
//                 return Center(child: Text(data[index].description ?? ''));
//               }),
//         ),
//       ],
//     );
//   }
// }
