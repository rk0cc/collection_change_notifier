import 'package:collection_change_notifier/collection_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ExampleApp());
}

class StringNode {
  String ctx;

  StringNode(this.ctx);
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) =>
      ChangeNotifierProvider<ListChangeNotifier<StringNode>>(
          create: (context) => ListChangeNotifier(),
          builder: (context, child) => MaterialApp(
              title: "Collection change notifier example",
              home: const ExampleAppHome()));
}

class ExampleAppHome extends StatelessWidget {
  const ExampleAppHome({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: const Text("Collection change notifier list demo"),
            actions: <IconButton>[
              IconButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ExampleAppList())),
                  icon: Icon(Icons.list))
            ]),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                  "Count of items: ${Provider.of<ListChangeNotifier<StringNode>>(context).length}",
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center)
            ]),
        floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ExampleAppNodeEdit())),
            child: Icon(Icons.add)),
      );
}

class ExampleAppNodeEdit extends StatefulWidget {
  final int? editIdx;

  ExampleAppNodeEdit({this.editIdx, super.key})
      : assert(editIdx == null || editIdx >= 0);

  @override
  State<ExampleAppNodeEdit> createState() => _ExampleAppNodeEditState();
}

class _ExampleAppNodeEditState extends State<ExampleAppNodeEdit> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    String? txt = widget.editIdx == null
        ? null
        : Provider.of<ListChangeNotifier<StringNode>>(context,
                listen: false)[widget.editIdx!]
            .ctx;
    _controller = TextEditingController(text: txt);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text("${widget.editIdx == null ? 'Add' : 'Edit'} string"),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text("Type any text here"),
            Padding(
                padding: const EdgeInsets.all(14),
                child: TextField(
                  controller: _controller,
                )),
            SizedBox(
                width: 120,
                height: 48,
                child: ElevatedButton(
                    onPressed: () {
                      final snl = Provider.of<ListChangeNotifier<StringNode>>(
                          context,
                          listen: false);
                      if (widget.editIdx != null) {
                        snl.modify(widget.editIdx!, (item) {
                          item.ctx = _controller.text;
                        });
                      } else {
                        snl.add(StringNode(_controller.text));
                      }

                      Navigator.pop(context);
                    },
                    child: Text(widget.editIdx == null ? "Add" : "Apply")))
          ]));
}

enum EALOption { edit, delete, close }

class ExampleAppList extends StatelessWidget {
  const ExampleAppList({super.key});

  @override
  Widget build(BuildContext context) {
    ListChangeNotifier<StringNode> snl =
        Provider.of<ListChangeNotifier<StringNode>>(context);

    return Scaffold(
        appBar: AppBar(title: const Text("Applied text")),
        body: ListView.builder(
            itemCount: snl.length,
            itemBuilder: (context, index) => ListTile(
                title: Text(snl[index].ctx),
                onLongPress: () async {
                  EALOption opts = await showDialog<EALOption>(
                          context: context,
                          builder: (context) => SimpleDialog(
                                children: EALOption.values
                                    .map<SimpleDialogOption>((e) =>
                                        SimpleDialogOption(
                                            child: Text(
                                                "${e.name[0].toUpperCase()}${e.name.substring(1)}"),
                                            onPressed: () =>
                                                Navigator.pop<EALOption>(
                                                    context, e)))
                                    .toList(),
                              )) ??
                      EALOption.close;

                  switch (opts) {
                    case EALOption.edit:
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ExampleAppNodeEdit(editIdx: index)));
                      break;
                    case EALOption.delete:
                      snl.removeAt(index);
                      break;
                    case EALOption.close:
                      break;
                  }
                })));
  }
}
