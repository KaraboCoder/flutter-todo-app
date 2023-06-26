import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Todo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _controller;
  List<String> items = <String>[];

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 0),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: items.length,
                padding: const EdgeInsets.symmetric(vertical: 0),
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  return Dismissible(
                      key: Key(items[index]),
                      background: Container(color: Colors.red),
                      onDismissed: (direction) {
                        setState(() {
                          if (items.isNotEmpty) {
                            items.removeAt(index);
                          }
                        });
                      },
                      child: ListItem(item: items[index]));
                },
              ),
            ),
            Container(
              decoration: BoxDecoration(color: Colors.white, boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  offset: const Offset(0, -1),
                  blurRadius: 4,
                  spreadRadius: 2,
                )
              ]),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 30, top: 16),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                      labelText: "Add task", border: OutlineInputBorder()),
                  onSubmitted: (value) {
                    String task = _controller.text.trim();
                    if (task.isNotEmpty) {
                      setState(() {
                        items.add(task);
                        _controller.clear();
                      });
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  const ListItem({
    super.key,
    required this.item,
  });

  final String item;

  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text(item));
  }
}
