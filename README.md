# Binding Dart collection model to ChangeNotifier in Flutter

This package implemented Dart's collection object with ChangeNotifier that it updated when collection item changed.

## Warning: Untested

This repositry is newly created without testing. As alpha development stage, it is excepted serval error thrown.

## Purpose

Flutter provides `ChangeNotifier` for handling update when mutable object's property changed and make widget rebuild (`provider` package).
However, when it handle multiple items under a single object, it required specific implementation by yourself which limited features from collections when required.
As a reault, this package provides `List`, `Map` and `Set` with `ChangeNotifier` integration.

It similar how `BindingList` worked in .NET.

## Install

#### Edit pubspec.yaml:

* ~~From pub.dev~~ (Available when making pre-release)

```yaml
dependencies:
    collection_change_notifier: 1.0.0
```

* From Git (For unstable release)

```yaml
dependencies:
    git:
        url: https://github.com/rk0cc/collection_change_notifier.git
        ref: (Commit hash or tags name)
```

## License

BSD-3