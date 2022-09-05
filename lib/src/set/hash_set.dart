part of 'set.dart';

class HashSetChangeNotifier<E> extends SetBase<E>
    with
        ChangeNotifier,
        CollectionChangeNotifierMixin<E, int, E>,
        _SetChangeNotifierMixin<E>
    implements SetChangeNotifier<E>, HashSet<E> {
  final HashSet<E> _hashSet;

  HashSetChangeNotifier(
      {bool Function(E, E)? equals,
      int Function(E)? hashCode,
      bool Function(dynamic)? isValidKey})
      : _hashSet =
            HashSet(equals: equals, hashCode: hashCode, isValidKey: isValidKey);

  HashSetChangeNotifier.from(Iterable elements)
      : _hashSet = HashSet.from(elements);

  HashSetChangeNotifier.identify() : _hashSet = HashSet.identity();

  HashSetChangeNotifier.of(Iterable<E> elements)
      : _hashSet = HashSet.of(elements);

  @override
  Set<E> get _set => _hashSet;
}
