import 'package:cloud_firestore/cloud_firestore.dart';

Future checkIfEmailExists(String docID) async {
  try {
    final doc =
        await FirebaseFirestore.instance.collection('Users').doc(docID).get();
    if (doc.exists) {
      return true;
    } else {
      return false;
    }
  } catch (error) {
    rethrow;
  }
}
