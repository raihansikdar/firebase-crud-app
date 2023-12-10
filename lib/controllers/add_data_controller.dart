import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class AddDataController extends GetxController{
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool> addData({required String title, required String textDetails})async{
    try{
       await _firestore.collection('info_details').add({
         'title': title,
         'textDetails': textDetails,
       });
      return true;
    }catch(e){
      print('Error adding data: $e');
      return false;
    }

  }
}