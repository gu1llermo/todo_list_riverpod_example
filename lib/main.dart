import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/providers.dart';

final addTodoKey = UniqueKey();
final activeFilterKey = UniqueKey();
final completedFilterKey = UniqueKey();
final allFilterKey = UniqueKey();

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  late TextEditingController newTodoController;

  @override
  void initState() {
    super.initState();
    newTodoController = TextEditingController();
  }

  @override
  void dispose() {
    newTodoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(filteredTodosProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          children: [
            const Title(),
            TextField(
              key: addTodoKey,
              controller: newTodoController,
              decoration: const InputDecoration(
                labelText: 'What needs to be done?',
              ),
              onSubmitted: (value) {
                ref.read(todoListProvider.notifier).add(value);
                newTodoController.clear();
              },
            ),
            const SizedBox(height: 42),
            const Toolbar(),
            if (todos.isNotEmpty) const Divider(height: 0),
            for (var i = 0; i < todos.length; i++) ...[
              if (i > 0) const Divider(height: 0),
              Dismissible(
                key: ValueKey(todos[i].id),
                onDismissed: (_) {
                  ref.read(todoListProvider.notifier).remove(todos[i]);
                },
                child: ProviderScope(
                  overrides: [
                    currentTodoProvider.overrideWithValue(todos[i]),
                  ],
                  child: const TodoItem(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class Toolbar extends ConsumerWidget {
  const Toolbar({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filter = ref.watch(todoListFilterProvider);

    Color? textColorFor(TodoFilter value) {
      return filter == value ? Colors.blue : Colors.black;
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '${ref.watch(uncompletedTodosCountProvider)} items left',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Tooltip(
          key: allFilterKey,
          message: 'All todos',
          child: TextButton(
            onPressed: () => ref
                .read(todoListFilterProvider.notifier)
                .select(TodoFilter.all),
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              foregroundColor:
                  WidgetStateProperty.all(textColorFor(TodoFilter.all)),
            ),
            child: const Text('All'),
          ),
        ),
        Tooltip(
          key: activeFilterKey,
          message: 'Only uncompleted todos',
          child: TextButton(
            onPressed: () => ref
                .read(todoListFilterProvider.notifier)
                .select(TodoFilter.active),
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              foregroundColor: WidgetStateProperty.all(
                textColorFor(TodoFilter.active),
              ),
            ),
            child: const Text('Active'),
          ),
        ),
        Tooltip(
          key: completedFilterKey,
          message: 'Only completed todos',
          child: TextButton(
            onPressed: () => ref
                .read(todoListFilterProvider.notifier)
                .select(TodoFilter.completed),
            style: ButtonStyle(
              visualDensity: VisualDensity.compact,
              foregroundColor: WidgetStateProperty.all(
                textColorFor(TodoFilter.completed),
              ),
            ),
            child: const Text('Completed'),
          ),
        ),
      ],
    );
  }
}

class Title extends StatelessWidget {
  const Title({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'todos',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color.fromARGB(38, 47, 47, 247),
        fontSize: 100,
        fontWeight: FontWeight.w100,
        fontFamily: 'Helvetica Neue',
      ),
    );
  }
}

class TodoItem extends ConsumerStatefulWidget {
  const TodoItem({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TodoItemState();
}

class _TodoItemState extends ConsumerState<TodoItem> {
  late FocusNode itemFocusNode;
  bool itemIsFocused = false;
  late TextEditingController textEditingController;
  late FocusNode textFieldFocusNode;

  @override
  void initState() {
    super.initState();
    itemFocusNode = FocusNode();
    itemFocusNode.addListener(listenerFocusNode);
    textEditingController = TextEditingController();
    textFieldFocusNode = FocusNode();
  }

  void listenerFocusNode() {
    itemIsFocused = itemFocusNode.hasFocus;
  }

  @override
  void dispose() {
    itemFocusNode.removeListener(listenerFocusNode);
    itemFocusNode.dispose();
    textEditingController.dispose();
    textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final todo = ref.watch(currentTodoProvider);

    return Material(
      color: Colors.white,
      elevation: 6,
      child: Focus(
        focusNode: itemFocusNode,
        onFocusChange: (focused) {
          if (focused) {
            textEditingController.text = todo.description;
          } else {
            ref
                .read(todoListProvider.notifier)
                .edit(id: todo.id, description: textEditingController.text);
          }
        },
        child: ListTile(
          onTap: () {
            itemFocusNode.requestFocus();
            textFieldFocusNode.requestFocus();
            setState(() {});
          },
          leading: Checkbox(
            value: todo.completed,
            onChanged: (value) =>
                ref.read(todoListProvider.notifier).toggle(todo.id),
          ),
          title: itemIsFocused
              ? TextField(
                  autofocus: true,
                  focusNode: textFieldFocusNode,
                  controller: textEditingController,
                )
              : Text(todo.description),
        ),
      ),
    );
  }
}
