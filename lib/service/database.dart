import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addStudentDetails(
      Map<String, dynamic> studentInfoMap, String id) async {
    FirebaseFirestore.instance
        .collection("Student")
        .doc(id)
        .set(studentInfoMap);
  }

//to get the data from the firestore
  Future<Stream<QuerySnapshot>> getStudentDetails() async {
    return await FirebaseFirestore.instance.collection("Student").snapshots();
  }

  //to update
  Future updateStudentDetail(String id, Map<String, dynamic> updateInfo) async {
    return await FirebaseFirestore.instance
        .collection("Student")
        .doc(id)
        .update(updateInfo);
  }

  //to delete
  Future deleteStudentDetail(String id) async {
    return await FirebaseFirestore.instance
        .collection("Student")
        .doc(id)
        .delete();
  }
}
