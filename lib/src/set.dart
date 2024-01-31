import 'dart:collection';

import 'package:flutter/widgets.dart' show ChangeNotifier;

import 'abstract.dart';

/// [Set] base implementation with [ChangeNotifier] features.
abstract final class SetChangeNotifier<E> extends SetBase<E>
    with
        ChangeNotifier,
        CollectionChangeNotifierMixin<E, int, E>,
        IterableCollectionChangeNotifieMixin<E> {
  final Set<E> _set;

  SetChangeNotifier._(this._set);

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

/// [HashSet] based [SetChangeNotifier] implementation.
final class HashSetChangeNotifier<E> extends SetChangeNotifier<E> {
  HashSetChangeNotifier._(HashSet<E> hashSet) : super._(hashSet);

  /// Construct new [HashSetChangeNotifier] with [equals], [hashCode] and
  /// [isValidKey] configuration.
  factory HashSetChangeNotifier(
          {bool Function(E, E)? equals,
          int Function(E)? hashCode,
          bool Function(dynamic)? isValidKey}) =>
      HashSetChangeNotifier._(
          HashSet(equals: equals, hashCode: hashCode, isValidKey: isValidKey));

  /// Construct new [HashSetChangeNotifier] with [elements].
  factory HashSetChangeNotifier.from(Iterable elements) =>
      HashSetChangeNotifier._(HashSet.from(elements));

  /// Construct new [HashSetChangeNotifier] using [identical].
  factory HashSetChangeNotifier.identify() =>
      HashSetChangeNotifier._(HashSet.identity());

  /// Consturct [HashSetChangeNotifier] that contains [elements].
  factory HashSetChangeNotifier.of(Iterable<E> elements) =>
      HashSetChangeNotifier._(HashSet.of(elements));
}

/// [LinkedHashSet] based [SetChangeNotifier] implementation.
final class LinkedHashSetChangeNotifier<E> extends SetChangeNotifier<E> {
  LinkedHashSetChangeNotifier._(LinkedHashSet<E> linkedHashSet)
      : super._(linkedHashSet);

  /// Construct new [LinkedHashSetChangeNotifier] with specified [equals],
  /// [hashCode] and [isValidKey] condition.
  factory LinkedHashSetChangeNotifier(
          {bool Function(E, E)? equals,
          int Function(E)? hashCode,
          bool Function(dynamic)? isValidKey}) =>
      LinkedHashSetChangeNotifier._(LinkedHashSet(
          equals: equals, hashCode: hashCode, isValidKey: isValidKey));

  /// Construct new [LinkedHashSetChangeNotifier] with [elements].
  factory LinkedHashSetChangeNotifier.from(Iterable elements) =>
      LinkedHashSetChangeNotifier._(LinkedHashSet.from(elements));

  /// Construct [LinkedHashSetChangeNotifier] with [identical] condition.
  factory LinkedHashSetChangeNotifier.identify() =>
      LinkedHashSetChangeNotifier._(LinkedHashSet.identity());

  /// Construct new [LinkedHashSetChangeNotifier] that contains [elements].
  factory LinkedHashSetChangeNotifier.of(Iterable<E> elements) =>
      LinkedHashSetChangeNotifier._(LinkedHashSet.of(elements));
}

/// [SplayTreeSet] based [SetChangeNotifier] implementation.
final class SplayTreeSetChangeNotifier<E> extends SetChangeNotifier<E> {
  SplayTreeSetChangeNotifier._(SplayTreeSet<E> splayTreeSet)
      : super._(splayTreeSet);

  /// Consturct new [SplayTreeSetChangeNotifier] with [compare] and
  /// [isValidKey] configuration.
  factory SplayTreeSetChangeNotifier(
          [int Function(E key1, E key2)? compare,
          bool Function(dynamic potentialKey)? isValidKey]) =>
      SplayTreeSetChangeNotifier._(SplayTreeSet(compare, isValidKey));

  /// Construct new [SplayTreeSetChangeNotifier] that giving [elements] to get
  /// [key] and [value] with [compare] and [isValidKey] configuration.
  factory SplayTreeSetChangeNotifier.from(Iterable elements,
          [int Function(E key1, E key2)? compare,
          bool Function(dynamic potentialKey)? isValidKey]) =>
      SplayTreeSetChangeNotifier._(
          SplayTreeSet.from(elements, compare, isValidKey));

  /// Consturct new [SplayTreeSetChangeNotifier] that contains [elements] with
  /// [compare] and [isValidKey] configuration.
  factory SplayTreeSetChangeNotifier.of(Iterable<E> elements,
          [int Function(E key1, E key2)? compare,
          bool Function(dynamic potentialKey)? isValidKey]) =>
      SplayTreeSetChangeNotifier._(
          SplayTreeSet.of(elements, compare, isValidKey));
}
