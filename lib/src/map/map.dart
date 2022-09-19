import 'dart:collection';

import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:meta/meta.dart';

import '../abstract.dart';

part 'hash_map.dart';
part 'linked_hash_map.dart';
part 'splay_tree_map.dart';

/// A mixin to standarize [Map] features with [ChangeNotifier] when state
/// changed.
mixin _MapChangeNotifierMixin<K, V>
    on
        Map<K, V>,
        ChangeNotifier,
        CollectionChangeNotifierMixin<MapEntry<K, V>, K, V?> {
  /// The map of the implemented object.
  ///
  /// Please apply it as getter for getting corresponded [Map] variable.
  @protected
  Map<K, V> get _map;

  @override
  V? operator [](Object? key) => _map[key];

  @override
  void operator []=(K key, V value) {
    _map[key] = value;
    notifyListeners();
  }

  @override
  void clear() {
    _map.clear();
    notifyListeners();
  }

  @override
  Iterable<K> get keys => _map.keys;

  @override
  V? remove(Object? key) {
    if (!_map.containsKey(key)) {
      return null;
    }

    V? rmi = _map.remove(key);
    notifyListeners();
    return rmi;
  }

  @override
  V putIfAbsent(K key, V Function() ifAbsent) {
    final int ogkl = keys.length;

    V result = _map.putIfAbsent(key, ifAbsent);

    if (ogkl < keys.length) {
      notifyListeners();
    }

    return result;
  }

  @override
  void addAll(Map<K, V> other) {
    _map.addAll(other);
    notifyListeners();
  }

  @override
  void addEntries(Iterable<MapEntry<K, V>> newEntries) {
    _map.addEntries(newEntries);
    notifyListeners();
  }

  @override
  void removeWhere(bool Function(K key, V value) test) {
    _map.removeWhere(test);
    notifyListeners();
  }

  @override
  V update(K key, V Function(V value) update, {V Function()? ifAbsent}) {
    V updated = _map.update(key, update, ifAbsent: ifAbsent);

    notifyListeners();

    return updated;
  }

  @override
  void updateAll(V Function(K key, V value) update) {
    _map.updateAll(update);
    notifyListeners();
  }

  @override
  Iterable<MapEntry<K, V>> get iterableForm => _map.entries;

  @override
  void modify(K index, void Function(V? item) update) {
    update(this[index]);
    notifyListeners();
  }
}

/// A [Map] that implemented with [ChangeNotifier] features.
abstract class MapChangeNotifier<K, V>
    with ChangeNotifier, CollectionChangeNotifierMixin<MapEntry<K, V>, K, V?>
    implements Map<K, V> {
  // ignore: unused_element
  MapChangeNotifier._();

  /// Get a default preference of [LinkedHashMapChangeNotifier.new].
  factory MapChangeNotifier() = LinkedHashMapChangeNotifier<K, V>;

  /// Construct [MapChangeNotifier] with [other] given.
  factory MapChangeNotifier.from(Map<K, V> other) =
      LinkedHashMapChangeNotifier<K, V>.from;

  /// Create new [MapChangeNotifier]
  factory MapChangeNotifier.fromEntries(Iterable<MapEntry<K, V>> entries) =
      LinkedHashMapChangeNotifier<K, V>.fromEntries;

  /// Create new [MapChangeNotifier] with unspecified element type of
  /// [iterable] and specify [key] and [value] function for extracting
  /// as k-v pair.
  factory MapChangeNotifier.fromIterable(Iterable iterable,
          {K Function(dynamic)? key, V Function(dynamic)? value}) =
      LinkedHashMapChangeNotifier<K, V>.fromIterable;

  /// Create new [MapChangeNotifier] with given 2 [Iterable] of [keys] and
  /// [values].
  ///
  /// Both [keys] and [values]'s [Iterable.length] should be the same.
  factory MapChangeNotifier.fromIterables(
          Iterable<K> keys, Iterable<V> values) =
      LinkedHashMapChangeNotifier<K, V>.fromIterables;

  /// Create [MapChangeNotifier] with [identical] condition.
  factory MapChangeNotifier.identity() =
      LinkedHashMapChangeNotifier<K, V>.identity;

  /// Create [MapChangeNotifier] from [other] map.
  factory MapChangeNotifier.of(Map<K, V> other) =
      LinkedHashMapChangeNotifier<K, V>.of;

  /// Modify an item at [index] and call [notifyListeners] when [update].
  ///
  /// If either no [index] assigned or assigned as `null`, the item given from
  /// [update] will be returned `null`.
  @override
  void modify(K index, void Function(V? item) update);
}
