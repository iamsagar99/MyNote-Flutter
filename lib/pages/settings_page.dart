import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  late String bookName;
  late String bookAuthor;
  late String bookDescription;

  FilePickerResult ? result;
  String ? fileName;
  PlatformFile ? pickedFile;
  bool isLoading = false;
  File? fileToDisplay;

  void pickFile() async{
    try{

      setState(() {
        isLoading = true;
      });
      result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if(result!=null){
        fileName = result!.files.first.name;
        pickedFile = result!.files.first;
        fileToDisplay = File(pickedFile!.path.toString());

      }
      setState(() {
        isLoading = false;
      });

    } catch(e){
      print(e.toString());
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Upload Books'),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Book Name'),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter book name';
                  }
                  return null;
                },
                onSaved: (value) => bookName = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Book Author'),
                validator: (value) {
                  if (value == null) {
                    return 'Please enter book author';
                  }
                  return null;
                },
                onSaved: (value) => bookAuthor = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Book Description'),
                validator: (value) {
                  if (value==null) {
                    return 'Please enter book description';
                  }
                  return null;
                },
                onSaved: (value) => bookDescription = value!,
              ),
             Container(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Center(
                     child: isLoading
                     ? CircularProgressIndicator()
                     :ElevatedButton(onPressed: (){
                       pickFile();
                     }, child: Text("Upload a Book")),
                   ),
                   if(pickedFile!=null)
                     SizedBox(height: 300,width: 400, child: Image.file(fileToDisplay!)),
                 ],
               ),
             ),
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print(bookName);
                    print(bookAuthor);
                    print(bookDescription);
                    // Submit the form and perform desired actions
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
