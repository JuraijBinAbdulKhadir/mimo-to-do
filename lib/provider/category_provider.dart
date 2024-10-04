

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryProvider extends ChangeNotifier{
  final FirebaseFirestore _db=FirebaseFirestore.instance;

  List<Category> _categories=[];
  List<Category> get  categories=>_categories;


  // Add your addTask method here

  Future fetchCategories()async{
    try{
      QuerySnapshot snapshot = await _db.collection('categories').get();

      _categories = await snapshot.docs.map((doc) {
        return Category(
            name: doc['name'], id: doc.id, taskCount: doc['taskCount']);
      }).toList();
      notifyListeners();
    }catch(e){
      throw e;
    }
  }

  Future addCategory(String name)async{
    try{
      DocumentReference documentReference =
          await _db.collection('categories').add({
        'name': name,
        'taskCount': 0,
      });
      _categories.add(Category(name: name, id: documentReference.id, taskCount: 0));
      notifyListeners();
    }catch(e){
      throw e;
    }
  }
  void incrementTaskCount(String categoryId) {
    int index = _categories.indexWhere((cat) => cat.id == categoryId);
    if (index != -1) {
      _categories[index].taskCount += 1; // Increment task count
      notifyListeners(); // Notify listeners to update UI
    }
  }
  void updateTaskCount(String categoryId, int count) {
    final category = _categories.firstWhere((cat) => cat.id == categoryId);
    category.taskCount = count; // Set the task count to the fetched number
    notifyListeners();
  }


}
class Category {
  final String id;
  final String name;
   late final int taskCount;

  Category({required this.name,required this.id, required this.taskCount});
}