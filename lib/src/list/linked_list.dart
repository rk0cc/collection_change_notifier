part of 'list.dart';

/// Implemented [ChangeNotifier] features in [LinkedList].
class LinkedListChangeNotifier<E extends LinkedListEntry<E>>
    extends LinkedList<E> with ChangeNotifier, CollectionChangeNotifierMixin {
  /// Construct a new [LinkedList] with [ChangeNotifier] features.
  LinkedListChangeNotifier() : super();

  @override
  void add(E entry) {
    super.add(entry);
    notifyListeners();
  }

  @override
  void addAll(Iterable<E> entries) {
    super.addAll(entries);
    notifyListeners();
  }

  @override
  void addFirst(E entry) {
    super.addFirst(entry);
    notifyListeners();
  }

  @override
  bool remove(E entry) {
    bool rm = super.remove(entry);

    if (rm) {
      notifyListeners();
    }

    return rm;
  }

  @override
  void clear() {
    super.clear();
    notifyListeners();
  }
}
