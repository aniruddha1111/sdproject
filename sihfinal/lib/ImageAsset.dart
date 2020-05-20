import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:sihfinal/utils/database_helper.dart';
class ImageAsset extends StatefulWidget{
  
  int uid;
  File imageFile;
 
  final img;
  ImageAsset(this.uid,this.img);
  _ImageAssetState createState() => _ImageAssetState(this.uid,this.img);
}
class _ImageAssetState extends State<ImageAsset>{
  
   DatabaseHelper helper = DatabaseHelper();
  String base64;
  File tmpImg;
  int uid;
  final img;
  _ImageAssetState(this.uid,this.img);
  Future<File> imageFile;
  Widget showImage(){
    return FutureBuilder<File>(
      future: imageFile, 
      builder: (BuildContext context, AsyncSnapshot snapshot) {


        if(snapshot.connectionState == ConnectionState.done && snapshot.data != null){
         tmpImg = snapshot.data;
          base64 = base64Encode(snapshot.data.readAsBytesSync());
       // var img = base64Decode(base64.toString());
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        }else return const Text("No Image");
      },

    );
  }

  pickImage(ImageSource source){
    setState(() {
       imageFile = ImagePicker.pickImage(source: source);
      
    print(imageFile);

    });
   
  }

  Widget build(BuildContext context){
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      home: Scaffold( 
        appBar: AppBar(

         backgroundColor: Colors.grey[800],
        centerTitle: true,
        title: Text('ADD SCANS',style: TextStyle(color:Colors.white),),
          shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        bottom: Radius.elliptical(30, 30))),
      ),
        body: Container(
          padding: EdgeInsets.only(top: 25.0),
          child: Column(children: <Widget>[
           Card(
             child:Container(
               width: 300,
                height: 400,
                child: Center(child: showImage(),)
             )  
            ),
            FlatButton(
              child: Row( mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[Text("Add Scan Image"), Icon(Icons.add)]),
              onPressed: (){
                pickImage(ImageSource.gallery);
                
              },
            ),
            SizedBox(height: 25.0,),
            RaisedButton(
              child: Text('SAVE',style: TextStyle(color: Colors.white),),
              color: Colors.grey[800],
              onPressed: (){
              if(imageFile!=null){
                 
                  //String base64 = bytes.transform()
                  //String base64Encode(List<int> bytes) => base64.encode(bytes);
                 // print(bytes);
                   // img.id =  uid.toString();
                  
                    
                    _save();
                // Add you database stuff here 
                // Upload "bytes" varibale to the database

                }
              },
            )
          ],),
        ),
      )
    );
  }
   void _save() async {
    int result;
      img.id =  uid.toString();
      img.image = base64;
    
     result = await helper.insertImage(img).catchError((e)=> print(e));
     print(result);
   
    if (result != 0) {
     
               
     
    
      _show('Status', 'SCANS Saved Successfully');
       
     
    } else {
      _show('Status', 'Problem Saving SCANS');
    }
   
  }

  void _show(String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );

    showDialog(context: context, builder: (_) => alertDialog);
  }


}