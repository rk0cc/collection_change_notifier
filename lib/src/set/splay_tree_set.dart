part of 'set.dart';

class SplayTreeSetChangeNotifier<E> extends SetBase<E>
    with
        ChangeNotifier,
        CollectionChangeNotifierMixin<E, int, E>,
        _SetChangeNotifierMixin<E>
    implements SetChangeNotifier<E>, SplayTreeSet<E> {
  final SplayTreeSet<E> _splayTreeSet;

  SplayTreeSetChangeNotifier(
      [int Function(E key1, E key2)? compare,
      bool Function(dynamic potentialKey)? isValidKey])
      : _splayTreeSet = SplayTreeSet(compare, isValidKey);

  SplayTreeSetChangeNotifier.from(Iterable elements,
      [int Function(E key1, E key2)? compare,
      bool Function(dynamic potentialKey)? isValidKey])
      : _splayTreeSet = SplayTreeSet.from(elements, compare, isValidKey);

  SplayTreeSetChangeNotifier.of(Iterable<E> elements,
      [int Function(E key1, E key2)? compare,
      bool Function(dynamic potentialKey)? isValidKey])
      : _splayTreeSet = SplayTreeSet.of(elements, compare, isValidKey);

  @override
  Set<E> get _set => _splayTreeSet;
}
