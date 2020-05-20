import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:sihfinal/utils/database_helper.dart';
import 'package:sqflite/sqlite_api.dart';

import 'modules/datamanage.dart';
//import 'package:expandable/expandable.dart';

class HomePage extends StatefulWidget {
  final data;
  final data1;
  HomePage(this.data,this.data1);
  @override
  _HomePageState createState() => _HomePageState(this.data,this.data1);
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
        DatabaseHelper databaseHelper = DatabaseHelper();
  final data;
  final data1;
  _HomePageState(this.data,this.data1);
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
      
        backgroundColor: Colors.grey[800],
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.elliptical(30, 30))),
        title: 
        new Text("PATIENT DETAIL"),
        centerTitle: true,
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Colors.amber,
          tabs: [
            new Tab(icon: new Icon(Icons.account_box)),
            new Tab(icon: new Icon(Icons.check_box)),
            new Tab(
              icon: new Icon(Icons.scanner),
            ),
          ],
          controller: _tabController,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.tab,
        ),
        bottomOpacity: 1,
      ),
      body: TabBarView(
        children: [
          new View(data,data1),
          new Moniter(),
          new Scans(data,data1),
        ],
        controller: _tabController,
      ),
    );
  }
}

class View extends StatefulWidget {
  final data;
  final data1;
  View(this.data,this.data1);
   int iid;
  @override
  _ViewState createState() => _ViewState(this.data,this.data1);
}

class _ViewState extends State<View> {
  _ViewState(this.data,this.data1);
  final data;
  final data1;
  DatabaseHelper databaseHelper = DatabaseHelper();
  int count = 0;
  List<Data> customList;
   
  

  @override
  Widget build(BuildContext context) {
    if (customList == null) {
      customList = List<Data>();
      
      updateListView();
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: count,
            itemBuilder: (BuildContext context, int position) {
              return Container(
               
                height: 400,
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              this.customList[position].name,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              this.customList[position].lname,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          text('AGE:'),
                          SizedBox(
                            width: 10,
                          ),
                          datatext(
                            this.customList[position].age,
                           
                          ),
                           
                        ],
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          text('B-GRP:'),
                          SizedBox(
                            width: 10,
                          ),
                          datatext(
                            this.customList[position].blood,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          text('SEX:'),
                          SizedBox(
                            width: 10,
                          ),
                          datatext(
                            this.customList[position].sex,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          text('DATE:'),
                          SizedBox(
                            width: 10,
                          ),
                          datatext(
                            this.customList[position].date,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          text('DISEASE:'),
                          SizedBox(
                            width: 10,
                          ),
                          datatext(
                            this.customList[position].disease,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          text('Medicine:'),
                          SizedBox(
                            width: 10,
                          ),
                          datatext(
                            this.customList[position].medicine,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
              );
            })
            
            );
  }
List iid;
  updateListView() async{
    iid =  await databaseHelper.fetchCustom(data,data1)  ;
   
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Data>> customListFuture = databaseHelper.getCustomList1(iid[0]['id'].toString());

      customListFuture.then((customList) {
        setState(() {
          this.customList = customList;
          this.count = customList.length;
        });
      });
    });
  }

  datatext(
    data,
  ) {
    return Text(
      ' $data',
      style: TextStyle(
          fontSize: 13,
          fontStyle: FontStyle.normal,
          color: Colors.blueGrey,
          fontWeight: FontWeight.bold),
      textAlign: TextAlign.start,
      textScaleFactor: 1.2,
    );
  }

  text(String title) {
    return Text(
      '$title',
      style: TextStyle(
          color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
    );
  }

  void _sshow() {
    AlertDialog alertDialog = AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.elliptical(30, 30))),
        title: Column(
          children: <Widget>[
            Container(
              width: 500,
              height: 100,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                        bottom: Radius.elliptical(30, 30))),
              ),
            ),
            Container(
              width: 500,
              height: 400,
              child: text('title'),
            )
          ],
        ),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            IconButton(
              alignment: Alignment.bottomRight,
              color: Colors.green,
              icon: Icon(Icons.cancel),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            IconButton(
              autofocus: true,
              color: Colors.red,
              alignment: Alignment.bottomRight,
              icon: Icon(Icons.delete_forever),
              onPressed: () {},
            ),
          ],
        ));

    showDialog(context: context, builder: (_) => alertDialog);
  }
}

class Moniter extends StatefulWidget {
  @override
  _MoniterState createState() => _MoniterState();
}

class _MoniterState extends State<Moniter> {
  Map<String, bool> numbers = {
    'heart rate': false,
    'pulse rate': false,
    'sugar rate': false,
    'Blood Pressure level': false,
    'Fever level': false,
    'Cholestrol level': false,
    'Seven': false,
  };

  var holder_1 = [];

  getItems() {
    numbers.forEach((key, value) {
      if (value == true) {
        holder_1.add(key);
      }
    });

    // Printing all selected items on Terminal screen.
    print(holder_1);
    // Here you will get all your selected Checkbox items.

    // Clear array after use.
    holder_1.clear();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: <Widget>[
      Column(
        children: numbers.keys.map((String key) {
          return new CheckboxListTile(
            title: new Text(key),
            value: numbers[key],
            activeColor: Colors.green,
            checkColor: Colors.red,
            onChanged: (bool value) {
              setState(
                () {
                  numbers[key] = value;
                },
              );
            },
          );
        }).toList(),
      ),
      RaisedButton(
        child: Text(
          " SAVE ",
          style: TextStyle(fontSize: 20),
        ),
        onPressed: getItems,
        color: Colors.grey[800],
        textColor: Colors.white,
        splashColor: Colors.blueAccent,
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      ),
    ]);
  }
}

class Scans extends StatefulWidget {
  Scans(this.data,this.data1);
  final data;
  final data1;
  @override
  
  _ScansState createState() => _ScansState(this.data,this.data1);
}

class _ScansState extends State<Scans> {
   DatabaseHelper databaseHelper = DatabaseHelper();
  int count = 0;
  List<Image1> imageList;


  showImage(int index){
  //  print(object)
    var img = base64Decode(this.imageList[1].image);
   
    var img1 = Image.memory(img);
      print(img1);
    if(img!=null){
      return img1;
    }
  }
   
  _ScansState(this.data,this.data1);
  final data;
  final data1;
  @override
  Widget build(BuildContext context) {
    
     if (imageList == null) {
      imageList = List<Image1>();
       print(imageList);
      updateListView();
    }else{ print(imageList.length);

    }
    return Center(child:  Container(
      color: Colors.grey[300],
     // width: 400,
      child: 
   ListView.builder(
     itemCount: count,
     itemBuilder:
                               (BuildContext context ,int index){
                                 print('jjj');
                                 return Container(
                                   width: 100,
                                  height: 100,
                                   child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0)
                                    ),
                                    child: Text(' ${showImage(index)}' ) ,
                                  
                                 ));
                               
                               },
                            
                             ),
                           ));
                        

                       
      
    
  }
  List iid;
  List uiid;
  updateListView() async{
    iid =  await databaseHelper.fetchCustom(data,data1)  ;
     uiid =  await databaseHelper.fetchImageid(iid[0]['id'].toString())  ;
   
    
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Image1>> customListFuture = databaseHelper.getImageList(uiid[0]['id1'].toString());

      customListFuture.then((imageList) {
        setState(() {
          this.imageList = imageList;
          this.count = imageList.length;
        });
      });
    });
  }
}
