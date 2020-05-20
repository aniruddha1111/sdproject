//import 'dart:convert';

class Data {
  int _id;
  String _name;
  String _lname;
  String _age;
   String _blood;
    String _sex;
  String _date;
  String _disease;
  String _medicine;
  Data(this._name, this._lname, this._age,this._blood,this._sex,this._date,this._disease,this._medicine);

  Data.withId(this._id, this._name, this._lname, this._age,this._blood,this._sex,this._date,this._disease,this._medicine);

  int get id => _id;
  String get name => _name;
  String get lname => _lname;
  String get  age => _age;
  String get  blood => _blood;
  String get  sex => _sex;
  String get date => _date;
   String get disease=> _disease;
  String get medicine=> _medicine;
  set name(String newName) {
    this._name = newName;
  }

  set lname(String newLname) {
    this._lname = newLname;
  }

  set age(String newAge) {
    this._age = newAge;
  }

   set blood(String newBlood) {
    this._blood = newBlood;
  }

  set sex(String newSex) {
    this._sex = newSex;
  }

  set date(String newDate) {
    this._date = newDate;
  }
  set disease(String newDisease) {
    this._disease = newDisease;
  }
  set medicine(String newMedicine) {
    this._medicine=newMedicine;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['name'] = _name;
    map['lname'] = _lname;
    map['age'] = _age;
     map['blood'] = _blood;
     map['sex'] = _sex;
     map['date'] = _date;
      map['disease']=_disease;
      map['medicine']=_medicine;
    return map;
  }

  Data.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._lname = map['lname'];
    this._age = map['age'];
     this._blood = map['blood'];
    this._sex = map['sex'];
     this._date = map['date'];
     this._disease=map['disease'];
     this._medicine=map['medicine'];
  }

  startsWith(String query) {}
}




class Image1 {
  int _id1;
   String _id;
  String image;


  Image1(this._id,this.image);

  Image1.withId(this._id1,this._id, this.image, );
  int get id1 => _id1;

  String get id => _id;

  String get lname => image;
  
   

  set image1(String newImage) {
    this.image = newImage;
  }
set id(String newId) {
    this._id = newId;
  }

  

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    if (_id1 != null) {
      map['id1'] = _id1;
    }
     map['id'] = _id;
    map['image'] = image;
   

    return map;
  }

  Image1.fromMapObject(Map<String, dynamic> map) {
    this._id1 = map['id1'];
     this._id = map['id'];
    this.image = map['image'];
    
  }

  startsWith(String query) {}
}
