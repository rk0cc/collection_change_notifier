part of 'set.dart';

class LinkedHashSetChangeNotifier<E> extends SetBase<E>
    with
        ChangeNotifier,
        CollectionChangeNotifierMixin<E>,
        _SetChangeNotifierMixin<E>
    implements SetChangeNotifier<E> {
  final LinkedHashSet<E> _linkedHashSet;

  LinkedHashSetChangeNotifier(
      {bool Function(E, E)? equals,
      int Function(E)? hashCode,
      bool Function(dynamic)? isValidKey})
      : _linkedHashSet = LinkedHashSet(
            equals: equals, hashCode: hashCode, isValidKey: isValidKey);

  @override
  Set<E> get _set => _linkedHashSet;
}
