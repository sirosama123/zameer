import 'dart:collection';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class Provider1 extends ChangeNotifier {

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
  var options = [];//contains the name of each varition of selected product

  Map<dynamic, dynamic>? myDictionary; // it contains the dropdown content of variated item

  makeClass(){ //it creates dictionery 
    myDictionary = Map.fromIterables(prices1 , options );
    print(myDictionary);
    notifyListeners();
  }

   Future<void> getData(String id) async { // get prices and options of each variation
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products/$id?consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      prices1.add("${json.decode(response.body)['price']}");
      options.add("${json.decode(response.body)['name']}");
  }

  double? total;
  double? subtotal;

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


  notifyListeners();

}

class CartItems {
  String imgAddress;
  String title;
  String subtitle;
  
  int count;
  int eachCost;
  int cost;
  CartItems(this.imgAddress, this.title, this.subtitle, this.cost, this.count,
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

