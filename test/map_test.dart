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
                  title: Text("List context: ${entry.value.number}"),
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
          mcnnn[String.fromCharCodes(List.generate(
              8, (index) => math.Random().nextInt(33) + 89))] = NumNode(0);
        }));
  }
}

void main() {}
