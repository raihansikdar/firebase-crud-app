import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UpdateDataController extends GetxController{
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> updatedData({required int id,required String title, required String textDetails})async{
    try{

      QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('info_details')
          .where('id', isEqualTo: id)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String documentId = querySnapshot.docs.first.id;
        print("object============> $documentId");

        await _firestore.collection('info_details').doc(documentId).update({
          'id': id,
          'title': title,
          'textDetails': textDetails,
        });

        return true;
      }else{
        return false;
      }
    }catch(e){
      print('Error updating data: $e');
      return false;
    }

  }
}