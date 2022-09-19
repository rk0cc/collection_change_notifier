part of 'map.dart';

/// A [LinkedHashMap] based implementation of [MapChangeNotifier].
class LinkedHashMapChangeNotifier<K, V> extends MapBase<K, V>
    with
        ChangeNotifier,
        CollectionChangeNotifierMixin<MapEntry<K, V>, K, Object?>,
        _MapChangeNotifierMixin<K, V>
    implements MapChangeNotifier<K, V>, LinkedHashMap<K, V> {
  final LinkedHashMap<K, V> _linkedHashMap;

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
  LinkedHashMapChangeNotifier.from(Map<K, V> other)
      : _linkedHashMap = LinkedHashMap.from(other);

  LinkedHashMapChangeNotifier.fromEntries(Iterable<MapEntry<K, V>> entries)
      : _linkedHashMap = LinkedHashMap.fromEntries(entries);

  LinkedHashMapChangeNotifier.fromIterable(Iterable iterable,
      {K Function(dynamic element)? key, V Function(dynamic element)? value})
      : _linkedHashMap =
            LinkedHashMap.fromIterable(iterable, key: key, value: value);

  LinkedHashMapChangeNotifier.fromIterables(
      Iterable<K> keys, Iterable<V> values)
      : _linkedHashMap = LinkedHashMap.fromIterables(keys, values);

  LinkedHashMapChangeNotifier.identity()
      : _linkedHashMap = LinkedHashMap.identity();

  LinkedHashMapChangeNotifier.of(Map<K, V> other)
      : _linkedHashMap = LinkedHashMap.of(other);

  @override
  Map<K, V> get _map => _linkedHashMap;
}
