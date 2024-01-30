import 'dart:math' as math;

import 'package:collection_change_notifier/collection_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

class StringNode {
  String text;

  StringNode(this.text);
}

class ListControllerPage extends StatelessWidget {
  const ListControllerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ListChangeNotifier<StringNode> lcnsn =
        context.watch<ListChangeNotifier<StringNode>>();

    return Scaffold(
        body: ListView.builder(
            itemCount: lcnsn.length,
            itemBuilder: (context, index) => ListTile(
                title: Text("List context: ${lcnsn[index].text}"),
                onTap: () {
                  lcnsn.modify(index, (item) {
                    item.text = "modified";
                  });
                },
                onLongPress: () {
                  lcnsn.removeAt(index);
                })),
        floatingActionButton: FloatingActionButton(onPressed: () {
          lcnsn.add(StringNode("unmodified"));
        }));
  }
}

ChangeNotifierProvider<ListChangeNotifier<StringNode>> get cnp =>
    ChangeNotifierProvider(
        create: (context) => ListChangeNotifier<StringNode>(),
        builder: (context, child) => const MaterialApp(home: ListControllerPage()));

void main() {
  group("List change notifier test", () {
    testWidgets("test add", (tester) async {
      await tester.pumpWidget(cnp);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      final unmod = find.text("List context: unmodified");

      expect(unmod, findsOneWidget);
      expect(find.text("List context: modified"), findsNothing);
      expect(unmod.evaluate().length, equals(1));
    });
    testWidgets("test modified", (tester) async {
      await tester.pumpWidget(cnp);

      for (int i = 0; i < 5; i++) {
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pump(const Duration(milliseconds: 500));
      }

      final lt = find.byType(ListTile);
      await tester.tap(lt.at(math.Random().nextInt(5)));
      await tester.pump();

      final unmod = find.text("List context: unmodified");

      expect(unmod, findsWidgets);
      expect(find.text("List context: modified"), findsOneWidget);
      expect(unmod.evaluate().length, equals(4));
    });
    testWidgets("test deleted", (tester) async {
      await tester.pumpWidget(cnp);

      for (int i = 0; i < 5; i++) {
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pump(const Duration(milliseconds: 500));
      }

      final lt = find.byType(ListTile);
      await tester.longPress(lt.at(math.Random().nextInt(5)));

      final unmod = find.text("List context: unmodified");

      expect(unmod, findsWidgets);
      expect(find.text("List context: modified"), findsNothing);
      expect(unmod.evaluate().length, equals(4));
    });
  });
}
