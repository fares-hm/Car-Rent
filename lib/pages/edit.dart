import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:photo_app/controller/firebase_controller.dart';
import 'package:photo_app/pages/home.dart';
import 'package:photo_app/pages/manage-items.dart';
import 'package:photo_app/ui_widgets/drawer.dart';
import 'package:photo_app/ui_widgets/my_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../controller/auth.dart';
import '../controller/shared_value.dart';

class EditItem extends StatefulWidget {
  EditItem(
    this.itemToEdit, {
    Key? key,
  }) : super(key: key);

  final Map itemToEdit;

  @override
  State<EditItem> createState() => _EditItemState();
}

class _EditItemState extends State<EditItem> {
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerYear = TextEditingController();
  TextEditingController _controllerPrice = TextEditingController();


  @override
  void initState() {
    super.initState();
    _controllerName = TextEditingController(text: widget.itemToEdit['name']);
    _controllerName = TextEditingController(text: widget.itemToEdit['year']);
    _controllerName = TextEditingController(text: widget.itemToEdit['price']);

  }

  User? get currentUser => Auth().currentUser;

  Future<void> signOut() async {
    await Auth().signOut();
  }

  PlatformFile? filePicked;
  UploadTask? uploadTask;
  String resultMessage = "";

  Future selectImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['jpg', 'jpeg', 'png'],
    );
    if (result == null) return;
    setState(() {
      filePicked = result.files.first;
      resultMessage = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: MyAppBar(title: AppLocalizations.of(context)!.editFile),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      selectImage();
                    },
                    child: Text(
                      AppLocalizations.of(context)!.pickImage
                    ),
                  ),
                ),
                Form(
                    child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: TextField(
                        controller: _controllerName,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.name,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: TextField(
                        controller: _controllerYear,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.year,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextField(
                        controller: _controllerPrice,
                        decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)!.price,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          if (filePicked?.path != null) {
                            if (_controllerName.text != "" && _controllerYear.text != "" && _controllerPrice.text != "") {
                              setState(() {
                                resultMessage = AppLocalizations.of(context)!.uploading;
                              });
                              widget.itemToEdit['name'] = _controllerName.text; widget.itemToEdit['year'] = _controllerYear.text; widget.itemToEdit['price'] = _controllerPrice.text;
                              FirebaseController()
                                  .updateFile(widget.itemToEdit, filePicked)
                                  .then((value) {
                                setState(() {
                                  resultMessage = AppLocalizations.of(context)!.dataUpdated;
                                  filePicked = null;
                                  _controllerName.text = "";
                                });
                              });
                            } else {
                              var snackBar = SnackBar(
                                  content: Text(AppLocalizations.of(context)!
                                      .selectDataFirst));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          } else {
                            var snackBar = SnackBar(
                                content: Text(AppLocalizations.of(context)!
                                    .selectFileFirst));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar);
                          }
                        },
                        child: Text(
                          AppLocalizations.of(context)!.update,
                        ),
                      ),
                    ),
                  ],
                )),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return const MyHomePage();
                      }),ModalRoute.withName('/'),);
                    },
                    child: Text(
                      AppLocalizations.of(context)!.list,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    resultMessage,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
