part of 'set.dart';

/// [LinkedHashSet] based [SetChangeNotifier] implementation.
class LinkedHashSetChangeNotifier<E> extends SetBase<E>
    with
        ChangeNotifier,
        CollectionChangeNotifierMixin<E, int, E>,
        IterableCollectionChangeNotifieMixin<E>,
        _SetChangeNotifierMixin<E>
    implements SetChangeNotifier<E>, LinkedHashSet<E> {
  final LinkedHashSet<E> _linkedHashSet;

  LinkedHashSetChangeNotifier._new(this._linkedHashSet);

  /// Construct new [LinkedHashSetChangeNotifier] with specified [equals],
  /// [hashCode] and [isValidKey] condition.
  LinkedHashSetChangeNotifier(
      {bool Function(E, E)? equals,
      int Function(E)? hashCode,
      bool Function(dynamic)? isValidKey})
      : _linkedHashSet = LinkedHashSet(
            equals: equals, hashCode: hashCode, isValidKey: isValidKey);

  /// Construct new [LinkedHashSetChangeNotifier] with [elements].
  factory LinkedHashSetChangeNotifier.from(Iterable elements) =>
      LinkedHashSetChangeNotifier._new(LinkedHashSet.from(elements));

  /// Construct [LinkedHashSetChangeNotifier] with [identical] condition.
  factory LinkedHashSetChangeNotifier.identify() =>
      LinkedHashSetChangeNotifier._new(LinkedHashSet.identity());

  /// Construct new [LinkedHashSetChangeNotifier] that contains [elements].
  factory LinkedHashSetChangeNotifier.of(Iterable<E> elements) =>
      LinkedHashSetChangeNotifier._new(LinkedHashSet.of(elements));

  @override
  Set<E> get _set => _linkedHashSet;
}
