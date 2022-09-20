part of 'set.dart';

/// [HashSet] based [SetChangeNotifier] implementation.
class HashSetChangeNotifier<E> extends SetBase<E>
    with
        ChangeNotifier,
        CollectionChangeNotifierMixin<E, int, E>,
        IterableCollectionChangeNotifieMixin<E>,
        _SetChangeNotifierMixin<E>
    implements SetChangeNotifier<E>, HashSet<E> {
  final HashSet<E> _hashSet;

  HashSetChangeNotifier._new(this._hashSet);

  /// Construct new [HashSetChangeNotifier] with [equals], [hashCode] and
  /// [isValidKey] configuration.
  HashSetChangeNotifier(
      {bool Function(E, E)? equals,
      int Function(E)? hashCode,
      bool Function(dynamic)? isValidKey})
      : _hashSet =
            HashSet(equals: equals, hashCode: hashCode, isValidKey: isValidKey);

  /// Construct new [HashSetChangeNotifier] with [elements].
  factory HashSetChangeNotifier.from(Iterable elements) =>
      HashSetChangeNotifier._new(HashSet.from(elements));

  /// Construct new [HashSetChangeNotifier] using [identical].
  factory HashSetChangeNotifier.identify() =>
      HashSetChangeNotifier._new(HashSet.identity());

  /// Consturct [HashSetChangeNotifier] that contains [elements].
  factory HashSetChangeNotifier.of(Iterable<E> elements) =>
      HashSetChangeNotifier._new(HashSet.of(elements));

  @override
  Set<E> get _set => _hashSet;
}
