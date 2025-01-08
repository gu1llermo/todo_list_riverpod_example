// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$uncompletedTodosCountHash() =>
    r'699bb35911ddaa836d7f53142f28887588aa62f2';

/// See also [uncompletedTodosCount].
@ProviderFor(uncompletedTodosCount)
final uncompletedTodosCountProvider = AutoDisposeProvider<int>.internal(
  uncompletedTodosCount,
  name: r'uncompletedTodosCountProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$uncompletedTodosCountHash,
  dependencies: <ProviderOrFamily>[todoListProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    todoListProvider,
    ...?todoListProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UncompletedTodosCountRef = AutoDisposeProviderRef<int>;
String _$filteredTodosHash() => r'65bd7e74e4b9276192a86d42b3440d97058c0f81';

/// See also [filteredTodos].
@ProviderFor(filteredTodos)
final filteredTodosProvider = AutoDisposeProvider<List<Todo>>.internal(
  filteredTodos,
  name: r'filteredTodosProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$filteredTodosHash,
  dependencies: <ProviderOrFamily>[todoListFilterProvider, todoListProvider],
  allTransitiveDependencies: <ProviderOrFamily>{
    todoListFilterProvider,
    ...?todoListFilterProvider.allTransitiveDependencies,
    todoListProvider,
    ...?todoListProvider.allTransitiveDependencies
  },
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FilteredTodosRef = AutoDisposeProviderRef<List<Todo>>;
String _$currentTodoHash() => r'1841c5b24df478bfd9e07b484bc5eaee408fd1ef';

/// A provider which exposes the [Todo] displayed by a [TodoItem].
///
/// By retrieving the [Todo] through a provider instead of through its
/// constructor, this allows [TodoItem] to be instantiated using the `const` keyword.
///
/// This ensures that when we add/remove/edit todos, only what the
/// impacted widgets rebuilds, instead of the entire list of items.
///
/// Copied from [currentTodo].
@ProviderFor(currentTodo)
final currentTodoProvider = AutoDisposeProvider<Todo>.internal(
  currentTodo,
  name: r'currentTodoProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentTodoHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CurrentTodoRef = AutoDisposeProviderRef<Todo>;
String _$todoListHash() => r'c770a46c439cd068ba04cf59695b7b3f92e80324';

/// An object that controls a list of [Todo].
///
/// Copied from [TodoList].
@ProviderFor(TodoList)
final todoListProvider = NotifierProvider<TodoList, List<Todo>>.internal(
  TodoList.new,
  name: r'todoListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$todoListHash,
  dependencies: const <ProviderOrFamily>[],
  allTransitiveDependencies: const <ProviderOrFamily>{},
);

typedef _$TodoList = Notifier<List<Todo>>;
String _$todoListFilterHash() => r'7216f7491e04fb05179e65dae4b5db4a7623252b';

/// See also [TodoListFilter].
@ProviderFor(TodoListFilter)
final todoListFilterProvider =
    NotifierProvider<TodoListFilter, TodoFilter>.internal(
  TodoListFilter.new,
  name: r'todoListFilterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$todoListFilterHash,
  dependencies: const <ProviderOrFamily>[],
  allTransitiveDependencies: const <ProviderOrFamily>{},
);

typedef _$TodoListFilter = Notifier<TodoFilter>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
