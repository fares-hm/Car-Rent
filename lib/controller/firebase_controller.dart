

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:photo_app/controller/shared_value.dart';

import '../app_config.dart';

class FirebaseController{

  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  UploadTask? uploadTask;

  Future uploadFile(PlatformFile? filePicked, String userName, String year, String price) async {

    String uniqueFileName =

    DateTime.now().millisecondsSinceEpoch.toString();

    final path = '${AppConfig.folder_name}$uniqueFileName';

    final file = File(filePicked!.path!);

    final ref = FirebaseStorage.instance.ref().child(path);

    uploadTask = ref.putFile(file);

    final uploadProgress = await uploadTask!.whenComplete(() {});

    final urlDownload = await uploadProgress.ref.getDownloadURL();
    CollectionReference _reference =
    FirebaseFirestore.instance.collection(AppConfig.collection_name);

    Map<String, String> dataToSend = {
      'name': userName,
      'year': year,
      'price': price,
      'image': urlDownload,
      'path': path,
      'date': DateTime.now().toString()
    };
    _reference.add(dataToSend);

    //print(urlDownload);
    uploadTask = null;

  }


  Future updateFile(Map itemToEdit,PlatformFile? filePicked) async {

    final DocumentReference _reference =
    FirebaseFirestore.instance.collection(AppConfig.collection_name).doc(itemToEdit['id']);


    final file = File(filePicked!.path!);

    final ref = FirebaseStorage.instance.refFromURL(itemToEdit['image']);

    uploadTask = ref.putFile(file);

    final uploadProgress = await uploadTask!.whenComplete(() {});

    final urlDownload = await uploadProgress.ref.getDownloadURL();


    Map<String, String> dataToUpdate = {
      'name': itemToEdit['name'],
      'year': itemToEdit['year'],
      'price': itemToEdit['price'],
      'image': urlDownload,
      'date': DateTime.now().toString()
    };
    _reference.update(dataToUpdate);

    //print(urlDownload);
    uploadTask = null;


  }

  Future<List<Map<String, dynamic>>> loadImages() async {
  List<Map<String, dynamic>> files = [];

  final ListResult result = await _firebaseStorage.ref('/files').list();
  final List<Reference> allFiles = result.items;

  await Future.forEach<Reference>(allFiles, (file) async {
    final String fileUrl = await file.getDownloadURL();
    final FullMetadata fileMeta = await file.getMetadata();
    files.add({
      "url": fileUrl,
      "path": file.fullPath,
      "name": file.name ?? '',
      "body": fileMeta.customMetadata?['name'] ?? '',
      "description":
      fileMeta.customMetadata?['description'] ?? ''
    });
  });

  return files;
}

// Delete the selected image
// This function is called when a trash icon is pressed
Future<void> delete(String path,String id) async {
  await _firebaseStorage.ref(path).delete();
  await FirebaseFirestore.instance.collection(AppConfig.collection_name).doc(id).delete().then((_) => print('Deleted'))
      .catchError((error) => print('Delete failed: $error'));
  // Rebuild the UI
  //setState(() {});
}
}