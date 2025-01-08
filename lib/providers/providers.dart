import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_list_riverpod_example/todo.dart';
import 'package:uuid/uuid.dart';

part 'providers.g.dart';

const _uuid = Uuid();

/// An object that controls a list of [Todo].
@Riverpod(keepAlive: true, dependencies: [])
class TodoList extends _$TodoList {
  @override
  List<Todo> build() => const [
        Todo(id: 'todo-0', description: 'Buy cookies'),
        Todo(id: 'todo-1', description: 'Star Riverpod'),
        Todo(id: 'todo-2', description: 'Have a walk'),
      ];

  void add(String description) {
    state = [
      ...state,
      Todo(
        id: _uuid.v4(),
        description: description,
      ),
    ];
  }

  void toggle(String id) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: !todo.completed,
            description: todo.description,
          )
        else
          todo,
    ];
  }

  void edit({required String id, required String description}) {
    state = [
      for (final todo in state)
        if (todo.id == id)
          Todo(
            id: todo.id,
            completed: todo.completed,
            description: description,
          )
        else
          todo,
    ];
  }

  void remove(Todo target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }
}

/// The different ways to filter the list of todos
enum TodoFilter {
  all,
  active,
  completed,
}

@Riverpod(keepAlive: true, dependencies: [])
class TodoListFilter extends _$TodoListFilter {
  @override
  TodoFilter build() {
    return TodoFilter.all;
  }

  void select(TodoFilter todoFilter) {
    state = todoFilter;
  }
}

@Riverpod(keepAlive: false, dependencies: [TodoList])
int uncompletedTodosCount(Ref ref) {
  final count =
      ref.watch(todoListProvider).where((todo) => !todo.completed).length;
  return count;
}

@Riverpod(keepAlive: false, dependencies: [TodoListFilter, TodoList])
List<Todo> filteredTodos(Ref ref) {
  final filter = ref.watch(todoListFilterProvider);
  final todos = ref.watch(todoListProvider);

  switch (filter) {
    case TodoFilter.completed:
      return todos.where((todo) => todo.completed).toList();
    case TodoFilter.active:
      return todos.where((todo) => !todo.completed).toList();
    case TodoFilter.all:
      return todos;
  }
}

/// A provider which exposes the [Todo] displayed by a [TodoItem].
///
/// By retrieving the [Todo] through a provider instead of through its
/// constructor, this allows [TodoItem] to be instantiated using the `const` keyword.
///
/// This ensures that when we add/remove/edit todos, only what the
/// impacted widgets rebuilds, instead of the entire list of items.
@riverpod
Todo currentTodo(Ref ref) {
  throw UnimplementedError();
}
