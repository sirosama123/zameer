import 'dart:collection';
import 'dart:convert';
import 'dart:ui';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';
import 'package:zameer/provider/provider1.dart';
import 'package:zameer/utils/multiText.dart';
import 'package:glass/glass.dart';
import 'package:intl/intl.dart';
import 'package:woocommerce_api/woocommerce_api.dart';
import '../utils/cartItem.dart';
import '../utils/multi2.dart';
import '../utils/multi3.dart';

class Pro extends StatelessWidget {
  const Pro({super.key});

  @override
  Widget build(BuildContext context) {
    final WooCommerceAPI wc = WooCommerceAPI(
      consumerKey: 'ck_b8a58a9620e9f44935ece14278bc9df3ead71632',
      consumerSecret: 'cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39',
      url: 'https://zameeransari.com.pk',
    );
    fetchCategories() async {
      var products = await wc.getAsync("products/categories");
      print(products[1]['name']);
    }

    return Scaffold(
        body: Container(
            child: Center(
                child: ElevatedButton(
      child: Text("send"),
      onPressed: () {
        fetchCategories();
      },
    ))));
  }
}

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesScreenState createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  bool val = false;
  late Future<List<dynamic>> _futureCategories;

  final _searchController = TextEditingController();
  final WooCommerceAPI wc = WooCommerceAPI(
    consumerKey: 'ck_b8a58a9620e9f44935ece14278bc9df3ead71632',
    consumerSecret: 'cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39',
    url: 'https://zameeransari.com.pk',
  );

  Future<List<dynamic>> fetchCategories() async {
    final List<dynamic> categories = await wc.getAsync('products');
    return categories;
  }

  @override
  void initState() {
    super.initState();
    _futureCategories = fetchCategories();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              suffixIcon: val == false
                  ? Icon(Icons.search)
                  : IconButton(icon: Icon(Icons.cancel,color: Colors.black,),
                 onPressed: (){
                    setState(() {
                      val=false;
                    });
                    _searchController.clear();
                  },
                  ),
              hintText: 'Search categories',
            ),
            onChanged: (value) {
              setState(() {
                val = true;
              });
            },
          ),
        ),
        body: val == true
            ? FutureBuilder(
                future: fetchCategories(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final List<dynamic>? categories =
                        snapshot.data as List<dynamic>;
                    final filteredCategories = categories!.where((category) =>
                        category['name']
                            .toLowerCase()
                            .contains(_searchController.text.toLowerCase()));
                    return ListView.builder(
                      itemCount: filteredCategories.length,
                      itemBuilder: (context, index) {
                        final category = filteredCategories.elementAt(index);
                        return GestureDetector(
                          onTap: () {
                            print(category['variations']);
                          },
                          child: ListTile(
                            title: Text(category['name']),
                            subtitle: Text(category['description']),
                            trailing: Image.network(category['images'][0]['src']),
                          ),
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    return Text('${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              )
            : Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.red,
              ));
  }
}
