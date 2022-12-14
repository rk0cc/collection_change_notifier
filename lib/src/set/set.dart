import 'dart:collection';

import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:meta/meta.dart';

import '../abstract.dart';

part 'hash_set.dart';
part 'linked_hash_set.dart';
part 'splay_tree_set.dart';

mixin _SetChangeNotifierMixin<E>
    on Set<E>, ChangeNotifier, CollectionChangeNotifierMixin<E, int, E> {
  @protected
  Set<E> get _set;

  @override
  bool add(value) {
    bool added = _set.add(value);

    if (added) {
      notifyListeners();
    }

    return added;
  }

  @override
  void addAll(Iterable<E> elements) {
    _set.addAll(elements);
    notifyListeners();
  }

  @override
  bool remove(Object? value) {
    bool rm = _set.remove(value);

    if (rm) {
      notifyListeners();
    }

    return rm;
  }

  @override
  void removeAll(Iterable<Object?> elements) {
    _set.removeAll(elements);
    notifyListeners();
  }

  @override
  void removeWhere(bool Function(E) test) {
    _set.removeWhere(test);
    notifyListeners();
  }

  @override
  void retainAll(Iterable<Object?> elements) {
    _set.retainAll(elements);
    notifyListeners();
  }

  @override
  void retainWhere(bool Function(E) test) {
    _set.retainWhere(test);
    notifyListeners();
  }

  @override
  void clear() {
    _set.clear();
    notifyListeners();
  }

  @override
  bool contains(Object? element) => _set.contains(element);

  @override
  Iterator<E> get iterator => _set.iterator;

  @override
  int get length => _set.length;

  @override
  E? lookup(Object? element) => _set.lookup(element);

  @override
  Set<E> toSet() => _set.toSet();

  @override
  Iterable<E> get iterableForm => toSet();
}

/// An implementation of [CollectionChangeNotifierMixin] that based on [Set].
abstract class SetChangeNotifier<E>
    with ChangeNotifier, CollectionChangeNotifierMixin<E, int, E>
    implements Set<E> {
  // ignore: unused_element
  SetChangeNotifier._();

  /// Construct [LinkedHashSetChangeNotifier] with no specification.
  factory SetChangeNotifier() = LinkedHashSetChangeNotifier<E>;

  /// Construct new [SetChangeNotifier] that contains all [elements].
  factory SetChangeNotifier.from(Iterable elements) =
      LinkedHashSetChangeNotifier<E>.from;

  /// Construct new [SetChangeNotifier] with [identical] condition.
  factory SetChangeNotifier.identify() = LinkedHashSetChangeNotifier.identify;

  /// Consturct new [SetChangeNotifier] that contains [elements].
  factory SetChangeNotifier.of(Iterable<E> elements) =
      LinkedHashSetChangeNotifier.of;
}
