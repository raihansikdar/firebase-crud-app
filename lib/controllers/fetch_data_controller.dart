/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase_app/model/data_list_model.dart';
import 'package:get/get.dart';

class FetchDataController extends GetxController{
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  List<DataListModel> _datalist = <DataListModel>[].obs;
  List<DataListModel> get datalist => _datalist;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;


  Future<bool>getData()async{
    try {
      final QuerySnapshot response = await _firestore.collection('info_details').get();

      if(response.docs.isNotEmpty){
        _datalist.assignAll(response.docs.map((e) => DataListModel.fromJson(e.data() as Map<String,dynamic>)).toList());


       for(var data in _datalist){
         print('ID: ${data.id}, Title: ${data.title}, Details: ${data.textDetails}');
       }
        // _datalist.forEach((data) {
        //   print('ID: ${data.id}, Title: ${data.title}, Details: ${data.textDetails}');
        // });
        update();
        return true;
      }else{
        update();
        return false;
      }

    } catch (e) {
      print('===============>Error fetching tasks: $e');
      return false;
    }
  }
}
*/


/*
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase_app/model/data_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FetchDataController extends GetxController {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<DataListModel>> fetchData() {
    return _firestore
        .collection('info_details')
        .snapshots()
        .map((QuerySnapshot snapshot) {
      List<DataListModel> dataList = snapshot.docs
          .map((e) => DataListModel.fromJson(e.data() as Map<String, dynamic>))
          .toList();
      return dataList;
    });
  }
}
*/


import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_firebase_app/model/data_list_model.dart';
import 'package:get/get.dart';

class FetchDataController extends GetxController {
  RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  List<DataListModel> _datalist = <DataListModel>[].obs;
  List<DataListModel> get datalist => _datalist;
   List myIdList = [];

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StreamSubscription<QuerySnapshot>? _subscription;

  String documentId = '';
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onClose() {
    _subscription?.cancel();
    super.onClose();
  }

  void getData() {
    _isLoading.value = true;

    _subscription = _firestore.collection('info_details').snapshots().listen((QuerySnapshot snapshot) {

      if (snapshot.docs.isNotEmpty) {
        _datalist.clear();
        _datalist.assignAll(snapshot.docs.map((e) {

          return  DataListModel.fromJson(e.data() as Map<String, dynamic>,id: e.id,);
        }).toList());

         print("===================================================>");
         for (var data in _datalist) {
          print('ID: ${data.id}, Title: ${data.title}, Details: ${data.textDetails}');
        }
        print("===================================================>");
      }
      _isLoading.value = false;
    });
  }

  void deleteData({required documentId})async{
    try{
      _isLoading.value = true;
    /*  QuerySnapshot<Map<String, dynamic>> querySnapshot = await FirebaseFirestore.instance
          .collection('info_details')
          .where('id', isEqualTo: id)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String documentId = querySnapshot.docs.first.id;
        print("Delete id ============> $documentId");
        _isLoading.value = false;
        await _firestore.collection('info_details').doc(documentId).delete();
        _datalist.removeWhere((element) => element.id == id);
      }*/



      await _firestore.collection('info_details').doc(documentId).delete();
      _isLoading.value = false;
      _datalist.removeWhere((element) => element.id == documentId);
    }catch(e){
      print('Error deleting document: $e');
    }
  }
  Future<void> deleteAllData() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('info_details').get();
      querySnapshot.docs.forEach((document) {
        document.reference.delete();
      });
      _datalist.clear();
    } catch (e) {
      print('Error deleting all documents: $e');
    }
  }
}


