part of 'set.dart';

class SplayTreeSetChangeNotifier<E> extends SetBase<E>
    with
        ChangeNotifier,
        CollectionChangeNotifierMixin<E, int, E>,
        IterableCollectionChangeNotifieMixin<E>,
        _SetChangeNotifierMixin<E>
    implements SetChangeNotifier<E>, SplayTreeSet<E> {
  final SplayTreeSet<E> _splayTreeSet;

  SplayTreeSetChangeNotifier._new(this._splayTreeSet);

  SplayTreeSetChangeNotifier(
      [int Function(E key1, E key2)? compare,
      bool Function(dynamic potentialKey)? isValidKey])
      : _splayTreeSet = SplayTreeSet(compare, isValidKey);

  factory SplayTreeSetChangeNotifier.from(Iterable elements,
          [int Function(E key1, E key2)? compare,
          bool Function(dynamic potentialKey)? isValidKey]) =>
      SplayTreeSetChangeNotifier._new(
          SplayTreeSet.from(elements, compare, isValidKey));

  factory SplayTreeSetChangeNotifier.of(Iterable<E> elements,
          [int Function(E key1, E key2)? compare,
          bool Function(dynamic potentialKey)? isValidKey]) =>
      SplayTreeSetChangeNotifier._new(
          SplayTreeSet.of(elements, compare, isValidKey));

  @override
  Set<E> get _set => _splayTreeSet;
}
