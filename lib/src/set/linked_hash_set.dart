part of 'set.dart';

class LinkedHashSetChangeNotifier<E> extends SetBase<E>
    with
        ChangeNotifier,
        CollectionChangeNotifierMixin<E, int, E>,
        IterableCollectionChangeNotifieMixin<E>,
        _SetChangeNotifierMixin<E>
    implements SetChangeNotifier<E>, LinkedHashSet<E> {
  final LinkedHashSet<E> _linkedHashSet;

  LinkedHashSetChangeNotifier._new(this._linkedHashSet);

  LinkedHashSetChangeNotifier(
      {bool Function(E, E)? equals,
      int Function(E)? hashCode,
      bool Function(dynamic)? isValidKey})
      : _linkedHashSet = LinkedHashSet(
            equals: equals, hashCode: hashCode, isValidKey: isValidKey);

  factory LinkedHashSetChangeNotifier.from(Iterable elements) =>
      LinkedHashSetChangeNotifier._new(LinkedHashSet.from(elements));

  factory LinkedHashSetChangeNotifier.identify() =>
      LinkedHashSetChangeNotifier._new(LinkedHashSet.identity());

  factory LinkedHashSetChangeNotifier.of(Iterable<E> elements) =>
      LinkedHashSetChangeNotifier._new(LinkedHashSet.of(elements));

  @override
  Set<E> get _set => _linkedHashSet;
}
