import 'package:collection_change_notifier/collection_change_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const ExampleApp());
}

/// Create a mutable object that contains a [String] which can be changed.
class StringNode {
  /// State of context, can be changed.
  String ctx;

  /// Initalize [StringNode] with given initial value of [ctx].
  StringNode(this.ctx);
}

/// Entry of the app.
class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) =>
      // Bind ChangeNotifierProvider with empty ListChangeNotifier when created.
      ChangeNotifierProvider<ListChangeNotifier<StringNode>>(
          create: (context) => ListChangeNotifier(),
          builder: (context, child) => MaterialApp(
              title: "Collection change notifier example",
              home: const ExampleAppHome()));
}

/// Homepage of the demo app
class ExampleAppHome extends StatelessWidget {
  const ExampleAppHome({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: const Text("Collection change notifier list demo"),
            actions: <IconButton>[
              // List StringNode that applied into ListChangeNotifier
              IconButton(
                  onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ExampleAppList())),
                  icon: Icon(Icons.list))
            ]),
        body: Center(
            child: ListView(
                padding: const EdgeInsets.all(20),
                shrinkWrap: true,
                children: <Widget>[
              // Counting items of StringNode which store into the list.
              Text(
                  "Count of items: ${Provider.of<ListChangeNotifier<StringNode>>(context).length}",
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center)
            ])),
        floatingActionButton: FloatingActionButton(
            // Create new StringNode data
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => ExampleAppNodeEdit())),
            child: Icon(Icons.add)),
      );
}

/// A widget uses to create or edit [StringNode].
class ExampleAppNodeEdit extends StatefulWidget {
  /// Specify index of the [StringNode] to be modified.
  ///
  /// If leave it null, it assume as create new [StringNode].
  final int? editIdx;

  /// Create [ExampleAppNodeEdit] with given [editIdx].
  ExampleAppNodeEdit({this.editIdx, super.key})
      : assert(editIdx == null || editIdx >= 0);

  @override
  State<ExampleAppNodeEdit> createState() => _ExampleAppNodeEditState();
}

class _ExampleAppNodeEditState extends State<ExampleAppNodeEdit> {
  /// Controller for capture [StringNode.ctx].
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    // Getting context of StringNode. If index is null, it return null.
    String? txt = widget.editIdx == null
        ? null
        : Provider.of<ListChangeNotifier<StringNode>>(context,
                listen: false)[widget.editIdx!]
            .ctx;

    // Construct controller with assigned text.
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
            // A textbox that allow you to type anything and apply to StringNode.
            Padding(
                padding: const EdgeInsets.all(14),
                child: TextField(
                  controller: _controller,
                )),
            //A button that store user typed text into StringNode.
            SizedBox(
                width: 120,
                height: 48,
                child: ElevatedButton(
                    onPressed: () {
                      final snl = Provider.of<ListChangeNotifier<StringNode>>(
                          context,
                          listen: false);
                      if (widget.editIdx != null) {
                        // Invoke modify when edit index is given
                        snl.modify(widget.editIdx!, (item) {
                          item.ctx = _controller.text;
                        });
                      } else {
                        // Create new StringNode and add into ListChangeNotifier if editIdx is null.
                        snl.add(StringNode(_controller.text));
                      }

                      // Pop this page when applied.
                      Navigator.pop(context);
                    },
                    child: Text(widget.editIdx == null ? "Add" : "Apply")))
          ]));
}

enum EALOption { edit, delete, close }

/// A widget uses to list existed [StringNode] from [Provider]
class ExampleAppList extends StatelessWidget {
  const ExampleAppList({super.key});

  @override
  Widget build(BuildContext context) {
    // Get ListChangeNotifier which attached from entry point.
    ListChangeNotifier<StringNode> snl =
        Provider.of<ListChangeNotifier<StringNode>>(context);

    return Scaffold(
        appBar: AppBar(title: const Text("Applied text")),
        body: ListView.builder(
            itemCount: snl.length,
            itemBuilder: (context, index) => ListTile(
                title: Text(snl[index].ctx),
                // Display option of applied StringNode.
                onLongPress: () async {
                  final EALOption opts = await showDialog<EALOption>(
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
