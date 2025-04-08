import 'package:cloud_firestore/cloud_firestore.dart';
import 'model/request_model.dart';


class RequestRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<RequestModel>> getRequestsByStatus(String status) async {
    try {
      final querySnapshot = await _firestore
          .collection('Requests')
          .where('status', isEqualTo: status)
          .get();

      List<RequestModel> requests = querySnapshot.docs.map((doc) {
        return RequestModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();

      return requests;
    } catch (e) {
      print("Error fetching requests with status $status: $e");
      return [];
    }
  }


  Future<List<RequestModel>> getRequests() async {
    try {
      final querySnapshot = await _firestore.collection('Requests').get();

      List<RequestModel> requests = querySnapshot.docs.map((doc) {
        return RequestModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      print(requests);
      return requests;

    } catch (e) {
      print("Error fetching requests: $e");
      return [];
    }
  }

  Future<void> fetchUserDetails(DocumentReference userRef) async {
    try {
      DocumentSnapshot userSnapshot = await userRef.get();
      if (userSnapshot.exists) {
        Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
        print("User Data: $userData");
      }
    } catch (e) {
      print("Error fetching user details: $e");
    }
  }

  Future<void> updateRequestStatus(String requestId, String newStatus) async {
    try {
      await _firestore.collection('Requests').doc(requestId).update({
        'status': newStatus,
      });
      print("Request status updated successfully.");
    } catch (e) {
      print("Error updating request status: $e");
    }
  }


}
