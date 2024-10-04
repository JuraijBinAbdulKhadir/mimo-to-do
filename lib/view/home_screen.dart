import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/view/setting_screen.dart';
import 'package:todo_app/view/task_screen.dart';

import '../provider/category_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _categoryController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch categories when the screen is initialized
    Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
  }

  void _addCategory() async {
    if (_categoryController.text.isNotEmpty) {
      try {
        await Provider.of<CategoryProvider>(context, listen: false)
            .addCategory(_categoryController.text.trim());
        _categoryController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add category: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingScreen(),
                  ));
            },
            child: CircleAvatar(
              radius: 10,
              child: Image.asset('assets/images/logo.png'),
            )),
        title: Text(
          'Categories',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.search_rounded))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Material(
                elevation: 10,
                shadowColor: Colors.grey,
                child: Container(
                  color: Colors.white,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Icon(
                        Icons.account_circle,
                        color: Colors.black,
                      ),
                    ),
                    title: Text(
                      "\"The memories is a shield and Life helper.\"",
                      style: TextStyle(
                          color: Colors.black, fontStyle: FontStyle.italic),
                    ),
                    subtitle: Text(
                      'Tamim Al Baghdadi',
                      style: TextStyle(
                          color: Colors.grey, fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              Container(
                height: 700,
                child: Consumer<CategoryProvider>(
                  builder: (context, categoryProvider, child) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Change this value to adjust the number of columns
                        childAspectRatio: 2 / 1, // Adjust the aspect ratio as needed
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: categoryProvider.categories.length + 1, // Adding 1 for the "Add" tile
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          // "Add" category tile
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Add Category'),
                                    content: TextField(
                                      controller: _categoryController,
                                      decoration: InputDecoration(labelText: 'Category Name'),
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
                                          _addCategory();
                                          Navigator.pop(context);
                                        },
                                        child: Text('Add'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Card(
                              elevation: 4,
                              color: Colors.white,
                              child: Center(
                                child:Icon(Icons.add_circle)
                              ),
                            ),
                          );
                        }

                        // Category tiles
                        final category = categoryProvider.categories[index - 1]; // Adjust index for categories
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TasksScreen(
                                  categoryId: category.id,
                                  categoryName: category.name,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            elevation: 4,
                            color: Colors.white,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(category.name, style: TextStyle(fontWeight: FontWeight.bold)),

                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}
