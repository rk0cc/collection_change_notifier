import 'package:flutter/widgets.dart';

/// Totally basic mixin that define implemented collection is binded with
/// [ChangeNotifier].
///
/// Since it shared with [List], [Set], [Map] and other implemented from
/// `dart:collection`, it only provided shared limited properties which both of
/// them exist. Therefore, it should not be exported.
mixin CollectionChangeNotifierMixin<I> on ChangeNotifier {
  /// Get how many items contains in this collection or key-value pair for
  /// [Map].
  int get length;

  /// Check this collection does not assigned any items.
  bool get isEmpty => length == 0;

  /// Check this collection has at least one items assigned.
  bool get isNotEmpty => length != 0;

  Iterable<I> get iterableForm;
}
