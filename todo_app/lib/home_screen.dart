import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/create_todo.dart';
import 'package:todo_app/todo_model.dart';
import 'package:todo_app/update_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> todos = [];

  @override
  void initState() {
    super.initState();
    _loadTodos(); // Load todos from SharedPreferences
  }

  Future<void> _loadTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? todoStrings = prefs.getStringList('todos');
    if (todoStrings != null) {
      List<Todo> loadedTodos = todoStrings.map((todoString) {
        Map<String, dynamic> todoMap = jsonDecode(todoString);
        return Todo.fromMap(todoMap);
      }).toList();

      setState(() {
        todos = loadedTodos;
      });
    }
  }

  Future<List<Todo>> _getTodos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? todoStrings = prefs.getStringList('todos');
    if (todoStrings == null) {
      return [];
    }
    return todoStrings.map((todoString) {
      Map<String, dynamic> todoMap = jsonDecode(todoString);
      return Todo.fromMap(todoMap);
    }).toList();
  }

  Future<void> _deleteTodo(int index) async {
    List<Todo> updatedTodos = await _getTodos();
    updatedTodos.removeAt(index);
    await _saveTodos(updatedTodos);
    setState(() {
      todos = updatedTodos;
    });
  }

  Future<void> _saveTodos(List<Todo> todos) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoStrings = todos.map((todo) {
      return jsonEncode(todo.toMap());
    }).toList();
    await prefs.setStringList('todos', todoStrings);
  }

  @override
  Widget build(BuildContext context) {
    print("todo $todos");

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Todo List",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            height: 20,
          ),
          if (todos.length == 0)
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(48, 30, 48, 0),
                  child: Text(
                    "Nothing to do, start creating",
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(todos[index].title), // Unique key for each todo
                    onDismissed: (direction) {
                      // Handle the dismiss action (delete todo)
                      _deleteTodo(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8),
                      child: ListTile(
                        onTap:() async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  UpdateScreen(todo: todos[index],)),
              );
              _loadTodos(); // Load todos when returning from CreateTodo
            },
                        shape: BeveledRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        contentPadding: EdgeInsets.all(8),
                        tileColor: Color.fromARGB(255, 9, 31, 104),
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            todos[index].title,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          GestureDetector(
            onTap: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CreateTodo()),
              );
              _loadTodos(); // Load todos when returning from CreateTodo
            },
            child: const Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 32, 48),
                child: CircleAvatar(
                  radius: 45,
                  child: Icon(
                    Icons.add,
                    size: 64,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
