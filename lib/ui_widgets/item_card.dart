

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controller/firebase_controller.dart';
import '../my_theme.dart';
import '../pages/edit.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ItemCard extends StatelessWidget{

  const ItemCard({Key? key, required this.currentItem, required this.document, required this.manage}) : super(key: key);

  final Map currentItem;
  final QueryDocumentSnapshot<Object?> document;
  final bool manage;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => EditItem(currentItem)),);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: MyTheme.light_grey, width: 0.0),
          borderRadius: BorderRadius.circular(16.0),
        ),


            child: ClipRRect(
                clipBehavior: Clip.hardEdge,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                    bottom: Radius.circular(16)),
                child:  Stack(

                  children: [

                    FadeInImage.assetNetwork(
                      height: double.infinity,
                      width: double.infinity,
                      imageErrorBuilder:
                          (context, error, stackTrace) {
                        return Image.asset('assets/placeholder.png',
                          fit: BoxFit.fill,);
                      },
                      placeholder: 'assets/placeholder.png',
                      image: '${currentItem['image']}',
                      fit: BoxFit.cover,
                    ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 30,
                    child: ElevatedButton(
                      onPressed: () async {
                        _launchCaller();
                      },
                      child: const Center(
                        child: Text('Call & Enquire'),
                      )),
                  ),
                ),
                    manage ? IconButton(
                      icon: const Icon(Icons.delete, size: 30, color: MyTheme.red,),
                      onPressed: (){
                        showDialog(context: context, builder: (_) =>

                        AlertDialog(
                          title: Text(AppLocalizations.of(context)!.areYouSure),
                          actions: [
                            TextButton(
                              child: Text(AppLocalizations.of(context)!.yesDelete),
                              onPressed: () {
                                FirebaseController().delete(currentItem['path'], document.id);
                                Navigator.of(context).pop();

                              },
                            ),
                            TextButton(
                              child: Text(AppLocalizations.of(context)!.noDontDelete),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        ));
                      },
                    ): Container(),
                  ],
                )
            ),


      ),
    );
  }

  _launchCaller() async {
    const url = "tel:0501847418";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  
}