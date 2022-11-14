import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'To-Do List',
        debugShowCheckedModeBanner: false,
        home: ToDoList());
  }
}

class Entry {
  String name;
  bool colorChange;
  Color cardBackground;

  Entry(
      {required this.name,
      required this.colorChange,
      required this.cardBackground});
}

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  List<Entry> toDo = [];
  String input = "";

  @override
  void initState() {
    super.initState();
    toDo.add(Entry(
        name: "Make Midterm Project",
        colorChange: false,
        cardBackground: Colors.white));
    toDo.add(
        Entry(name: "Sleep", colorChange: false, cardBackground: Colors.white));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My To-Do List"),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Add Task To List"),
                      content: TextField(
                        onChanged: (String value) {
                          input = value;
                        },
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                Navigator.of(context).pop();
                              });
                            },
                            child: Text("Back")),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (input != "") {
                                  toDo.add(Entry(
                                      name: input,
                                      colorChange: false,
                                      cardBackground: Colors.white));
                                  input = "";
                                  Navigator.of(context).pop();
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                            title:
                                                Text("Cannot Add Empty Entry"),
                                            actions: <Widget>[
                                              ElevatedButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      Navigator.of(context)
                                                          .pop();
                                                    });
                                                  },
                                                  child: Text("Back")),
                                            ]);
                                      });
                                }
                              });
                            },
                            child: Text("Add")),
                      ],
                    );
                  });
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
            )),
        body: ListView.builder(
            itemCount: toDo.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                  key: Key(toDo[index].name),
                  onDismissed: (direction) => {
                        setState(() {
                          toDo.removeAt(index);
                        })
                      },
                  child: Card(
                    elevation: 2,
                    color: toDo[index].cardBackground,
                    child: ListTile(
                      title: Text(toDo[index].name),
                      trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.yellow,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title:
                                        Text("Edit '" + toDo[index].name + "'"),
                                    content: TextField(
                                      onChanged: (String value) {
                                        input = value;
                                      },
                                    ),
                                    actions: <Widget>[
                                      ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              Navigator.of(context).pop();
                                            });
                                          },
                                          child: Text("Back")),
                                      ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              if (input != "") {
                                                toDo[index].name = input;
                                                toDo[index].colorChange = false;
                                                Navigator.of(context).pop();
                                                input = "";
                                              } else {
                                                showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                          title: Text(
                                                              "Cannot Add Empty Entry"),
                                                          actions: <Widget>[
                                                            ElevatedButton(
                                                                onPressed: () {
                                                                  setState(() {
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  });
                                                                },
                                                                child: Text(
                                                                    "Back")),
                                                          ]);
                                                    });
                                              }
                                            });
                                          },
                                          child: Text("Edit"))
                                    ],
                                  );
                                });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () {
                            setState(() {
                              toDo.removeAt(index);
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.done),
                          color: Colors.green,
                          onPressed: () {
                            setState(() {
                              toDo[index].colorChange =
                                  !toDo[index].colorChange;
                              if (toDo[index].colorChange) {
                                toDo[index].cardBackground = Colors.greenAccent;
                              } else {
                                toDo[index].cardBackground = Colors.white;
                              }
                            });
                          },
                        ),
                      ]),
                    ),
                  ));
            }));
  }
}
