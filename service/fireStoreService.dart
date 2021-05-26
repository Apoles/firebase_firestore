import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreService{


  FirebaseFirestore _firestore=FirebaseFirestore.instance;

   Stream<QuerySnapshot> getBookFromFireStore(String path){

      return _firestore.collection(path).snapshots();

    }

    Future<void> deleteBook({String referencePath,String id}) async{
    await _firestore.collection(referencePath).doc(id).delete();
    }


}