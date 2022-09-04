part of 'list.dart';

mixin _QueueChangeNotifierMixin<E>
    on Queue<E>, ChangeNotifier, CollectionChangeNotifierMixin {
  @override
  void add(value) {
    super.add(value);
    notifyListeners();
  }

  @override
  void addAll(Iterable<E> iterable) {
    super.addAll(iterable);
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
}

abstract class QueueChangeNotifier<E>
    with ChangeNotifier, CollectionChangeNotifierMixin
    implements Queue<E> {
  QueueChangeNotifier._();

  factory QueueChangeNotifier() = ListQueueChangeNotifier<E>;

  factory QueueChangeNotifier.from(Iterable elements) =
      ListQueueChangeNotifier<E>.from;

  factory QueueChangeNotifier.of(Iterable<E> elements) =
      ListQueueChangeNotifier<E>.of;
}

class ListQueueChangeNotifier<E> extends ListQueue<E>
    with
        ChangeNotifier,
        CollectionChangeNotifierMixin,
        _QueueChangeNotifierMixin<E>
    implements QueueChangeNotifier<E> {
  ListQueueChangeNotifier([super.initialCapacity]);

  factory ListQueueChangeNotifier.from(Iterable elements) {
    ListQueue<E> lq = ListQueue.from(elements);
    ListQueueChangeNotifier<E> lqcn = ListQueueChangeNotifier(lq.length);

    for (final element in lq) {
      lqcn.addLast(element);
    }

    return lqcn;
  }

  factory ListQueueChangeNotifier.of(Iterable<E> elements) =>
      ListQueueChangeNotifier()..addAll(elements);
}

class DoubleLinkedQueueChangeNotifier<E> extends DoubleLinkedQueue<E>
    with
        ChangeNotifier,
        CollectionChangeNotifierMixin,
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
      DoubleLinkedQueueChangeNotifier()..addAll(elements);
}
