import 'dart:collection';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:zameer/pages/mainLanding.dart';

import '../utils/ab.dart';

class Provider1 extends ChangeNotifier {

  String status = "guest";

  // data from api of each category
  List<dynamic>? today;
  List<dynamic>? beef;
  List<dynamic>? mutton;
  List<dynamic>? chicken;
  List<dynamic>? tikka;
  List<dynamic>? beverage;
  List<dynamic>? roll;
  List<dynamic>? addon;
  List<dynamic>? starter;
  List<dynamic>? mk;
  List<dynamic>? ct;
  List<dynamic>? ck;

  List<CartItems>? items_in_cart = []; //all items data will be in this list in the form of classes



  var prices1 = [];//contains the prices of each varition of selected product
  var options = [];
  var ids = [];//contains the name of each varition of selected product

  Map<dynamic, dynamic>? myDictionary; // it contains the dropdown content of variated item

  makeClass(){ //it creates dictionery 
    myDictionary = Map.fromIterables(prices1 , options );
    print(myDictionary);
    print(options);
    notifyListeners();
  }

   Future<void> getData(String id) async { // get prices and options of each variation
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products/$id?consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      prices1.add("${json.decode(response.body)['price']}");
      options.add(["${json.decode(response.body)['name']}","${json.decode(response.body)['id']}"]);
      ids.add("${json.decode(response.body)['id']}");
  }

  double? total;
  double? subtotal;
  int itemLength=0;
  int priceSum=0;

   Future<void> CartCountDecreament(int counter, int index) async {
    items_in_cart![index].count = counter - 1;
    items_in_cart![index].cost=items_in_cart![index].cost-items_in_cart![index].eachCost;
    notifyListeners();
  }
  Future<void> CartCountIncreament(int counter, int index) async {
    items_in_cart![index].count = counter + 1;
    items_in_cart![index].cost=items_in_cart![index].cost+items_in_cart![index].eachCost;
    notifyListeners();
  }
  increamentCart(){
    itemLength++;
    notifyListeners();
  }
    decreamentCart(){
    if(itemLength>0){
      itemLength--;
    }
    else{
      itemLength;
    }
    notifyListeners();
  }

  String? uid ;
  String? name ;
  String? gmail ;
  String? mode ;
  String? number;
  String? address;
  String? nearby;
  String? imgAddress;
  bool loader= false;
  String? time;
  String? method;


   final _googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;


  String url = "";
  Future googleLogin(BuildContext context) async {
   try {

      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken);
    await FirebaseAuth.instance.signInWithCredential(credential);

    final FirebaseAuth auth = FirebaseAuth.instance;
    final FirebaseFirestore db = FirebaseFirestore.instance;

    final User? user1 = auth.currentUser;
    print("${user1!.uid}=====>uid");
    uid = user1.uid;
    name = user1.displayName.toString();
    gmail = user1.email.toString();
    imgAddress = user1.photoURL;
    await db.collection("users").doc(user1.uid).set({
      "name": user1.displayName,
      "profile": user1.photoURL,
      "email": user1.email,
      "uid": user1.uid
    });
    mode = "sign";
    print("Done");
     Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Example()));
    notifyListeners();
   } catch (e) {
     print("${e}error is here");
   }
  }

  Future emailSignin(BuildContext context,
      String email, String password, String phone, String name) async {
    try {
      loader= true;
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore db = FirebaseFirestore.instance;
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final User? user1 = auth.currentUser;
      uid = user1!.uid;
      print("${uid}=====>uid");
    await  db.collection("users").doc(uid).set({
        "name": name,
        "profile": user1.photoURL,
        "email": email,
        "uid": user1.uid
      });
       Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        LogSign()));
      loader= false;
    print("done");

    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    notifyListeners();
  }

  Future<void> sumOfPrice() async {
    List<int> x = [];
    for (int i = 0; i < items_in_cart!.length; i++) {
      x.add(items_in_cart![i].eachCost*items_in_cart![i].count);
    }
    priceSum = x.reduce((value, element) => value + element);
    notifyListeners();
  }

  Future LoginEmail(BuildContext context, String email, String password) async {
    try {
    loader= true;
      final FirebaseAuth auth = FirebaseAuth.instance;
      final FirebaseFirestore db = FirebaseFirestore.instance;
      await auth.signInWithEmailAndPassword(email: email, password: password);
      final User? user1 = auth.currentUser;
      uid = user1!.uid;
      print("${uid}=====>uid");
     
      var data =await FirebaseFirestore.instance.collection("users").doc(uid).get();

      name = data['name'];
      gmail = data['email'];
      mode = "sign";
      print("done");
        Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        Example()));

      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (context) => AddressPayment()),
      // );
      loader= false;
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    notifyListeners();
  }



  notifyListeners();

}

class CartItems {
  int id;
  String imgAddress;
  String title;
  String subtitle;
  
  int count;
  int eachCost;
  int cost;
  CartItems(this.id,this.imgAddress, this.title, this.subtitle, this.cost, this.count,
      this.eachCost);
}

class Lines_Items {
  String? name;
  int? product_id;
  int? variation_id;
  int? quantity;
  String? subtotal;
  String? subtotal_tax;
  String? total;
  String total_tax;
  List taxes;
  List meta_data;
  String? sku;
  int? price;
  Object image;
  String? parent_name;
  Lines_Items(
      this.image,
      this.meta_data,
      this.name,
      this.price,
      this.product_id,
      this.quantity,
      this.sku,
      this.subtotal,
      this.subtotal_tax,
      this.taxes,
      this.total,
      this.total_tax,
      this.variation_id);

  Map<String, dynamic> toJson() => {
        'name': name,
        'product_id': product_id,
        'variation_id': variation_id,
        'quantity': quantity,
        'subtotal': subtotal,
        'subtotal_tax': subtotal_tax,
        'total': total,
        'total_tax': total_tax,
        'taxes': taxes,
        'meta_data': meta_data,
        'sku': sku,
        'price': price,
      };
}

