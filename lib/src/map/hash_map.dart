part of 'map.dart';

/// [HashMap] based implementation of [MapChangeNotifier].
class HashMapChangeNotifier<K, V> extends MapBase<K, V>
    with
        ChangeNotifier,
        CollectionChangeNotifierMixin<MapEntry<K, V>, K, V?>,
        _MapChangeNotifierMixin<K, V>
    implements MapChangeNotifier<K, V>, HashMap<K, V> {
  final HashMap<K, V> _hashMap;

  HashMapChangeNotifier._new(this._hashMap);

  /// Construct [HashMapChangeNotifier] with specify [equals], [hashCode] and
  /// [isValidKey].
  HashMapChangeNotifier(
      {bool Function(K, K)? equals,
      int Function(K)? hashCode,
      bool Function(dynamic)? isValidKey})
      : _hashMap =
            HashMap(equals: equals, hashCode: hashCode, isValidKey: isValidKey);

  factory HashMapChangeNotifier.from(Map<K, V> other) =>
      HashMapChangeNotifier._new(HashMap.from(other));

  factory HashMapChangeNotifier.fromEntries(Iterable<MapEntry<K, V>> entries) =>
      HashMapChangeNotifier._new(HashMap.fromEntries(entries));

  factory HashMapChangeNotifier.fromIterable(Iterable iterable,
          {K Function(dynamic element)? key,
          V Function(dynamic element)? value}) =>
      HashMapChangeNotifier._new(
          HashMap.fromIterable(iterable, key: key, value: value));

  factory HashMapChangeNotifier.fromIterables(
          Iterable<K> keys, Iterable<V> values) =>
      HashMapChangeNotifier._new(HashMap.fromIterables(keys, values));

  factory HashMapChangeNotifier.identity() =>
      HashMapChangeNotifier._new(HashMap.identity());

  factory HashMapChangeNotifier.of(Map<K, V> other) =>
      HashMapChangeNotifier._new(HashMap.of(other));

  @override
  Map<K, V> get _map => _hashMap;
}
