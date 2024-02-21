import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:photo_app/helpers/screen_sizes.dart';
import 'package:photo_app/ui_widgets/drawer.dart';
import 'package:photo_app/ui_widgets/item_card.dart';
import 'package:photo_app/ui_widgets/my_app_bar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../app_config.dart';

class ManageItems extends StatefulWidget {
  const ManageItems({Key? key}) : super(key: key);

  @override
  State<ManageItems> createState() => _ManageItemsState();
}

class _ManageItemsState extends State<ManageItems> {
  late Future<ListResult> futureFiles;

  late CollectionReference _reference;

  late  Stream<QuerySnapshot> _stream;

  late ScrollController _scrollController;


  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _reference =
        FirebaseFirestore.instance.collection(AppConfig.collection_name);
      _stream = _reference.orderBy('date',descending: true).snapshots();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: MyAppBar(
        title: AppLocalizations.of(context)!.list,
      ),
      drawer: MyDrawer(),
      body: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                0.0,
                0.0,
                0.0,
                0.0,
              ),
              child:  StreamBuilder<QuerySnapshot>(
                stream: _stream,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text('Some error occurred ${snapshot.error}'));
                  }
                  if (snapshot.hasData) {
                    QuerySnapshot querySnapshot = snapshot.data;
                    List<QueryDocumentSnapshot> documents = querySnapshot.docs;
                    //Convert the documents to Maps
                    List<Map> items = documents.map((e) => e.data() as Map).toList();

                    return SizedBox(
                      height: ScreenSizeT(context).height,
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.8),
                        padding: const EdgeInsets.all(16),
                        physics: const ScrollPhysics(),
                        itemCount: items.length,
                        itemBuilder: (BuildContext context, int index) {
                          Map thisItem = items[index];

                          return ItemCard(currentItem: thisItem, document: documents[index], manage: true,);
                        },),
                    );
                  }

                  //Show loader
                  return const Center(heightFactor: 20, child: CircularProgressIndicator());
                },
              ),
            ),
          )

        ],
      ), //Display a list // Add a FutureBuilder
    );
  }
}
