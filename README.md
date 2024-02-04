# Binding Dart collection model to ChangeNotifier in Flutter

> [!WARNING]
> This branch is designed for retaining Dart 2 supports for production only. Upgrade to Dart 3 and apply `2.0.0` or above is preferred.

This package implemented Dart's collection object with ChangeNotifier that it updated when collection item changed.

Also, [online demo](https://osp.rk0cc.xyz/collection_change_notifier/) available

## Purpose

Flutter provides `ChangeNotifier` for handling update when mutable object's property changed and make widget rebuild (`provider` package).
However, when it handle multiple items under a single object, it required specific implementation by yourself which limited features from collections when required.
As a reault, this package provides `List`, `Map` and `Set` with `ChangeNotifier` integration.

It similar how `BindingList` worked in .NET.

## Install

#### Edit pubspec.yaml:

```yaml
dependencies:
    collection_change_notifier:
        git:
            url: https://github.com/rk0cc/collection_change_notifier.git
            ref: legacy
```

## Usage

Mostly it integrated with `notifyListener` already when editing items in the collections unless changing state of element directly
which required to uses `modify` to notify update:

```dart
class IntState {
    int state;

    IntState(this.state);
}

final ListChangeNotifier<IntState> lcnis = ListChangeNotifier()..add(IntState(1));

// Attach lcnis to ChangeNotifierProvider.value

// Do not change element state directly, this action will not trigger Flutter to rebuild context.
lcnis[0].state = 2;

// Call modify if want to trigger Flutter rebuild when element state changed via `modify`:
lcnis.modify(0, (item) {
    item.state = 2;
});

// For map:
final MapChangeNotifier<String, IntState> mscnis = MapChangeNotifier()..["one"] = IntState(1);

mscnis.modify("one", (item) {
    // Null check required to ensure it is assigned (when value type is non-nullable)
    if (item != null) {
        item.state = 2;
    }
    // item!.state = 2; // (Not recommeded which make more complicated for error hadling)
})
```

## Limitations

It only implemented based on the class method which there is no ovridden method for extensions.
Extensions method tend to be invoked multiple time of `notifyListeners` that causing build error throw.

## License

BSD-3
