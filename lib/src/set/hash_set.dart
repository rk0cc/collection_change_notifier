part of 'set.dart';

class HashSetChangeNotifier<E> extends SetBase<E>
    with
        ChangeNotifier,
        CollectionChangeNotifierMixin<E, int, E>,
        IterableCollectionChangeNotifieMixin<E>,
        _SetChangeNotifierMixin<E>
    implements SetChangeNotifier<E>, HashSet<E> {
  final HashSet<E> _hashSet;

  HashSetChangeNotifier._new(this._hashSet);

  HashSetChangeNotifier(
      {bool Function(E, E)? equals,
      int Function(E)? hashCode,
      bool Function(dynamic)? isValidKey})
      : _hashSet =
            HashSet(equals: equals, hashCode: hashCode, isValidKey: isValidKey);

  factory HashSetChangeNotifier.from(Iterable elements) =>
      HashSetChangeNotifier._new(HashSet.from(elements));

  factory HashSetChangeNotifier.identify() =>
      HashSetChangeNotifier._new(HashSet.identity());

  factory HashSetChangeNotifier.of(Iterable<E> elements) =>
      HashSetChangeNotifier._new(HashSet.of(elements));

  @override
  Set<E> get _set => _hashSet;
}
