import 'package:flutter/material.dart';
import 'package:get/get.dart';


class UpdateScreen extends StatefulWidget {
  final int id;
  final String title;
  final String textDetails;
  const UpdateScreen({Key? key, required this.id, required this.title, required this.textDetails}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  TextEditingController _idTEController = TextEditingController();
  TextEditingController _titleTEController = TextEditingController();
  TextEditingController _textDetailTEController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _idTEController.text = widget.id.toString();
      _titleTEController.text = widget.title;
      _textDetailTEController.text = widget.textDetails;
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _idTEController,
                decoration: const InputDecoration(
                  labelText: "Id",
                  border: OutlineInputBorder(),
                ),
              ),
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
                controller: _textDetailTEController,
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

                     ElevatedButton(onPressed: () async{

                    }, child: const Text("Update Screen")),

            ],
          ),
        ),
      ),
    );
  }
}
