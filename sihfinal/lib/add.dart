import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sihfinal/ImageAsset.dart';


import 'package:sihfinal/utils/database_helper.dart';

import 'modules/datamanage.dart';

class MyCustomForm extends StatefulWidget {
  final add;
 

void fetch(){

}
   
  @override
  MyCustomForm(this.add);
  MyCustomFormState createState() {
    return MyCustomFormState(this.add);
  }
}


class MyCustomFormState extends State<MyCustomForm> {
  
  DatabaseHelper helper = DatabaseHelper();
  final add;
  MyCustomFormState(this.add);
  String lastName="";
  String firstName="";
  String age='';
  String sex="";


  int _radioValue1 = 0;
  String _dropDownVal='A+';
  final _formKey = GlobalKey<FormState>();

  selectRadio(int val){
    setState(() {
    _radioValue1 = val;
    if(_radioValue1==1){
     add.sex = "Male";
    }else{
      add.sex="Female";
    }
    });
  }

  String disease="";
  String medicine="";
 List<Image> customList;

  @override
  Widget build(BuildContext context) {
     if (customList == null) {
      customList = List<Image>();
     
    }
  
    
    return  Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: ()async{
          
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => ImageAsset(res[0]['id'], Image1('',''))));
          
             
          },
      
        backgroundColor: Colors.grey[800],
      ),
      appBar: app(context),

    body:
  
    
     ListView(children: <Widget>[ Card( 
        shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.elliptical(30, 30))),
      child: Container(
        padding: EdgeInsets.only(
          top: 20.0,
          left: 25.0,
          right: 40.0
        ),
        child: Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          TextFormField(
            decoration: InputDecoration(
              labelText: "Last Name",
              //labelStyle: TextStyle(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide()
              )
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter the Last Name';
              }
              return null;
            },
            onSaved: (value){
              add.lname = value;
              lnav= value;
           
              
            },
          ),
          SizedBox(height: 25.0,),
          TextFormField(
            decoration: InputDecoration(
              labelText: "First Name",
              //labelStyle: TextStyle(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide()
              )
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter the Name';
              }
              return null;
            },
            onSaved: (value){
              add.name = value;
              nave =  value;
              
            },
          ),
           SizedBox(height: 25.0,),
          TextFormField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: "Age",
              //labelStyle: TextStyle(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide()
              )
            ),
            validator: (value) {
              if (value.isEmpty || int.parse(value) < 0 || int.parse(value) > 150) {
                return 'Please Enter the Age Correctly';
                
              }
              return null;
            },
            onSaved: (value){
             add.age  = value;
             
            },
          ),
           SizedBox(height: 25.0,),
        Row(
          children: <Widget>[
        
        Text("Blood Group: ",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        SizedBox(width: 25.0,),
        DropdownButton<String>(
          value: _dropDownVal,
          items: <String>['A+','A-', 'B+', 'B-', 'AB+','AB-','O+','O-'].map((String value) {
            return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          
          );
        }).toList(),
         onChanged: (val) {
           setState(() {
             _dropDownVal = val;
             add.blood = val;
             
           });
         },
        ),
        ],),
          

   
         SizedBox(height: 25.0,),
          Row(children: <Widget>[
                  Text("Sex:", 
                  style: TextStyle(
                    fontWeight: FontWeight.bold
                  ),),
                    Radio(
                          value: 1,
                        groupValue: _radioValue1,
                        onChanged: (val) {
                          selectRadio(val);
                          }
                        ),
                         Text(
                          'Male',
                          style: TextStyle(
                            fontSize: 16.0,
                            //fontWeight: FontWeight.bold
                            ),

                        ),
                         Radio(
                          value: 2,
                          groupValue: _radioValue1,
                          onChanged: (val) {selectRadio(val);}
                        ),
                        Text(
                          'Female',
                          style: new TextStyle(
                            fontSize: 16.0,
                            //fontWeight: FontWeight.bold
                          ),
                      )
          ],),
          
          SizedBox(height: 30.0),

          SizedBox(height: 40.0,),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Disease ",
                //labelStyle: TextStyle(),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide()
                )
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter the Disease Name';
              }
              return null;
            },
            onSaved: (value){
              add.disease = value;
              dnav= value;


            },
          ),
          SizedBox(height: 30.0),

          SizedBox(height: 40.0,),
          TextFormField(
            decoration: InputDecoration(
                labelText: "medicine ",
                //labelStyle: TextStyle(),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide()
                )
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please Enter the medicine Name';
              }
              return null;
            },
            onSaved: (value){
              add.medicine = value;
              mnav= value;


            },
          ),
          RaisedButton(
            color: Colors.grey[800],
            child: Text('SAVE',style: TextStyle(color: Colors.white),),
            onPressed: (){
            
              
              if(_formKey.currentState.validate()){
                _formKey.currentState.save();
                ad();
                _save();

            }

            },
          )
            
       
          


        

                    
        ]
     )
    )
      )
    )]));
  }
var res;
  void _save() async {
    int result;
     
      add.date = DateFormat.yMMMd().format(DateTime.now());
      result = await helper.insertCustom(add);
     
    if (result != 0) {
         
               
     
    
      _show('Status', 'PATIENT Saved Successfully');
      res =  await helper.fetchCustom(nave,lnav)  ;
       
     
    } else {
      _show('Status', 'Problem Saving PATEINT');
    }
   
  }
  String nave;
   String lnav;
    String dnav;
    String mnav;
  void ad(){

  Map<String,String> data = <String,String>{
      "Name": nave,
      "Lname": lnav,
  };

}

  void _show(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }

app(context){

  return PreferredSize(
    preferredSize: Size.fromHeight(50),
    child: Container(
      
    
      decoration: BoxDecoration(
      boxShadow:[ BoxShadow(
            color: Colors.redAccent,
            blurRadius: 100,
            spreadRadius: 5,
            
      )],
      
        
            gradient: LinearGradient(
              begin: Alignment.centerLeft,

              end: Alignment.centerRight,
              colors: [
                Colors.tealAccent,
                Colors.redAccent
              ]
            )
          ),
    ),

  );


}



  


  
}
