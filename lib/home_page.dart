import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  static const String path = "MyHomePage";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url = "http://192.168.31.46:3000/api/v1/todo/";
  List data = [];

//
  late String docId;
  late TextEditingController _titleController;
  late TextEditingController _desCriptionController;

//

  Future getTodos() async {
    Map<String, dynamic> _data = {};
    final response = await http.get(Uri.parse("$url"));
    if (response.statusCode == 200) {
      setState(() {
        _data = jsonDecode(response.body);
        data = _data["todos"];
      });
    } else {
      print("object");
    }
  }

//
  Future createTodo() async {
    final response = await http.post(Uri.parse("$url"),
        body: jsonEncode(<String, String>{
          "title": _titleController.text,
          "description": _desCriptionController.text
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 201) {
      getTodos();
    }
  }

//

  Future deleteTodo(id) async {
    // print("id: $id");

    final response = await http.delete(
      Uri.parse("$url" + "/$id"),
    );

    print("response: ${response.body}");

    if (response.statusCode == 201) {
      print("Todo Delete successfully!");

      getTodos();
    }
  }

//

  Future updateTodos(id) async {
    final response = await http.put(Uri.parse("$url" + "/$id"),
        body: jsonEncode(<String, String>{
          "title": _titleController.text,
          "description": _desCriptionController.text
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    if (response.statusCode == 201) {
      print("Todo Update successfully!");
      getTodos();
    }
  }

//

  @override
  void initState() {
    _titleController = TextEditingController();
    _desCriptionController = TextEditingController();
    getTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Rest-API CRUD"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _titleController,
                decoration: InputDecoration(hintText: "Title"),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  controller: _desCriptionController,
                  decoration: InputDecoration(hintText: "Desscription"),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        createTodo();
                      },
                      child: Text("Add"),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        updateTodos(docId);
                      },
                      child: Text("Update"),
                    ),
                  ),
                ],
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: data.length,
                      itemBuilder: (ctx, index) {
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            child: Icon(Icons.task_alt),
                          ),
                          title: Text("${data[index]["title"]}"),
                          subtitle: Text("${data[index]["description"]}"),
                          trailing: Container(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    deleteTodo(data[index]["_id"]);
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.redAccent,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      _titleController.text =
                                          data[index]["title"];
                                      _desCriptionController.text =
                                          data[index]["description"];
                                      docId = data[index]["_id"];
                                    });
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      })),
            ],
          ),
        ),
      ),
    );
  }
}
