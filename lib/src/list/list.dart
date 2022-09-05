import 'dart:collection';

import 'package:flutter/widgets.dart' show ChangeNotifier;

import '../abstract.dart';

part 'linked_list.dart';
part 'queue.dart';

/// Implemented [ChangeNotifier] feature into [List].
class ListChangeNotifier<E> extends ListBase<E>
    with
        ChangeNotifier,
        CollectionChangeNotifierMixin<E, int, E>,
        IterableCollectionChangeNotifieMixin<E> {
  final List<E> _list;

  /// Construct a new [ListChangeNotifier] with empty.
  ListChangeNotifier() : _list = [];

  /// Construct a new [ListChangeNotifier] from existed [elements].
  ListChangeNotifier.from(Iterable<E> elements)
      : _list = List.from(elements, growable: true);

  /// Set a new [length] of [ListChangeNotifier].
  ///
  /// If set [length] to greater then current one, it assigned `null` to
  /// appended index or thrown an error when [E] is not nullable.
  @override
  set length(int length) {
    _list.length = length;
    notifyListeners();
  }

  /// Get how many items assigned into this list.
  @override
  int get length => _list.length;

  /// Get [E] in [index].
  @override
  E operator [](int index) => _list[index];

  /// Assign new [value] from specified [index].
  ///
  /// This action will call [notifyListeners] when assigned.
  @override
  void operator []=(int index, E value) {
    _list[index] = value;
    notifyListeners();
  }

  /// Append a new [element] into this list.
  ///
  /// For assigning multiple [element]s, you **MUST** uses [addAll] instead of
  /// wrapping this into a loop which causing build error in Flutter.
  ///
  /// This action will call [notifyListeners] when assigned.
  @override
  void add(E element) {
    _list.add(element);
    notifyListeners();
  }

  /// Append multiple elements as [iterable] into this list.
  ///
  /// This action will call [notifyListeners] when assigned.
  @override
  void addAll(Iterable<E> iterable) {
    _list.addAll(iterable);
    notifyListeners();
  }

  /// Remove all indexed item in this list and [notifyListeners].
  @override
  void clear() {
    _list.clear();
    notifyListeners();
  }

  /// Remove a given [element] in this list and return [bool] that indicate it
  /// was in the list or not.
  ///
  /// When it `true`, [notifyListeners] will be called before returning result.
  @override
  bool remove(Object? element) {
    bool rm = _list.remove(element);

    if (rm) {
      notifyListeners();
    }

    return rm;
  }

  /// Remove an item from [index].
  ///
  /// If it removed without throwing [Error], [notifyListeners] will be called
  /// before returning removed item [E].
  @override
  E removeAt(int index) {
    E rmi = _list.removeAt(index);
    notifyListeners();
    return rmi;
  }

  /// Remove last index item of this list.
  ///
  /// If it removed without throwing [Error], [notifyListeners] will be called
  /// before returning removed item [E].
  @override
  E removeLast() {
    E rmi = _list.removeLast();
    notifyListeners();
    return rmi;
  }

  /// Remove items with a range of index.
  ///
  /// If it removed without throwing [Error], [notifyListeners] will be called.
  @override
  void removeRange(int start, int end) {
    _list.removeRange(start, end);
    notifyListeners();
  }

  /// Remove items by performing [test].
  ///
  /// It called [notifyListeners] no matter does any item removed or not.
  @override
  void removeWhere(bool Function(E element) test) {
    _list.removeWhere(test);
    notifyListeners();
  }

  /// Replace items in [start] and [end] index to [newContents].
  ///
  /// Once replaced, [notifyListeners] will be called.
  @override
  void replaceRange(int start, int end, Iterable<E> newContents) {
    _list.replaceRange(start, end, newContents);
    notifyListeners();
  }

  /// Retain items by passing [test].
  ///
  /// It called [notifyListeners] whatever items changed.
  @override
  void retainWhere(bool Function(E element) test) {
    _list.retainWhere(test);
    notifyListeners();
  }

  /// Overwrite an indexed item to [iterable] at start [index].
  ///
  /// This will call [notifyListeners].
  @override
  void setAll(int index, Iterable<E> iterable) {
    _list.setAll(index, iterable);
    notifyListeners();
  }

  /// Set items from [start] to [end] to given [iterable].
  ///
  /// If [skipCount] applied, [iterable] will be skipped then start applying
  /// item into this list. Finally, call [notifyListeners].
  @override
  void setRange(int start, int end, Iterable<E> iterable, [int skipCount = 0]) {
    _list.setRange(start, end, iterable, skipCount);
    notifyListeners();
  }

  @override
  Iterable<E> get iterableForm => List.from(_list);

  @override
  void modify(int index, void Function(E item) update) {
    update(this[index]);
    notifyListeners();
  }
}
