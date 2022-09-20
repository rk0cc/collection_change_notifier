part of 'map.dart';

/// [SplayTreeMap] based [MapChangeNotifier] implementation.
class SplayTreeMapChangeNotifier<K, V> extends MapBase<K, V>
    with
        ChangeNotifier,
        CollectionChangeNotifierMixin<MapEntry<K, V>, K, V?>,
        _MapChangeNotifierMixin<K, V>
    implements MapChangeNotifier<K, V>, SplayTreeMap<K, V> {
  final SplayTreeMap<K, V> _splayTreeMap;

  SplayTreeMapChangeNotifier._new(this._splayTreeMap);

  /// Construct [SplayTreeMapChangeNotifier] with specify [compare] and
  /// [isValidKey].
  SplayTreeMapChangeNotifier(
      [int Function(K key1, K key2)? compare,
      bool Function(dynamic potentialKey)? isValidKey])
      : _splayTreeMap = SplayTreeMap(compare, isValidKey);

  /// Construct [SplayTreeMapChangeNotifier] from [other] [Map] and specify
  /// [compare] and [isValidKey].
  factory SplayTreeMapChangeNotifier.from(Map other,
          [int Function(K key1, K key2)? compare,
          bool Function(dynamic potentialKey)? isValidKey]) =>
      SplayTreeMapChangeNotifier._new(
          SplayTreeMap.from(other, compare, isValidKey));

  /// Construct [SplayTreeMapChangeNotifier] from [iterable] and specify [key]
  /// and [value] with [compare] and [isValidKey] configuration.
  factory SplayTreeMapChangeNotifier.fromIterable(Iterable iterable,
          {K Function(dynamic element)? key,
          V Function(dynamic element)? value,
          int Function(K key1, K key2)? compare,
          bool Function(dynamic potentialKey)? isValidKey}) =>
      SplayTreeMapChangeNotifier._new(SplayTreeMap.fromIterable(iterable,
          key: key, value: value, compare: compare, isValidKey: isValidKey));

  /// Construct [SplayTreeMapChangeNotifier] with [Iterable]s of [keys] and
  /// [values] with [compare] and [isValidKey] configuration.
  factory SplayTreeMapChangeNotifier.fromIterables(
          Iterable<K> keys, Iterable<V> values,
          [int Function(K key1, K key2)? compare,
          bool Function(dynamic potentialKey)? isValidKey]) =>
      SplayTreeMapChangeNotifier._new(
          SplayTreeMap.fromIterables(keys, values, compare, isValidKey));

  /// Construct [SplayTreeMapChangeNotifier] with [other] that setting
  /// [compare] and [isValidKey] configuration.
  factory SplayTreeMapChangeNotifier.of(Map<K, V> other,
          [int Function(K key1, K key2)? compare,
          bool Function(dynamic potentialKey)? isValidKey]) =>
      SplayTreeMapChangeNotifier._new(
          SplayTreeMap.of(other, compare, isValidKey));

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
