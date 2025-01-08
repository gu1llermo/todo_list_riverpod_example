import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_list_riverpod_example/todo.dart';
import 'package:uuid/uuid.dart';

part 'providers.g.dart';

// Instancia de UUID para generar IDs únicos
const _uuid = Uuid();

// Provider principal para manejar la lista de todos
@Riverpod(keepAlive: true, dependencies: [])
class TodoList extends _$TodoList {
  @override
  List<Todo> build() => const [
        // Lista inicial de todos como ejemplo
        Todo(id: 'todo-0', description: 'Buy cookies'),
        Todo(id: 'todo-1', description: 'Star Riverpod'),
        Todo(id: 'todo-2', description: 'Have a walk'),
      ];

  // Método para agregar un nuevo todo
  void add(String description) {
    state = [
      ...state,
      Todo(
        id: _uuid.v4(), // Genera un ID único
        description: description,
      ),
    ];
  }

  // Método para cambiar el estado completed de un todo
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

  // Método para editar la descripción de un todo
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

  //Método para eliminar un todo
  void remove(Todo target) {
    state = state.where((todo) => todo.id != target.id).toList();
  }
}

// Enumeración para los diferentes filtros de todos
enum TodoFilter {
  all,
  active,
  completed,
}

// Provider para manejar el filtro actual
@Riverpod(keepAlive: true, dependencies: [])
class TodoListFilter extends _$TodoListFilter {
  @override
  TodoFilter build() => TodoFilter.all;

  void select(TodoFilter todoFilter) => state = todoFilter;
}

// Provider que cuenta los todos no completados
@Riverpod(keepAlive: false, dependencies: [TodoList])
int uncompletedTodosCount(Ref ref) {
  final count =
      ref.watch(todoListProvider).where((todo) => !todo.completed).length;
  return count;
}

// Provider que filtra los todos según el filtro seleccionado
@Riverpod(keepAlive: false, dependencies: [TodoListFilter, TodoList])
List<Todo> filteredTodos(Ref ref) {
  final filter = ref.watch(todoListFilterProvider);
  final todos = ref.read(todoListProvider);

  // Escucha cambios en la lista de todos
  // lo hago para que solo reconstruya la lista de todos
  // cuando cambie el número de todos o el estado completed de algún todo
  ref.listen(
    todoListProvider,
    (previous, next) {
      // Invalida el provider si cambia el número de todos
      if (previous == null || previous.length != next.length) {
        ref.invalidateSelf();
        return;
      }

      // Invalida el provider si cambia el estado completed de algún todo
      for (var i = 0; i < next.length; i++) {
        if (previous[i].completed != next[i].completed) {
          ref.invalidateSelf();
          break;
        }
      }
    },
  );

  // Aplica el filtro correspondiente
  switch (filter) {
    case TodoFilter.completed:
      return todos.where((todo) => todo.completed).toList();
    case TodoFilter.active:
      return todos.where((todo) => !todo.completed).toList();
    case TodoFilter.all:
      return todos;
  }
}

// Provider para el todo actual (se sobreescribe en el main.dart)
@riverpod
Todo currentTodo(Ref ref) {
  throw UnimplementedError();
}
