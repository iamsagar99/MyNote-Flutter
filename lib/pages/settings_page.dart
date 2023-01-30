import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zippy/models/user.dart';
import 'package:zippy/services/database.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  late String bookName;
  late String bookAuthor;
  late String bookDescription;
  late String bookUrl;
  late String thumbUrl;
final firestore = FirebaseFirestore.instance.collection('books');


  // for book file pdf
  FilePickerResult ? result;
  String ? fileName;
  PlatformFile ? pickedFile;
  bool isLoading = false;
  File? fileToDisplay;


  // for book image
  FilePickerResult ? resulttb;
  String ? fileNametb;
  PlatformFile ? pickedFiletb;
  bool isLoadingtb = false;
  File? fileToDisplaytb;



  void pickFile () async{
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

  void pickFiletb() async{
    try{

      setState(() {
        isLoadingtb = true;
      });
      resulttb = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
      );

      if(resulttb!=null){
        fileNametb = resulttb!.files.first.name;
        pickedFiletb = resulttb!.files.first;
        fileToDisplaytb = File(pickedFiletb!.path.toString());

      }
      setState(() {
        isLoadingtb = false;
      });

    } catch(e){
      print(e.toString());
    }
  }

  void uploadFile() async{

            final file = fileToDisplay;
            final metaData = SettableMetadata(contentType: 'application/pdf');
            final  storageRef = FirebaseStorage.instance.ref();
            late int date = DateTime.now().microsecondsSinceEpoch;
            late String dateStr = '';
            if(date!=null){
              dateStr = date.toString();
            }
            Reference ref = storageRef.child('pictures/${fileName! +"-"+dateStr}.pdf');
          final uploadTask = ref.putFile(file!,metaData);

          uploadTask.snapshotEvents.listen((event) {
            switch(event.state){
              case TaskState.running:
                Fluttertoast.showToast(msg: "Uploading");
                break;
              case TaskState.success:
                {
                  Fluttertoast.showToast(msg: "Uploaded Successfully");
                  ref.getDownloadURL().then((value) => bookUrl=value);
                  break;
                }

            }
          });

  }

  void uploadThumb() async{

   try{
     final file = fileToDisplaytb;
     final metaData = SettableMetadata(contentType: 'image/jpeg');
     final  storageRef = FirebaseStorage.instance.ref();
     late int date = DateTime.now().microsecondsSinceEpoch;
     late String dateStr = '';
     if(date!=null){
       dateStr = date.toString();
     }
     Reference ref = storageRef.child('thumbnail/${fileNametb! +"-"+dateStr}.jpeg');
     final uploadTask = ref.putFile(file!,metaData);

     uploadTask.snapshotEvents.listen((event) {
       switch(event.state){
         case TaskState.running:
           Fluttertoast.showToast(msg: "Uploading");
           break;
         case TaskState.success:
           {
             Fluttertoast.showToast(msg: "Uploaded Successfully");
             ref.getDownloadURL().then((value) => thumbUrl=value);
             break;
           }

       }
     });

   }catch(e){
     print(e);
   }
  }

  void uploadData() {
    // await FirebaseFirestore.instance.collection("books").add(
    //   {
    //     'name':fileName,
    //     'author':bookAuthor,
    //     'description': bookDescription,
    //     'bookurl': bookUrl,
    //     'thumbnailurl':thumbUrl,
    //   });
    Map<String,String> dataTosave = {
      'name':bookName,
      'author':bookAuthor,
      'description':bookDescription,
      'bookurl':bookUrl,
      'thumbnailurl':thumbUrl
    };

    String id = DateTime.now().microsecondsSinceEpoch.toString();
    firestore.doc().set({
      'name':bookName,
      'author':bookAuthor,
      'description':bookDescription,
      'bookurl':bookUrl,
      'thumbnailurl':thumbUrl
    }).then((value) => null).onError((error, stackTrace) => null);
   
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: <Widget>[
              Text(
                'Upload Books',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold
                ),
              ),
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
             //for book
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        ElevatedButton(onPressed: (){
                          pickFile();
                        }, child: Text("Upload a Book")),
                        if(pickedFile!=null && fileToDisplay!=null)
                          Icon(Icons.check, color: Colors.green),
                      ],
                    ),
                  ],
                ),
              ),

              // for thumbnail
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: isLoadingtb
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                        onPressed: () {
                          pickFiletb();
                        },
                        child: Text("Upload thumbnail"),
                      ),
                    ),
                    if (pickedFiletb != null && fileToDisplaytb != null)
                      Icon(Icons.check, color: Colors.green),
                  ],
                ),
              ),

              ElevatedButton(
                child: Text('Submit'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print(bookName);
                    print(bookAuthor);
                    print(bookDescription);
                    // Submit the form and perform desired actions
                  }
                  if(fileToDisplay ==  null){
                    Fluttertoast.showToast(msg: "Please select a book");
                    return;
                  }
                  if(fileToDisplaytb == null){
                    Fluttertoast.showToast(msg: "Please select a thumbnail image");
                    return;
                  }

                  try{
                    uploadFile();
                    uploadThumb();
                    if(bookUrl!=null && thumbUrl!=null){
                      uploadData();
                    }
                  }catch(e){
                    print(e);
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
