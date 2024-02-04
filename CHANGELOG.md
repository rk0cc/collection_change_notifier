## 2.0.2

* Unified factory implementations for `QueueChangeNotifier`'s child classes.

## 2.0.1

* Mark `iterableForm` getter `@protected`.
* Add `notifyListeners` when `first` and `last` setter called in `ListChangeNotifier`.
* Add missing documentations.

## 2.0.0

* Upgrade to Dart 3 with new syntax applied.
* Majority classes are no longer belong with origin collections classes due to type scope.
    * These classes will no longer implement origin class which marked as `final`, and the suggested type for compatible in `2.0.0`:
        <table>
            <tr>
                <th>Affected classes</th>
                <th>Implemented collection types in <code>1.0.0</code></th>
                <th>Suggested types for maximum compatibility</th>
            </tr>
            <tr>
                <td><code>ListQueueChangeNotifier</code></td>
                <td><code>ListQueue</code></td>
                <td rowspan="2"><code>Queue</code></td>
            </tr>
            <tr>
                <td><code>DoubleLinkedQueueChangeNotifier</code></td>
                <td><code>DoubleLinkedQueue</code></td>
            </tr>
            <tr>
                <td><code>HashMapChangeNotifier</code></td>
                <td><code>HashMap</code></td>
                <td rowspan="3"><code>Map</code></td>
            </tr>
            <tr>
                <td><code>LinkedHashMapChangeNotifier</code></td>
                <td><code>LinkedHashMap</code></td>
            </tr>
            <tr>
                <td><code>SplayTreeMapChangeNotifier</code></td>
                <td><code>SplayTreeMap</code></td>
            </tr>
            <tr>
                <td><code>HashSetChangeNotifier</code></td>
                <td><code>HashSet</code></td>
                <td rowspan="3"><code>Set</code></td>
            </tr>
            <tr>
                <td><code>LinkedHashSetChangeNotifier</code></td>
                <td><code>LinkedHashSet</code></td>
            </tr>
            <tr>
                <td><code>SplayTreeSetChangeNotifier</code></td>
                <td><code>SplayTreeSet</code></td>
            </tr>
        </table>

## 1.0.0+1

* Implement `sort` for `ListChangeNotifier`

## 1.0.0

* First stable release

## 1.0.0-pre.2

* Implement `fillRange`, `insert` and `insertAll` methods in `ListChangeNotifier`

## 1.0.0-pre.1

* First version that publish to `pub.dev`.

## 1.0.0-alpha.1

* First release of this package.
* Implement `List`, `Map` and `Set` intergation with `ChangeNotifier`.
