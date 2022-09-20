part of 'map.dart';

/// A [LinkedHashMap] based implementation of [MapChangeNotifier].
class LinkedHashMapChangeNotifier<K, V> extends MapBase<K, V>
    with
        ChangeNotifier,
        CollectionChangeNotifierMixin<MapEntry<K, V>, K, V?>,
        _MapChangeNotifierMixin<K, V>
    implements MapChangeNotifier<K, V>, LinkedHashMap<K, V> {
  final LinkedHashMap<K, V> _linkedHashMap;

  LinkedHashMapChangeNotifier._new(this._linkedHashMap);

  /// Construct a new [LinkedHashMapChangeNotifier] with [equals] condition,
  /// getting [hashCode] and [isValidKey] options.
  LinkedHashMapChangeNotifier(
      {bool Function(K, K)? equals,
      int Function(K)? hashCode,
      bool Function(dynamic)? isValidKey})
      : _linkedHashMap = LinkedHashMap(
            equals: equals, hashCode: hashCode, isValidKey: isValidKey);

  /// Create new [LinkedHashMapChangeNotifier] that contains all key-value pair
  /// of [other].
  factory LinkedHashMapChangeNotifier.from(Map<K, V> other) =>
      LinkedHashMapChangeNotifier._new(LinkedHashMap.from(other));

  /// Create new [LinkedHashMapChangeNotifier] with [entries].
  factory LinkedHashMapChangeNotifier.fromEntries(
          Iterable<MapEntry<K, V>> entries) =>
      LinkedHashMapChangeNotifier._new(LinkedHashMap.fromEntries(entries));

  /// Create new [LinkedHashMapChangeNotifier] from [iterable] which using to
  /// extract [key] and [value].
  factory LinkedHashMapChangeNotifier.fromIterable(Iterable iterable,
          {K Function(dynamic element)? key,
          V Function(dynamic element)? value}) =>
      LinkedHashMapChangeNotifier._new(
          LinkedHashMap.fromIterable(iterable, key: key, value: value));

  /// Create new [LinkedHashMapChangeNotifier] with [Iterable] of [keys] and
  /// [values] which both of [Iterable.length] should be the same.
  factory LinkedHashMapChangeNotifier.fromIterables(
          Iterable<K> keys, Iterable<V> values) =>
      LinkedHashMapChangeNotifier._new(
          LinkedHashMap.fromIterables(keys, values));

  /// Create [LinkedHashMapChangeNotifier] with [identical] condition.
  factory LinkedHashMapChangeNotifier.identity() =>
      LinkedHashMapChangeNotifier._new(LinkedHashMap.identity());

  /// Create new [LinkedHashMapChangeNotifier] that contains [other].
  factory LinkedHashMapChangeNotifier.of(Map<K, V> other) =>
      LinkedHashMapChangeNotifier._new(LinkedHashMap.of(other));

  @override
  Map<K, V> get _map => _linkedHashMap;
}
