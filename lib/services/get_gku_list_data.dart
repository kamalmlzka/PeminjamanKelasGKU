import 'package:cloud_firestore/cloud_firestore.dart';
import '/models/gku_list_data.dart';

class GetGKUListData {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  DocumentSnapshot? lastDocument;

  Future<List<GkuListData>> fetchGkuListData(int page, int itemsPerPage) async {
    Query query = _db
        .collection('gku_list')
        .orderBy('titleTxt') // Adjust the order by field as necessary
        .limit(itemsPerPage);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument!);
    }

    QuerySnapshot querySnapshot = await query.get();

    if (querySnapshot.docs.isNotEmpty) {
      lastDocument = querySnapshot.docs.last;
    }

    return querySnapshot.docs.map((doc) {
      return GkuListData.fromMap(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
