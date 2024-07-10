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
    TodoPovider todoPovider = Provider.of<TodoPovider>(context, listen: true);
    return RefreshIndicator(
      triggerMode: RefreshIndicatorTriggerMode.anywhere,
      onRefresh: () async {
        setState(() {
          todoPovider.getAllTodo();
          // todoPovider.clear();
        });
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromARGB(255, 145, 173, 147),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => AddNewNote()));
            setState(() {
              todoPovider.getAllTodo();
            });
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          leading: const Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
          ),
          backgroundColor: const Color.fromARGB(255, 70, 123, 74),
          title: const Padding(
            padding: EdgeInsets.only(left: 70),
            child: Text(
              'Todo App',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 25),
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                // todoPovider.clear();
                setState(() {
                  todoPovider.getAllTodo();
                });
              },
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
                size: 30,
              ),
            ),
          ],
        ),
        body: Container(
          color: const Color.fromARGB(255, 68, 72, 72),
          child: Column(
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
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  todoPovider.todos[index]['title'].toString(),
                                  style: TextStyle(
                                      color: Colors.grey.shade800,
                                      fontSize: 20),
                                ),
                                Text(
                                  todoPovider.todos[index]['description']
                                      .toString(),
                                  maxLines: 3,
                                  style: TextStyle(
                                      color: Colors.grey.shade300,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Text(todoPovider.todos[index]['createdAt'].toString()),
                        IconButton(
                          onPressed: () {
                            todoPovider.updateTodo(index, context);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 25,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            todoPovider.deleteTodo(index);
                            setState(() {
                              todoPovider.getAllTodo();
                            });
                          },
                          icon: const Icon(
                            Icons.remove_circle_outlined,
                            color: Colors.white,
                            size: 25,
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
      ),
    );
  }
}
