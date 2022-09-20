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

  /// Construct [HashMapChangeNotifier] with given [other] [Map].
  factory HashMapChangeNotifier.from(Map other) =>
      HashMapChangeNotifier._new(HashMap.from(other));

  /// Construct [HashMapChangeNotifier] from an [Iterable] of [entries].
  factory HashMapChangeNotifier.fromEntries(Iterable<MapEntry<K, V>> entries) =>
      HashMapChangeNotifier._new(HashMap.fromEntries(entries));

  /// Construct [HashMapChangeNotifier] with [iterable] that calculating
  /// [key] and [value].
  factory HashMapChangeNotifier.fromIterable(Iterable iterable,
          {K Function(dynamic element)? key,
          V Function(dynamic element)? value}) =>
      HashMapChangeNotifier._new(
          HashMap.fromIterable(iterable, key: key, value: value));

  /// Construct [HashMapChangeNotifier] with [Iterable]s of [keys] and [values]
  /// with they have the same [Iterable.length].
  factory HashMapChangeNotifier.fromIterables(
          Iterable<K> keys, Iterable<V> values) =>
      HashMapChangeNotifier._new(HashMap.fromIterables(keys, values));

  /// Construct [HashMapChangeNotifier] with [identical].
  factory HashMapChangeNotifier.identity() =>
      HashMapChangeNotifier._new(HashMap.identity());

  /// Construct [HashMapChangeNotifier] with applied [other] key-value pair.
  factory HashMapChangeNotifier.of(Map<K, V> other) =>
      HashMapChangeNotifier._new(HashMap.of(other));

  @override
  Map<K, V> get _map => _hashMap;
}
