# Binding Dart collection model to ChangeNotifier in Flutter

<p align="center">
    <a href="https://pub.dev/packages/collection_change_notifier"><img alt="Pub Version (including pre-releases)" src="https://img.shields.io/pub/v/collection_change_notifier?include_prereleases&style=for-the-badge"/></a>
</p>

This package implemented Dart's collection object with ChangeNotifier that it updated when collection item changed.

## Purpose

Flutter provides `ChangeNotifier` for handling update when mutable object's property changed and make widget rebuild (`provider` package).
However, when it handle multiple items under a single object, it required specific implementation by yourself which limited features from collections when required.
As a reault, this package provides `List`, `Map` and `Set` with `ChangeNotifier` integration.

It similar how `BindingList` worked in .NET.

## Install

#### Edit pubspec.yaml:

* From pub.dev

```yaml
dependencies:
    collection_change_notifier: 1.0.0-pre.1
```

* From Git (For unstable release)

```yaml
dependencies:
    git:
        url: https://github.com/rk0cc/collection_change_notifier.git
        ref: (Commit hash or tags name)
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

## License

BSD-3