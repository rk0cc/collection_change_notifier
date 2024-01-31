import 'dart:collection';

import 'package:flutter/widgets.dart' show ChangeNotifier;

import 'abstract.dart';

/// Standarize [Map] features with [ChangeNotifier] when state
/// changed.
abstract final class MapChangeNotifier<K, V> extends MapBase<K, V>
    with ChangeNotifier, CollectionChangeNotifierMixin<MapEntry<K, V>, K, V?> {
  /// The map of the implemented object.
  ///
  /// Please apply it as getter for getting corresponded [Map] variable.
  final Map<K, V> _map;

  MapChangeNotifier._(this._map);

  /// Get a default preference of [LinkedHashMapChangeNotifier.new].
  factory MapChangeNotifier() = LinkedHashMapChangeNotifier<K, V>;

  /// Construct [MapChangeNotifier] with [other] given.
  factory MapChangeNotifier.from(Map other) =
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
  Iterable<V> get values => _map.values;

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
    int ogkl = keys.length;

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

  /// Modify an item at [index] and call [notifyListeners] when [update].
  ///
  /// If either no [index] assigned or assigned as `null`, the item given from
  /// [update] will be returned `null`.
  @override
  void modify(K index, void Function(V? item) update) {
    update(this[index]);
    notifyListeners();
  }
}

/// [HashMap] based implementation of [MapChangeNotifier].
final class HashMapChangeNotifier<K, V> extends MapChangeNotifier<K, V> {
  HashMapChangeNotifier._(HashMap<K, V> map) : super._(map);

  /// Construct [HashMapChangeNotifier] with specify [equals], [hashCode] and
  /// [isValidKey].
  factory HashMapChangeNotifier(
          {bool Function(K, K)? equals,
          int Function(K)? hashCode,
          bool Function(dynamic)? isValidKey}) =>
      HashMapChangeNotifier._(
          HashMap(equals: equals, hashCode: hashCode, isValidKey: isValidKey));

  /// Construct [HashMapChangeNotifier] with given [other] [Map].
  factory HashMapChangeNotifier.from(Map other) =>
      HashMapChangeNotifier._(HashMap.from(other));

  /// Construct [HashMapChangeNotifier] from an [Iterable] of [entries].
  factory HashMapChangeNotifier.fromEntries(Iterable<MapEntry<K, V>> entries) =>
      HashMapChangeNotifier._(HashMap.fromEntries(entries));

  /// Construct [HashMapChangeNotifier] with [iterable] that calculating
  /// [key] and [value].
  factory HashMapChangeNotifier.fromIterable(Iterable iterable,
          {K Function(dynamic element)? key,
          V Function(dynamic element)? value}) =>
      HashMapChangeNotifier._(
          HashMap.fromIterable(iterable, key: key, value: value));

  /// Construct [HashMapChangeNotifier] with [Iterable]s of [keys] and [values]
  /// with they have the same [Iterable.length].
  factory HashMapChangeNotifier.fromIterables(
          Iterable<K> keys, Iterable<V> values) =>
      HashMapChangeNotifier._(HashMap.fromIterables(keys, values));

  /// Construct [HashMapChangeNotifier] with [identical].
  factory HashMapChangeNotifier.identity() =>
      HashMapChangeNotifier._(HashMap.identity());

  /// Construct [HashMapChangeNotifier] with applied [other] key-value pair.
  factory HashMapChangeNotifier.of(Map<K, V> other) =>
      HashMapChangeNotifier._(HashMap.of(other));
}

/// A [LinkedHashMap] based implementation of [MapChangeNotifier].
final class LinkedHashMapChangeNotifier<K, V> extends MapChangeNotifier<K, V> {
  LinkedHashMapChangeNotifier._(LinkedHashMap<K, V> map) : super._(map);

  /// Construct a new [LinkedHashMapChangeNotifier] with [equals] condition,
  /// getting [hashCode] and [isValidKey] options.
  factory LinkedHashMapChangeNotifier(
          {bool Function(K, K)? equals,
          int Function(K)? hashCode,
          bool Function(dynamic)? isValidKey}) =>
      LinkedHashMapChangeNotifier._(LinkedHashMap(
          equals: equals, hashCode: hashCode, isValidKey: isValidKey));

  /// Create new [LinkedHashMapChangeNotifier] that contains all key-value pair
  /// of [other].
  factory LinkedHashMapChangeNotifier.from(Map other) =>
      LinkedHashMapChangeNotifier._(LinkedHashMap.from(other));

  /// Create new [LinkedHashMapChangeNotifier] with [entries].
  factory LinkedHashMapChangeNotifier.fromEntries(
          Iterable<MapEntry<K, V>> entries) =>
      LinkedHashMapChangeNotifier._(LinkedHashMap.fromEntries(entries));

  /// Create new [LinkedHashMapChangeNotifier] from [iterable] which using to
  /// extract [key] and [value].
  factory LinkedHashMapChangeNotifier.fromIterable(Iterable iterable,
          {K Function(dynamic element)? key,
          V Function(dynamic element)? value}) =>
      LinkedHashMapChangeNotifier._(
          LinkedHashMap.fromIterable(iterable, key: key, value: value));

  /// Create new [LinkedHashMapChangeNotifier] with [Iterable] of [keys] and
  /// [values] which both of [Iterable.length] should be the same.
  factory LinkedHashMapChangeNotifier.fromIterables(
          Iterable<K> keys, Iterable<V> values) =>
      LinkedHashMapChangeNotifier._(LinkedHashMap.fromIterables(keys, values));

  /// Create [LinkedHashMapChangeNotifier] with [identical] condition.
  factory LinkedHashMapChangeNotifier.identity() =>
      LinkedHashMapChangeNotifier._(LinkedHashMap.identity());

  /// Create new [LinkedHashMapChangeNotifier] that contains [other].
  factory LinkedHashMapChangeNotifier.of(Map<K, V> other) =>
      LinkedHashMapChangeNotifier._(LinkedHashMap.of(other));
}

/// [SplayTreeMap] based [MapChangeNotifier] implementation.
final class SplayTreeMapChangeNotifier<K, V> extends MapChangeNotifier<K, V> {
  SplayTreeMapChangeNotifier._(SplayTreeMap<K, V> map) : super._(map);

  /// Construct [SplayTreeMapChangeNotifier] with specify [compare] and
  /// [isValidKey].
  factory SplayTreeMapChangeNotifier(
          [int Function(K key1, K key2)? compare,
          bool Function(dynamic potentialKey)? isValidKey]) =>
      SplayTreeMapChangeNotifier._(SplayTreeMap(compare, isValidKey));

  /// Construct [SplayTreeMapChangeNotifier] from [other] [Map] and specify
  /// [compare] and [isValidKey].
  factory SplayTreeMapChangeNotifier.from(Map other,
          [int Function(K key1, K key2)? compare,
          bool Function(dynamic potentialKey)? isValidKey]) =>
      SplayTreeMapChangeNotifier._(
          SplayTreeMap.from(other, compare, isValidKey));

  /// Construct [SplayTreeMapChangeNotifier] from [iterable] and specify [key]
  /// and [value] with [compare] and [isValidKey] configuration.
  factory SplayTreeMapChangeNotifier.fromIterable(Iterable iterable,
          {K Function(dynamic element)? key,
          V Function(dynamic element)? value,
          int Function(K key1, K key2)? compare,
          bool Function(dynamic potentialKey)? isValidKey}) =>
      SplayTreeMapChangeNotifier._(SplayTreeMap.fromIterable(iterable,
          key: key, value: value, compare: compare, isValidKey: isValidKey));

  /// Construct [SplayTreeMapChangeNotifier] with [Iterable]s of [keys] and
  /// [values] with [compare] and [isValidKey] configuration.
  factory SplayTreeMapChangeNotifier.fromIterables(
          Iterable<K> keys, Iterable<V> values,
          [int Function(K key1, K key2)? compare,
          bool Function(dynamic potentialKey)? isValidKey]) =>
      SplayTreeMapChangeNotifier._(
          SplayTreeMap.fromIterables(keys, values, compare, isValidKey));

  /// Construct [SplayTreeMapChangeNotifier] with [other] that setting
  /// [compare] and [isValidKey] configuration.
  factory SplayTreeMapChangeNotifier.of(Map<K, V> other,
          [int Function(K key1, K key2)? compare,
          bool Function(dynamic potentialKey)? isValidKey]) =>
      SplayTreeMapChangeNotifier._(SplayTreeMap.of(other, compare, isValidKey));

  /// See [SplayTreeMap.firstKey].
  K? firstKey() => (_map as SplayTreeMap<K, V>).firstKey();

  /// See [SplayTreeMap.firstKeyAfter].
  K? firstKeyAfter(K key) => (_map as SplayTreeMap<K, V>).firstKeyAfter(key);

  /// See [SplayTreeMap.lastKey].
  K? lastKey() => (_map as SplayTreeMap<K, V>).lastKey();

  /// See [SplayTreeMap.lastKeyBefore].
  K? lastKeyBefore(K key) => (_map as SplayTreeMap<K, V>).lastKeyBefore(key);
}
