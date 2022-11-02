import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_page.dart';
import 'package:http/http.dart' as http;

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List items = [];

  @override
  void initState() {
    super.initState();
    fetchTodo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: RefreshIndicator(
        onRefresh: fetchTodo,
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index] as Map;
            return ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text(item['title']),
              subtitle: Text(item['subtitle']),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: navigateToAddPage,
        label: const Text('Add Todo'),
      ),
    );
  }

  void navigateToAddPage() {
    final route = MaterialPageRoute(
      builder: (context) => const AddTodoPage(),
    );
    Navigator.push(context, route);
  }

  Future<void> fetchTodo() async {
    final url = 'https://crudcrud.com/api/7035e24fb46d4950b3173099cc369ac6';
    final uri = Uri.parse('$url/todo');
    final response = await http.get(uri);
    print(response.body);
    print(jsonDecode(response.body));
    print(List.from(jsonDecode(response.body)));
    /*if (response.statusCode == 200) {
      final json = (List.from(jsonDecode(response.body))) as Map;
      final result = json['items'] as List;
      setState(() {
        items = result;
      });
    } else {
      //show Error
    }*/
  }
}
