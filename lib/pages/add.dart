import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:photo_app/controller/firebase_controller.dart';
import 'package:photo_app/pages/manage-items.dart';
import 'package:photo_app/ui_widgets/drawer.dart';
import 'package:photo_app/ui_widgets/my_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../controller/auth.dart';
import '../controller/shared_value.dart';
import 'home.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key,this.filePathToEdit=''}) : super(key: key);

  final String filePathToEdit;

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {

  GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerYear = TextEditingController();
  final TextEditingController _controllerPrice = TextEditingController();

  PlatformFile? filePicked;
  String fileName = "Pick an image";
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
      fileName = result.files.first.name;
      resultMessage = "";
    });
  }



  @override
  Widget build(BuildContext context) {
    //print("User.email: ${user_email.$}");
    return Scaffold(
      drawer: MyDrawer(),
      appBar: MyAppBar(title: AppLocalizations.of(context)!.addItem),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(right: 20, left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                widget.filePathToEdit != '' ? Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: Text(
                    AppLocalizations.of(context)!.editFile,
                  ),
                ):Container(),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      selectImage();
                    },
                    child: Text(
                      fileName,
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
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
                                FirebaseController().uploadFile(filePicked, _controllerName.text,_controllerYear.text,_controllerPrice.text).then((value) {
                                  setState(() {
                                    resultMessage =
                                        AppLocalizations.of(context)!.dataUploaded;
                                    filePicked = null;
                                    fileName = AppLocalizations.of(context)!.pickImage;
                                    _controllerName.text = _controllerYear.text = _controllerPrice.text= "";
                                  });
                                });

                              }
                              else
                              {
                                var snackBar = SnackBar(content: Text(AppLocalizations.of(context)!.selectDataFirst));
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                            } else {
                              var snackBar = SnackBar(content: Text(AppLocalizations.of(context)!.selectFileFirst));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }
                          },
                          child: Text(
                            AppLocalizations.of(context)!.submit,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return const MyHomePage();
                          }));
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
