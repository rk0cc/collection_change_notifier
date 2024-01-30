/// Integrated [ChangeNotifier] features into [List], [Set], [Map] and fews
/// built-in [Iterable] subclasses.
///
/// It trigger [ChangeNotifier.notifyListeners] after changing items of the
/// collections' elements or perform [CollectionChangeNotifierMixin.modify].
///
/// This package provides a convinence method to implements Dart collections
/// into [InheritedWidget] with binding element changes. Thus, it can be
/// implemented with [provider](https://pub.dev/packages/provider) package
/// perfectly.
library collection_change_notifier;

import 'src/abstract.dart' show CollectionChangeNotifierMixin;
import 'package:flutter/widgets.dart';

export 'src/list.dart';
export 'src/map.dart';
export 'src/set.dart';

export 'src/abstract.dart' show CollectionChangeNotifierMixin;
