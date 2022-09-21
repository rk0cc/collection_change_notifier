import 'dart:math' as math;

import 'package:collection_change_notifier/collection_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

class NumNode {
  num number;

  NumNode(this.number);
}

class MapControllerPage extends StatelessWidget {
  const MapControllerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final MapChangeNotifier<String, NumNode> mcnnn =
        context.watch<MapChangeNotifier<String, NumNode>>();

    return Scaffold(
        body: ListView.builder(
            itemCount: mcnnn.iterableForm.length,
            itemBuilder: (context, index) {
              final entry = mcnnn.iterableForm.elementAt(index);

              return ListTile(
                  leading: Text("Key: ${entry.key}"),
                  title: Text("Map context: ${entry.value.number}"),
                  onTap: () {
                    mcnnn.modify(entry.key, (item) {
                      item!.number = double.nan;
                    });
                  },
                  onLongPress: () {
                    mcnnn.remove(entry.key);
                  });
            }),
        floatingActionButton: FloatingActionButton(onPressed: () {
          while (true) {
            String mk = String.fromCharCodes(
                List.generate(8, (index) => math.Random().nextInt(33) + 89));
            if (!mcnnn.containsKey(mk)) {
              mcnnn[mk] = NumNode(0);
              break;
            }
          }
        }));
  }
}

ChangeNotifierProvider<MapChangeNotifier<String, NumNode>> get cnp =>
    ChangeNotifierProvider(
        create: (context) => MapChangeNotifier(),
        builder: (context, child) =>
            MaterialApp(home: const MapControllerPage()));

void main() {
  group("Map change notifier test", () {
    testWidgets("test add", (tester) async {
      await tester.pumpWidget(cnp);

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pump();

      final unmod = find.text("Map context: 0");

      expect(unmod, findsOneWidget);
      expect(find.text("Map context: NaN"), findsNothing);
      expect(unmod.evaluate().length, equals(1));
    });
    testWidgets("test modified", (tester) async {
      await tester.pumpWidget(cnp);

      for (int i = 0; i < 7; i++) {
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pump(const Duration(milliseconds: 750));
      }

      final lt = find.byType(ListTile);
      await tester.tap(lt.at(math.Random().nextInt(5)));
      await tester.pump();

      final unmod = find.text("Map context: 0");

      expect(unmod, findsWidgets);
      expect(find.text("Map context: NaN"), findsOneWidget);
      expect(unmod.evaluate().length, equals(6));
    });
    testWidgets("test deleted", (tester) async {
      await tester.pumpWidget(cnp);

      for (int i = 0; i < 7; i++) {
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pump(const Duration(milliseconds: 750));
      }

      final lt = find.byType(ListTile);
      await tester.longPress(lt.at(math.Random().nextInt(7)));

      final unmod = find.text("Map context: 0");

      expect(unmod, findsWidgets);
      expect(find.text("Map context: NaN"), findsNothing);
      expect(unmod.evaluate().length, equals(6));
    });
  });
}
