part of 'map.dart';

/// [HashMap] based implementation of [MapChangeNotifier].
class HashMapChangeNotifier<K, V> extends MapBase<K, V>
    with
        ChangeNotifier,
        CollectionChangeNotifierMixin<MapEntry<K, V>, K, V?>,
        _MapChangeNotifierMixin<K, V>
    implements MapChangeNotifier<K, V>, HashMap<K, V> {
  final HashMap<K, V> _hashMap;

  /// Construct [HashMapChangeNotifier] with specify [equals], [hashCode] and
  /// [isValidKey].
  HashMapChangeNotifier(
      {bool Function(K, K)? equals,
      int Function(K)? hashCode,
      bool Function(dynamic)? isValidKey})
      : _hashMap =
            HashMap(equals: equals, hashCode: hashCode, isValidKey: isValidKey);

  HashMapChangeNotifier.from(Map<K, V> other) : _hashMap = HashMap.from(other);

  HashMapChangeNotifier.fromEntries(Iterable<MapEntry<K, V>> entries)
      : _hashMap = HashMap.fromEntries(entries);

  HashMapChangeNotifier.fromIterable(Iterable iterable,
      {K Function(dynamic element)? key, V Function(dynamic element)? value})
      : _hashMap = HashMap.fromIterable(iterable, key: key, value: value);

  HashMapChangeNotifier.fromIterables(Iterable<K> keys, Iterable<V> values)
      : _hashMap = HashMap.fromIterables(keys, values);

  HashMapChangeNotifier.identity() : _hashMap = HashMap.identity();

  HashMapChangeNotifier.of(Map<K, V> other) : _hashMap = HashMap.of(other);

  @override
  Map<K, V> get _map => _hashMap;
}
