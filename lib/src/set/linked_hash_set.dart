part of 'set.dart';

class LinkedHashSetChangeNotifier<E> extends SetBase<E>
    with
        ChangeNotifier,
        CollectionChangeNotifierMixin<E, int, E>,
        IterableCollectionChangeNotifieMixin<E>,
        _SetChangeNotifierMixin<E>
    implements SetChangeNotifier<E>, LinkedHashSet<E> {
  final LinkedHashSet<E> _linkedHashSet;

  LinkedHashSetChangeNotifier(
      {bool Function(E, E)? equals,
      int Function(E)? hashCode,
      bool Function(dynamic)? isValidKey})
      : _linkedHashSet = LinkedHashSet(
            equals: equals, hashCode: hashCode, isValidKey: isValidKey);

  LinkedHashSetChangeNotifier.from(Iterable elements)
      : _linkedHashSet = LinkedHashSet.from(elements);

  LinkedHashSetChangeNotifier.identify()
      : _linkedHashSet = LinkedHashSet.identity();

  LinkedHashSetChangeNotifier.of(Iterable<E> elements)
      : _linkedHashSet = LinkedHashSet.of(elements);

  @override
  Set<E> get _set => _linkedHashSet;
}
