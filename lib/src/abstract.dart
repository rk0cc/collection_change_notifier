import 'package:flutter/widgets.dart';
import 'package:meta/meta.dart';

import 'list.dart' show ListChangeNotifier;
import 'map.dart' show MapChangeNotifier;
import 'set.dart' show SetChangeNotifier;

/// Totally basic mixin that define implemented collection is binded with
/// [ChangeNotifier].
///
/// Since it shared with [List], [Set], [Map] and other implemented from
/// `dart:collection`, it only provided shared limited properties which both of
/// them exist.
mixin CollectionChangeNotifierMixin<I, IDX, E> on ChangeNotifier {
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
  @protected
  Iterable<I> get iterableForm;

  /// Modify [E]'s properties from [index] inside of
  /// [CollectionChangeNotifierMixin]. After [update] proceeded, it called
  /// [notifyListeners].
  void modify(IDX index, void Function(E item) update);
}

/// An mixin handle [Iterable] based [CollectionChangeNotifierMixin] which
/// [E] is [Iterable] elements type.
@internal
mixin IterableCollectionChangeNotifieMixin<E>
    on CollectionChangeNotifierMixin<E, int, E>, Iterable<E> {
  @override
  void modify(int index, void Function(E item) update) {
    update(elementAt(index));
    notifyListeners();
  }
}
