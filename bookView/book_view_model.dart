


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appasdddddddddd/model/bookModel.dart';

import 'package:flutter_appasdddddddddd/service/fireStoreService.dart';
import 'package:provider/provider.dart';

class BookProvider extends ChangeNotifier{

  FireStoreService _fireStoreService=FireStoreService();

  Stream<List<Book>> getBookList(){
    const String booksRef='books';
    Stream<List<QueryDocumentSnapshot>> documantList=_fireStoreService.getBookFromFireStore('books').map((e) => e.docs);
    
    Stream<List<Book>> bookList=documantList.map((e) => e.map((e) => Book.fromMap(e.data())).toList());

    return bookList;


  }

  Future<void> deleteBook(Book book)async{
const String booksRef='books';
await _fireStoreService.deleteBook(referencePath: booksRef,id:book.id);
  }




}