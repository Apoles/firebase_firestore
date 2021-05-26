import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_appasdddddddddd/model/bookModel.dart';

import 'package:flutter_appasdddddddddd/service/auth.dart';
import 'package:provider/provider.dart';

import 'book_view_model.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookProvider>(
      create: (_) => BookProvider(),
      builder: (context, child) => Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async {
                  Provider.of<Auth>(context, listen: false).signOut();
                })
          ],
        ),
        body: Center(
            child: Column(
          children: [

            StreamBuilder<List<Book>>(
                stream: Provider.of<BookProvider>(context, listen: false)
                    .getBookList(),
                builder: (context, asyncSnapshot) {
                  if (!asyncSnapshot.hasData) {
                    print(asyncSnapshot.error);
                    return CircularProgressIndicator();
                  } else {
                    List<Book> bookList = asyncSnapshot.data;
                    return BuildListView(bookList: bookList);
                  }
                })
          ],
        )),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            // users.add(addUser); EKLEME YAPIYOR AYRICA İD VE PATH DÖNEBİLİYOR ASYNC OLARAK
            // users.doc('denemeler').set(addUser); EKLEME YAPIYOR AMA OTOMATİK İD YERİNE SET İLE DENEMELER  İD Sİ VERİYOR İD VE PATH DÖNMÜYOR
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class BuildListView extends StatefulWidget {
  const BuildListView({
    Key key,
    @required this.bookList,
  }) : super(key: key);

  final List<Book> bookList;

  @override
  _BuildListViewState createState() => _BuildListViewState();
}

class _BuildListViewState extends State<BuildListView> {
 bool isFiltering=false;
 List<Book> filteredList;



  @override
  Widget build(BuildContext context) {
    var fullList=widget.bookList;
    return Flexible(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (query){
                if(query.isNotEmpty){
                  isFiltering=true;

                  setState(() {
                    filteredList=fullList.where((e) => e.isim.toLowerCase().contains(query.toLowerCase())).toList();//lovercaase herpsini küçük harde sokar
                  });
                }
                else{
                  setState(() {
                    WidgetsBinding.instance.focusManager.primaryFocus.unfocus();//TextField alanını focusunu iptal ediyorp
                    isFiltering=false;
                  });
                }
              },
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Arama',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                  )
              ),

            ),
          ),
          Flexible(
            child: ListView.builder(
                itemCount: isFiltering?filteredList.length :fullList.length,
                itemBuilder: (context, index) {
                  var list =isFiltering?filteredList:fullList;

                  return Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: Slidable(
                      child: Card(
                        child: ListTile(
                          title: Text(
                            list[index].isim,
                          ),
                        ),
                      ),
                      actionPane: SlidableDrawerActionPane(),
                      actions: [
                        IconSlideAction(
                          iconWidget: Icon(Icons.archive),
                          color: Colors.pink,
                        ),
                        IconSlideAction(
                          iconWidget: Icon(
                            Icons.more_vert,
                          ),
                          color: Colors.purple,
                        )
                      ],
                      secondaryActions: [
                        IconSlideAction(
                          iconWidget: Icon(Icons.add),
                          onTap: () {
                            print('basıldı');
                          },
                          color: Colors.blue,
                        ),
                        SlideAction(
                          child: Icon(Icons.delete),
                          onTap: ()  async{
                            print('Basıldı');
                           await Provider.of<BookProvider>(context,listen: false).deleteBook(widget.bookList[index]);
                          },
                          color: Colors.red,
                        ),
                      ],
                      actionExtentRatio: 0.2,
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

/*
             Stream builder ile realData yani eş zamankı data okuma işlemi yapılır data her değiştiğinde
            widget tekrar build edilir

            StreamBuilder<DocumentSnapshot>(

                stream: users.doc('mKNwZeJEtqL2h885rUMJ').snapshots(),
                builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot){

                if(!asyncSnapshot.hasData{
                return(circlerProgressİndicator);})
              return Text('deneme');
            })
            */

/*

FutureBuilder<DocumentSnapshot>(
              future: users.doc('mKNwZeJEtqL2h885rUMJ').get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  print(snapshot.error);

                  return Text("Something went wrong");
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  print('sad');
                  Map<String, dynamic> data = snapshot.data.data();
                  print('=====>$data');
                  return Text("Full Name: ${data['yas']} ");
                }

                return Text("loading");
              },
            ),
 */

/*          DİSSMİSBLE WİDGET ÖRNEĞİ
Dismissible(
                              key: UniqueKey(),
                              confirmDismiss: (_) async {
                                bool value = await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Uyarı!!!!1'),
                                        actions: <Widget>[
                                          TextButton(
                                            child: Text('yes'),
                                            onPressed: () {
                                              Navigator.of(context).pop(true);
                                            },
                                          ),
                                          TextButton(
                                            child: Text('no'),
                                            onPressed: () {
                                              Navigator.of(context).pop(false);
                                            },
                                          ),
                                        ],
                                      );
                                    });
                                if(value==true){
                                  Provider.of<BookProvider>(context,listen: false).deleteBook(bookList[index]);
                                  return value;
                                }
                                else{
                                return value;}



                              },
                              direction: DismissDirection.endToStart,

                              background: Container(
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ),
                                color: Colors.red,
                                alignment: Alignment.centerRight,
                              ),
                              onDismissed: (_) {

                                //userList[index].reference.update({'isim':FieldValue.delete()}); BELLİ BİR ALALNI SİLMEYE YARAR
                              },
                              child: ListTile(
                                title: Text(bookList[index].isim),
                              ),
                            );



*/
