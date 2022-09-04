import 'dart:collection';

import 'package:flutter/widgets.dart' show ChangeNotifier;
import 'package:meta/meta.dart';

import '../abstract.dart';

part 'hash_map.dart';
part 'linked_hash_map.dart';
part 'splay_tree_map.dart';

mixin _MapChangeNotifierMixin<K, V>
    on
        Map<K, V>,
        ChangeNotifier,
        CollectionChangeNotifierMixin<MapEntry<K, V>> {
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
}

abstract class MapChangeNotifier<K, V>
    with ChangeNotifier, CollectionChangeNotifierMixin<MapEntry<K, V>>
    implements Map<K, V> {
  MapChangeNotifier._();

  factory MapChangeNotifier() = LinkedHashMapChangeNotifier<K, V>;

  factory MapChangeNotifier.from(Map<K, V> other) =
      LinkedHashMapChangeNotifier<K, V>.from;

  factory MapChangeNotifier.fromEntries(Iterable<MapEntry<K, V>> entries) =
      LinkedHashMapChangeNotifier<K, V>.fromEntries;

  factory MapChangeNotifier.fromIterable(Iterable iterable,
          {K Function(dynamic)? key, V Function(dynamic)? value}) =
      LinkedHashMapChangeNotifier<K, V>.fromIterable;

  factory MapChangeNotifier.fromIterables(
          Iterable<K> keys, Iterable<V> values) =
      LinkedHashMapChangeNotifier<K, V>.fromIterables;

  factory MapChangeNotifier.identity() =
      LinkedHashMapChangeNotifier<K, V>.identity;

  factory MapChangeNotifier.of(Map<K, V> other) =
      LinkedHashMapChangeNotifier<K, V>.of;
}
