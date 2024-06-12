import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_service.dart';

class ChatService {
  Future getListChat() async {
    try {
      var data = await FirebaseFirestore.instance
          .collection('Rooms')
          .where('userIds', arrayContains: UserService().currentUser!.uid)
          .get();
      print('list chat : ${data.docs.length}');
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}
