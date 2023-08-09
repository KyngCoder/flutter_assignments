import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/todo_model.dart'; // Import your todo model here

class UpdateScreen extends StatefulWidget {
  final Todo todo;

  const UpdateScreen({super.key, required this.todo});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo.title);
    _descriptionController =
        TextEditingController(text: widget.todo.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  List<Todo> todos = [];

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

  Future<void> _updateTodo() async {
    if (_formKey.currentState!.validate()) {
      String updatedTitle = _titleController.text;
      String updatedDescription = _descriptionController.text;

      // Create the updated todo
      Todo updatedTodo = Todo(
        title: updatedTitle,
        description: updatedDescription,
      );

      // Get the list of existing todos
      List<Todo> existingTodos = await _getTodos();

      // Find the index of the todo to update
      int index = existingTodos.indexOf(widget.todo);
      print(index);

      if (index != -1) {
        // Replace the old todo with the updated one
        existingTodos[index] = updatedTodo;

        // Save the updated list to SharedPreferences
        await _saveTodos(existingTodos);

        // Navigate back to the previous screen
        Navigator.pop(context);
      }
    }
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
    print(widget.todo.title);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Todo',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 40,
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: TextFormField(
                        controller: _titleController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter todo title',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      child: TextFormField(
                        controller: _descriptionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a description';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter todo description',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 56),
                  child: ElevatedButton(
                    onPressed: _updateTodo,
                    child: Text(
                      "Update Todo",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(350, 70),
                        backgroundColor: Color.fromARGB(255, 4, 21, 77)),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
