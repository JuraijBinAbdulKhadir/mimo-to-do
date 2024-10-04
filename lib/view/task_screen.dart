import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/task_provider.dart';
import '../provider/category_provider.dart'; // Make sure to import this

class TasksScreen extends StatelessWidget {
  final String categoryId;
  final String categoryName;
  final TextEditingController _taskController = TextEditingController();

  TasksScreen({required this.categoryId, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    // Fetch tasks when the screen is built
    Provider.of<TaskProvider>(context, listen: false).fetchTasks(categoryId);

    // Function to add a task
    void _addTask() async {
      if (_taskController.text.isNotEmpty) {
        await Provider.of<TaskProvider>(context, listen: false)
            .addTask(categoryId, _taskController.text.trim());

        // Increment the task count in the CategoryProvider
        Provider.of<CategoryProvider>(context, listen: false)
            .incrementTaskCount(categoryId);

        _taskController.clear(); // Clear the input field after adding a task
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryName,style: TextStyle(fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          return ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (context, index) {
              final task = taskProvider.tasks[index];
              return ListTile(
                title: Text(
                  task.name,
                  style: TextStyle(
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                trailing: Checkbox(
                  value: task.isCompleted,
                  onChanged: (value) {
                    Provider.of<TaskProvider>(context, listen: false)
                        .toggleTaskCompletion(
                      categoryId,
                      task.id,
                      task.isCompleted,
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Add Task'),
                content: TextField(
                  controller: _taskController,
                  decoration: InputDecoration(labelText: 'Task Name'),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _addTask();
                      Navigator.pop(context);
                    },
                    child: Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
