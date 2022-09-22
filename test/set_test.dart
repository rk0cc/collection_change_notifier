/*
  This setting basically just apply immutable object.

  It seem not necessary for handling modification in most case.

  Therefore, this test does not include modification
*/
import 'package:collection_change_notifier/collection_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

class SetControllerPage extends StatelessWidget {
  const SetControllerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final SetChangeNotifier<int> lcnsn =
        context.watch<SetChangeNotifier<int>>();

    return Scaffold(
        body: ListView.builder(
            itemCount: lcnsn.length,
            itemBuilder: (context, index) => ListTile(
                title: Text("Set context: ${lcnsn.elementAt(index)}"),
                onTap: () {
                  // Make a duplicate one instead of editing value
                  lcnsn.add(lcnsn.elementAt(index));
                },
                onLongPress: () {
                  lcnsn.remove(lcnsn.elementAt(index));
                })),
        floatingActionButton: FloatingActionButton(onPressed: () {
          lcnsn.add(lcnsn.length);
        }));
  }
}

ChangeNotifierProvider<SetChangeNotifier<int>> get cnp =>
    ChangeNotifierProvider(
        create: (context) => SetChangeNotifier<int>(),
        builder: (context, child) => MaterialApp(home: SetControllerPage()));

void main() {
  group("Set change notifier test", () {
    testWidgets("test add", (tester) async {
      await tester.pumpWidget(cnp);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      final unmod = find.text("Set context: 0");
      expect(unmod, findsOneWidget);

      await tester.tap(unmod);
      expect(unmod, findsOneWidget);
    });
    testWidgets("test deleted", (tester) async {
      await tester.pumpWidget(cnp);

      for (int i = 0; i < 2; i++) {
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pump(const Duration(milliseconds: 500));
      }

      final lt = find.byType(ListTile);
      await tester.longPress(lt.at(0));

      final unmod = find.text("Set context: 1");

      expect(unmod, findsWidgets);
      expect(find.text("Set context: 0"), findsNothing);
      expect(unmod.evaluate().length, equals(1));
    });
  });
}
