import 'package:flutter/widgets.dart';

import 'list/list.dart' show ListChangeNotifier;
import 'map/map.dart' show MapChangeNotifier;
import 'set/set.dart' show SetChangeNotifier;

/// Totally basic mixin that define implemented collection is binded with
/// [ChangeNotifier].
///
/// Since it shared with [List], [Set], [Map] and other implemented from
/// `dart:collection`, it only provided shared limited properties which both of
/// them exist.
mixin CollectionChangeNotifierMixin<I, IDX, T> on ChangeNotifier {
  /// Get how many items contains in this collection or key-value pair for
  /// [Map].
  int get length;

  /// Check this collection does not assigned any items.
  bool get isEmpty => length == 0;

  /// Check this collection has at least one items assigned.
  bool get isNotEmpty => length != 0;

  /// Return this collection into [Iterable] form.
  ///
  /// For [ListChangeNotifier] and [SetChangeNotifier], it just returned a new
  /// [Iterable] contains same elements.
  ///
  /// [MapChangeNotifier] will be returned an [Iterable] of [MapEntry] which
  /// repersent a key-value pair.
  Iterable<I> get iterableForm;

  /// Modify [T]'s properties from [index] inside of
  /// [CollectionChangeNotifierMixin]. After [update] process, it called
  /// [notifyListeners].
  void modify(IDX index, void Function(T item) update);
}

/// An mixin handle [Iterable] based [CollectionChangeNotifierMixin] which
/// [I] is [Iterable] elements type.
mixin IterableCollectionChangeNotifieMixin<I>
    on CollectionChangeNotifierMixin<I, int, I>, Iterable<I> {
  @override
  void modify(int index, void Function(I item) update) {
    update(this.elementAt(index));
    notifyListeners();
  }
}
