import 'package:crud_firebase_app/controllers/fetch_data_controller.dart';
import 'package:crud_firebase_app/model/data_list_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class DataListScreen extends StatefulWidget {
  const DataListScreen({Key? key}) : super(key: key);

  @override
  State<DataListScreen> createState() => _DataListScreenState();
}

class _DataListScreenState extends State<DataListScreen> {
  final FetchDataController _fetchDataController = Get.put(FetchDataController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _fetchDataController.getData();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Data List"),
        actions: [
          IconButton(onPressed: () async{


          }, icon: const Icon(Icons.delete))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child:Obx(() {
            if (_fetchDataController.isLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (_fetchDataController.datalist.isEmpty) {
              return Center(child: Text('No data available.'));
            } else {
              return ListView.builder(
                itemCount: _fetchDataController.datalist.length,
                itemBuilder: (context, index) {
                  DataListModel data = _fetchDataController.datalist[index];
                  return ListTile(
                    title: Text('ID: ${data.id}'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Title: ${data.title}'),
                        Text('Details: ${data.textDetails}'),
                        // Add other details as needed
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),

     /*   StreamBuilder<List<DataListModel>>(
          stream: _fetchDataController.fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No data available.'));
            } else {
              List<DataListModel> dataList = snapshot.data!;
              return ListView.builder(
                itemCount: dataList.length,
                itemBuilder: (context, index) {
                  DataListModel data = dataList[index];
                  return ListTile(
                    title: Text(data.title ?? ''),
                    subtitle: Text(data.textDetails ?? ''),
                    // Add other widgets as needed
                  );
                },
              );
            }
          },
        ),*/

        /*GetBuilder<FetchDataController>(
            builder: (_fetchDataController){
          return ListView.separated(
            itemCount: _fetchDataController.datalist.length,
            itemBuilder: (context,index){
              print(_fetchDataController.datalist.length);
              return Card(
                child: ListTile(
                  leading: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        _fetchDataController.datalist[index].id.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  title: Text(_fetchDataController.datalist[index].title ?? ''),
                  subtitle: Text(_fetchDataController.datalist[index].textDetails ?? ''),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(onPressed: (){
                          //Get.to(()=> UpdateScreen();
                        }, icon: const Icon(Icons.edit),),
                        const Spacer(),
                        IconButton(onPressed: (){
                          // Get.find<FetchDataController>().deleteData(id: _fetchDataController.dataList[index].id!);
                          // Get.find<FetchDataController>().fetchData();
                          Get.snackbar("Successful", "Data has been delete");
                        }, icon: const Icon(Icons.delete),)
                      ],
                    ),
                  ),
                ),
              );
            }, separatorBuilder: (context,index)=> const SizedBox(height: 10,), );
        })*/

        ),

    );
  }
}
