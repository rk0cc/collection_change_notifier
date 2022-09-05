part of 'list.dart';

mixin _QueueChangeNotifierMixin<E>
    on Queue<E>, ChangeNotifier, CollectionChangeNotifierMixin<E, int, E> {
  @override
  void add(value) {
    super.add(value);
    notifyListeners();
  }

  void _slientAddAll(Iterable<E> iterable) {
    super.addAll(iterable);
  }

  @override
  void addAll(Iterable<E> iterable) {
    _slientAddAll(iterable);
    notifyListeners();
  }

  @override
  void addFirst(E value) {
    super.addFirst(value);
    notifyListeners();
  }

  @override
  void addLast(E value) {
    super.addLast(value);
    notifyListeners();
  }

  @override
  bool remove(Object? value) {
    bool rm = super.remove(value);

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
  E removeFirst() => _removeGetItem(super.removeFirst);

  @override
  E removeLast() => _removeGetItem(super.removeLast);

  @override
  void removeWhere(bool Function(E element) test) {
    super.removeWhere(test);
    notifyListeners();
  }

  @override
  void retainWhere(bool Function(E element) test) {
    super.retainWhere(test);
    notifyListeners();
  }

  @override
  void clear() {
    super.clear();
    notifyListeners();
  }

  @override
  Iterable<E> get iterableForm => List.from(this);
}

/// Added [ChangeNotifier] implementation in [Queue].
abstract class QueueChangeNotifier<E>
    with ChangeNotifier, CollectionChangeNotifierMixin<E, int, E>
    implements Queue<E> {
  // ignore: unused_element
  QueueChangeNotifier._();

  /// Create a [Queue] with [ChangeNotifier] features.
  factory QueueChangeNotifier() = ListQueueChangeNotifier<E>;

  /// Create a new [Queue] that contains all [elements].
  factory QueueChangeNotifier.from(Iterable elements) =
      ListQueueChangeNotifier<E>.from;

  /// Create [Queue] from [elements].
  factory QueueChangeNotifier.of(Iterable<E> elements) =
      ListQueueChangeNotifier<E>.of;
}

/// List based [QueueChangeNotifier] that provides feature of [ListQueue]
/// with [ChangeNotifier] integration.
class ListQueueChangeNotifier<E> extends ListQueue<E>
    with
        ChangeNotifier,
        CollectionChangeNotifierMixin<E, int, E>,
        _QueueChangeNotifierMixin<E>
    implements QueueChangeNotifier<E> {
  /// Create new [ListQueueChangeNotifier] with given [initialCapacity] for
  /// prepare at leasst elements in this queue.
  ListQueueChangeNotifier([super.initialCapacity]);

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

  /// Create new
  factory ListQueueChangeNotifier.of(Iterable<E> elements) =>
      ListQueueChangeNotifier().._slientAddAll(elements);
}

class DoubleLinkedQueueChangeNotifier<E> extends DoubleLinkedQueue<E>
    with
        ChangeNotifier,
        CollectionChangeNotifierMixin<E, int, E>,
        _QueueChangeNotifierMixin<E>
    implements QueueChangeNotifier<E> {
  DoubleLinkedQueueChangeNotifier() : super();

  factory DoubleLinkedQueueChangeNotifier.from(Iterable elements) {
    DoubleLinkedQueueChangeNotifier<E> dlq = DoubleLinkedQueueChangeNotifier();
    for (final e in elements) {
      dlq.addLast(e as E);
    }

    return dlq;
  }

  factory DoubleLinkedQueueChangeNotifier.of(Iterable<E> elements) =>
      DoubleLinkedQueueChangeNotifier().._slientAddAll(elements);
}
