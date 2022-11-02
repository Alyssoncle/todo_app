import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddTodoPage extends StatefulWidget {
  const AddTodoPage({Key? key}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'Title'),
          ),
          TextField(
            controller: subtitleController,
            decoration: const InputDecoration(hintText: 'Subtitle'),
          ),
          const SizedBox(
            height: 20,
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'Description'),
            keyboardType: TextInputType.multiline,
            minLines: 5,
            maxLines: 8,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: submitData,
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }

  Future<void> submitData() async {
    //Get the Data from form
    final title = titleController.text;
    final subtitle = subtitleController.text;
    final description = descriptionController.text;
    final body = {
      "title": title,
      "subtitle": subtitle,
      "description": description,
      "is_completed": false,
    };

    //Submit data to the server
    final url = 'https://crudcrud.com/api/7035e24fb46d4950b3173099cc369ac6';
    final uri = Uri.parse('$url/todo');
    final response = await http.post(uri, body: jsonEncode(body), headers: {"Content-Type": "application/json"});

    // show sucess or fail message based on status
    if (response.statusCode == 201) {
      titleController.text = '';
      subtitleController.text = '';
      descriptionController.text = '';
      showSucessMessage('Creation Sucess');
    } else {
      showErrorMessage('Creation Failed');
    }
  }

  void showSucessMessage(String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showErrorMessage(String message) {
    final snackBar = SnackBar(
      content: Text(message, style: const TextStyle(color: Colors.white)),
      backgroundColor: Colors.red,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
