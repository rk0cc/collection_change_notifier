part of 'map.dart';

class SplayTreeMapChangeNotifier<K, V> extends MapBase<K, V>
    with
        ChangeNotifier,
        CollectionChangeNotifierMixin<MapEntry<K, V>, K, Object?>,
        _MapChangeNotifierMixin<K, V>
    implements MapChangeNotifier<K, V>, SplayTreeMap<K, V> {
  final SplayTreeMap<K, V> _splayTreeMap;

  SplayTreeMapChangeNotifier(
      [int Function(K key1, K key2)? compare,
      bool Function(dynamic potentialKey)? isValidKey])
      : _splayTreeMap = SplayTreeMap(compare, isValidKey);

  SplayTreeMapChangeNotifier.from(Map other,
      [int Function(K key1, K key2)? compare,
      bool Function(dynamic potentialKey)? isValidKey])
      : _splayTreeMap = SplayTreeMap.from(other, compare, isValidKey);

  SplayTreeMapChangeNotifier.fromIterable(Iterable iterable,
      {K Function(dynamic element)? key,
      V Function(dynamic element)? value,
      int Function(K key1, K key2)? compare,
      bool Function(dynamic potentialKey)? isValidKey})
      : _splayTreeMap = SplayTreeMap.fromIterable(iterable,
            key: key, value: value, compare: compare, isValidKey: isValidKey);

  SplayTreeMapChangeNotifier.fromIterables(Iterable<K> keys, Iterable<V> values,
      [int Function(K key1, K key2)? compare,
      bool Function(dynamic potentialKey)? isValidKey])
      : _splayTreeMap =
            SplayTreeMap.fromIterables(keys, values, compare, isValidKey);

  SplayTreeMapChangeNotifier.of(Map<K, V> other,
      [int Function(K key1, K key2)? compare,
      bool Function(dynamic potentialKey)? isValidKey])
      : _splayTreeMap = SplayTreeMap.of(other, compare, isValidKey);

  @override
  Map<K, V> get _map => _splayTreeMap;

  @override
  K? firstKey() => _splayTreeMap.firstKey();

  @override
  K? firstKeyAfter(K key) => _splayTreeMap.firstKeyAfter(key);

  @override
  K? lastKey() => _splayTreeMap.lastKey();

  @override
  K? lastKeyBefore(K key) => _splayTreeMap.lastKeyBefore(key);
}
