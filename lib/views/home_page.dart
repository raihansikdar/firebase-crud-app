import 'package:crud_firebase_app/controllers/add_data_controller.dart';
import 'package:crud_firebase_app/views/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _idTEController = TextEditingController();
  TextEditingController _titleTEController = TextEditingController();
  TextEditingController _textDetailsTEController = TextEditingController();

  AddDataController _addDataController = Get.put(AddDataController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child:  Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _titleTEController,
                decoration: const InputDecoration(
                  labelText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _textDetailsTEController,
                maxLines: 5,
                decoration: const InputDecoration(
                    labelText: "Text Details",
                    alignLabelWithHint: true,
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 16.0,
                      horizontal: 12.0,
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                     onPressed: () async{
                       await _addDataController.addData( title: _titleTEController.text.trim(), textDetails: _textDetailsTEController.text.trim()).then((value) {
                         _titleTEController.clear();
                         _textDetailsTEController.clear();
                         Get.snackbar("Successful", "Data has been added in database");
                       });

                     }, child: const Text("Add Data")),

                  const SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(onPressed: () {
                    Get.to(()=>const DataListScreen());
                  }, child: const Text("See Data"))
                ],
              )
            ],
          )
        ),
      ),
    );
  }
}
