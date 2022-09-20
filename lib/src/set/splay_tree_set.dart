part of 'set.dart';

/// [SplayTreeSet] based [SetChangeNotifier] implementation.
class SplayTreeSetChangeNotifier<E> extends SetBase<E>
    with
        ChangeNotifier,
        CollectionChangeNotifierMixin<E, int, E>,
        IterableCollectionChangeNotifieMixin<E>,
        _SetChangeNotifierMixin<E>
    implements SetChangeNotifier<E>, SplayTreeSet<E> {
  final SplayTreeSet<E> _splayTreeSet;

  SplayTreeSetChangeNotifier._new(this._splayTreeSet);

  /// Consturct new [SplayTreeSetChangeNotifier] with [compare] and
  /// [isValidKey] configuration.
  SplayTreeSetChangeNotifier(
      [int Function(E key1, E key2)? compare,
      bool Function(dynamic potentialKey)? isValidKey])
      : _splayTreeSet = SplayTreeSet(compare, isValidKey);

  /// Construct new [SplayTreeSetChangeNotifier] that giving [elements] to get
  /// [key] and [value] with [compare] and [isValidKey] configuration.
  factory SplayTreeSetChangeNotifier.from(Iterable elements,
          [int Function(E key1, E key2)? compare,
          bool Function(dynamic potentialKey)? isValidKey]) =>
      SplayTreeSetChangeNotifier._new(
          SplayTreeSet.from(elements, compare, isValidKey));

  /// Consturct new [SplayTreeSetChangeNotifier] that contains [elements] with
  /// [compare] and [isValidKey] configuration.
  factory SplayTreeSetChangeNotifier.of(Iterable<E> elements,
          [int Function(E key1, E key2)? compare,
          bool Function(dynamic potentialKey)? isValidKey]) =>
      SplayTreeSetChangeNotifier._new(
          SplayTreeSet.of(elements, compare, isValidKey));

  @override
  Set<E> get _set => _splayTreeSet;
}
