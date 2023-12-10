import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class UpdateDataController extends GetxController{
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> updatedData({required String documentId,required String title, required String textDetails})async{
    try{
        await _firestore.collection('info_details').doc(documentId).update({
          'title': title,
          'textDetails': textDetails,
        });

        return true;
    }catch(e){
      print('Error updating data: $e');
      return false;
    }

  }
}