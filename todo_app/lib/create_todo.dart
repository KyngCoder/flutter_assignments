import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'todo_model.dart'; // Import the Todo model class

class CreateTodo extends StatefulWidget {
  const CreateTodo({Key? key}) : super(key: key);

  @override
  State<CreateTodo> createState() => _CreateTodoState();
}

class _CreateTodoState extends State<CreateTodo> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _descriptionController.dispose();
  }

  void _addTodo() async {
    if (_formKey.currentState!.validate()) {
      String title = _titleController.text;
      String description = _descriptionController.text;

      // Create a Todo instance
      Todo todo = Todo(title: title, description: description);
      print("todo $todo");
      // Retrieve existing todos
      List<Todo> existingTodos = await _getTodos();
      print("ex $existingTodos");
      // Add the new todo
      existingTodos.add(todo);

      // Save updated todos to SharedPreferences
      await _saveTodos(existingTodos);
 Navigator.pop(context); 
      
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



  Future<void> _saveTodos(List<Todo> todos) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> todoStrings = todos.map((todo) {
      return jsonEncode(todo.toMap());
    }).toList();
    await prefs.setStringList('todos', todoStrings);
  }

 
  @override
  Widget build(BuildContext context) {
 
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Todo',
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
                    onPressed: _addTodo,
                    child: Text(
                      "Create Todo",
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    style: ElevatedButton.styleFrom(minimumSize: const Size(350, 70), backgroundColor:const Color.fromARGB(255, 4, 21, 77)),
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
