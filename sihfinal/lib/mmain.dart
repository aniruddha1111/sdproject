import 'package:sihfinal/add.dart';
import 'package:sihfinal/utils/database_helper.dart';
import 'package:sihfinal/view.dart';
import 'package:sqflite/sqlite_api.dart';

import 'modules/datamanage.dart';

import 'package:flutter/material.dart';


class CustomList extends StatefulWidget {
  //final name;
  CustomList();

  @override
  _CustomListState createState() => _CustomListState();
}

class _CustomListState extends State<CustomList> {
   DatabaseHelper databaseHelper = DatabaseHelper();
 
  TextEditingController style = TextEditingController();

  String name;
  _CustomListState();

  

  int count = 0;
   List<Data> customList;

  


  @override
  Widget build(BuildContext context) {

    if (customList == null) {
      customList = List<Data>();
      updateListView('');
    }

    

    return 
   
   Scaffold(
appBar: AppBar(
  title:  TextFormField(
              style: TextStyle(color: Colors.white),
              textInputAction: TextInputAction.go,
              controller: style,
              onChanged: (value) {
                updateListView(style.text);
                //sshow();
              },
              decoration: InputDecoration(
                
                
                hintStyle: TextStyle(color: Colors.white),
                border: InputBorder.none,
                suffix: Text(
                  '$count',
                  style: TextStyle(color: Colors.white),
                ),
                
                hintText: 'Name/Phone',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
              ),
            ),
),
             backgroundColor: Colors.white,
            
            floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed: () {
               
        navigate(
                Data('', '', '', '','','','',''),
                'NEW',
              );

             
            },
            tooltip: 'New Customer',
            child: Icon(
              Icons.people,
              color: Colors.white,
              size: 30,
            ),
          ),

        
            
            body: Padding(
      padding: EdgeInsets.only(top: 50),
  child:
            
              ListView.builder( 
                               padding: EdgeInsets.zero, 
                               itemCount: count,
                                itemBuilder:
                                (BuildContext context, int position) {

                                return  ListTile(
                                  onTap: (){
                                   Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage(customList[position].name,customList[position].lname)));
                                  //navigate2(this.customList[position]);
                                  },
                                  title: text(this.customList[position].name,),
                                  subtitle: Row(mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                 
                                    
                                    
                                    
                                    text('DATE:'),
                                    SizedBox(width: 10,),
                                    datatext(customList[position].date,),
                                  ],),
                                  leading: CircleAvatar(
                                    child: Icon(Icons.account_circle),
                                    maxRadius: 30,
                                  ),

                                ); 
                                }
                                )) ,
         
    
             

        
   


   );
    
      
    
         
       
                            
                              
          
          
          
      
  }  


  


   datatext(data,) {
    return Text(
      ' $data',
      style: TextStyle(
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


  updateListView(String name) {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Data>> customListFuture = databaseHelper.getCustomList(name);

      customListFuture.then((customList) {
        setState(() {
          this.customList = customList;
          this.count = customList.length;
        });
      });
    });
  }  

 

  navigator1(Data data, data1) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage(data,data1)));
  }

  

 
   navigate(
    Data data,
    String title,
  ) async {
    String result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => MyCustomForm(data)));
      return result ;
   //updateListView(result);
  }

  

  
  
} 
