part of 'list.dart';

abstract final class QueueChangeNotifier<E> extends Iterable<E>
    with
        ChangeNotifier,
        CollectionChangeNotifierMixin<E, int, E>,
        IterableCollectionChangeNotifieMixin<E>
    implements Queue<E> {
  final Queue<E> _q;

  QueueChangeNotifier._(this._q);

  /// Create a [Queue] with [ChangeNotifier] features.
  factory QueueChangeNotifier() = ListQueueChangeNotifier<E>;

  /// Create a new [Queue] that contains all [elements].
  factory QueueChangeNotifier.from(Iterable elements) =
      ListQueueChangeNotifier<E>.from;

  /// Create [Queue] from [elements].
  factory QueueChangeNotifier.of(Iterable<E> elements) =
      ListQueueChangeNotifier<E>.of;

  @override
  void add(E value) {
    _q.add(value);
    notifyListeners();
  }

  void _slientAddAll(Iterable<E> iterable) {
    _q.addAll(iterable);
  }

  @override
  void addAll(Iterable<E> iterable) {
    _slientAddAll(iterable);
    notifyListeners();
  }

  @override
  void addFirst(E value) {
    _q.addFirst(value);
    notifyListeners();
  }

  @override
  void addLast(E value) {
    _q.addLast(value);
    notifyListeners();
  }

  @override
  Queue<R> cast<R>() {
    return _q.cast<R>();
  }

  @override
  void clear() {
    _q.clear();
    notifyListeners();
  }

  @override
  Iterable<E> get iterableForm => [..._q];

  @override
  Iterator<E> get iterator => iterableForm.iterator;

  @override
  bool remove(Object? value) {
    bool rm = _q.remove(value);

    if (rm) {
      notifyListeners();
    }

    return rm;
  }

  E _removeGetItem(E Function() getter) {
    E rmi = getter();
    notifyListeners();
    return rmi;
  }

  @override
  E removeFirst() {
    return _removeGetItem(_q.removeFirst);
  }

  @override
  E removeLast() {
    return _removeGetItem(_q.removeLast);
  }

  @override
  void removeWhere(bool Function(E element) test) {
    _q.removeWhere(test);
    notifyListeners();
  }

  @override
  void retainWhere(bool Function(E element) test) {
    _q.retainWhere(test);
    notifyListeners();
  }
}

/// List based [QueueChangeNotifier] that provides feature of [ListQueue]
/// with [ChangeNotifier] integration.
final class ListQueueChangeNotifier<E> extends QueueChangeNotifier<E> {
  /// Create new [ListQueueChangeNotifier] with given [initialCapacity] for
  /// prepare at leasst elements in this queue.
  ListQueueChangeNotifier([int? initialCapacity])
      : super._(ListQueue(initialCapacity));

  /// Create [ListQueueChangeNotifier] contains all [elements].
  ///
  /// It just call [ListQueue.from] with [elements], then call
  /// [ListQueueChangeNotifier.new] with given [ListQueue.length] as initial
  /// capacity and assign [elements].
  factory ListQueueChangeNotifier.from(Iterable elements) {
    ListQueue<E> lq = ListQueue.from(elements);
    ListQueueChangeNotifier<E> lqcn = ListQueueChangeNotifier(lq.length);

    for (final element in lq) {
      lqcn.addLast(element);
    }

    return lqcn;
  }

  /// Create new [ListQueueChangeNotifier] with given [elements].
  factory ListQueueChangeNotifier.of(Iterable<E> elements) =>
      ListQueueChangeNotifier().._slientAddAll(elements);
}

/// Implemented [QueueChangeNotifier] baased on [DoubleLinkedQueue].
final class DoubleLinkedQueueChangeNotifier<E> extends QueueChangeNotifier<E> {
  DoubleLinkedQueueChangeNotifier() : super._(DoubleLinkedQueue());

  /// Create new [DoubleLinkedQueueChangeNotifier] and add all [elements]
  /// of [Iterable] into the last of the queue.
  factory DoubleLinkedQueueChangeNotifier.from(Iterable elements) {
    DoubleLinkedQueueChangeNotifier<E> dlq = DoubleLinkedQueueChangeNotifier();
    for (final e in elements) {
      dlq.addLast(e as E);
    }

    return dlq;
  }

  /// Create new [DoubleLinkedQueueChangeNotifier] and apply [elements]
  /// of [Iterable] to the list.
  factory DoubleLinkedQueueChangeNotifier.of(Iterable<E> elements) =>
      DoubleLinkedQueueChangeNotifier().._slientAddAll(elements);
}
