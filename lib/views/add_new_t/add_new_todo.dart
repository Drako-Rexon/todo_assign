import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/todo_povider.dart';

class AddNewNote extends StatelessWidget {
  AddNewNote({super.key});
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("T A S K  D E T A I L S"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: IconButton(
          onPressed: () {
            if (titleController.text.trim() != '' &&
                descriptionController.text.trim() != '') {
              TodoPovider todoPovider =
                  Provider.of<TodoPovider>(context, listen: false);

              Map<String, dynamic> data = {
                'title': titleController.text,
                'description': descriptionController.text,
                'createdAt': DateTime.now().minute,
                'updatedAt': DateTime.now(),
              };

              todoPovider.addTodo(data);
              // todoPovider.addTodo(data);

              Navigator.pop(context);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  shape: BeveledRectangleBorder(),
                  content: Text(
                    "Please fill all the fields",
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }
          },
          icon: const Icon(Icons.save),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none, // Removes the default border
                filled: true,
                // fillColor: Colors.grey[200], // Background color
                hintText: 'Enter your Title', // Placeholder text

                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0), // Padding
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Colors.transparent), // No border when not focused
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Colors.blue), // Border color when focused
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              controller: titleController,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none, // Removes the default border
                filled: true,
                // fillColor: Colors.grey[200], // Background color
                hintText: 'Description', // Placeholder text

                contentPadding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 16.0), // Padding
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Colors.transparent), // No border when not focused
                  borderRadius: BorderRadius.circular(10.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Colors.blue), // Border color when focused
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              controller: descriptionController,
            ),
          ),
        ],
      ),
    );
  }
}
