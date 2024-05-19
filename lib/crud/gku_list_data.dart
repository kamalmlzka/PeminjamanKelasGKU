import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/gku_list_data.dart';

final FirebaseFirestore firestore = FirebaseFirestore.instance;

Future<void> addGkuListData(GkuListData data) async {
  await firestore.collection('gku_list').add(data.toMap());
}

Future<List<GkuListData>> getGkuListData() async {
  QuerySnapshot querySnapshot = await firestore.collection('gku_list').get();
  return querySnapshot.docs.map((doc) {
    return GkuListData.fromMap(doc.data() as Map<String, dynamic>);
  }).toList();
}

Future<void> updateGkuListData(String docId, GkuListData data) async {
  await firestore.collection('gku_list').doc(docId).update(data.toMap());
}

Future<void> deleteGkuListData(String docId) async {
  await firestore.collection('gku_list').doc(docId).delete();
}
