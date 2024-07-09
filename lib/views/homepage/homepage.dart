import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/todo_povider.dart';
import 'package:todo_app/views/add_new_t/add_new_todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    TodoPovider todoPovider = Provider.of<TodoPovider>(context, listen: false);
    todoPovider.getAllTodo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TodoPovider todoPovider = Provider.of<TodoPovider>(context, listen: false);
    return RefreshIndicator(
      onRefresh: () async {
        setState(() {
          todoPovider.getAllTodo();
        });
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddNewNote()));
            setState(() {});
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          backgroundColor: Colors.green,
        ),
        body: Column(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: todoPovider.todos.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.green,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              todoPovider.todos[index]['title'].toString(),
                              style: TextStyle(
                                  color: Colors.grey.shade800, fontSize: 18),
                            ),
                            Text(
                              todoPovider.todos[index]['description']
                                  .toString(),
                              maxLines: 3,
                              style: TextStyle(
                                  color: Colors.grey.shade300, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.push_pin,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
