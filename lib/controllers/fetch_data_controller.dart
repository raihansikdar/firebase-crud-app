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


  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  StreamSubscription<QuerySnapshot>? _subscription;

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
        _isLoading.value = false;
        _datalist.assignAll(snapshot.docs.map((e) => DataListModel.fromJson(e.data() as Map<String, dynamic>)).toList());

        for (var data in _datalist) {
          print('ID: ${data.id}, Title: ${data.title}, Details: ${data.textDetails}');
        }

      }
    });
  }
}


