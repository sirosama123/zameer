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

import '../utils/cartItem.dart';
import '../utils/multi2.dart';

class CartList extends StatefulWidget {
  CartList({
    super.key,
  });

  @override
  State<CartList> createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Color(0xffCC0006),
        appBar: AppBar(
          actions: [
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                    textStyle:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Dialogs.bottomMaterialDialog(
                      color: Colors.black,
                      context: context,
                      actions: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Multi(
                                    color: Colors.white,
                                    subtitle: "Sub Total",
                                    weight: FontWeight.bold,
                                    size: 16),
                                Multi(
                                    color: Colors.white,
                                    subtitle: "Rs 1110",
                                    weight: FontWeight.bold,
                                    size: 16),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Multi(
                                    color: Colors.grey,
                                    subtitle: "Delievery",
                                    weight: FontWeight.bold,
                                    size: 16),
                                Multi(
                                    color: Colors.grey,
                                    subtitle: "Free",
                                    weight: FontWeight.bold,
                                    size: 16),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Multi(
                                    color: Colors.grey,
                                    subtitle: "Tax",
                                    weight: FontWeight.bold,
                                    size: 16),
                                Multi(
                                    color: Colors.grey,
                                    subtitle: "100",
                                    weight: FontWeight.bold,
                                    size: 16),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Multi(
                                    color: Color(0xffCC0006),
                                    subtitle: "Total",
                                    weight: FontWeight.w700,
                                    size: 16),
                                Multi(
                                    color: Color(0xffCC0006),
                                    subtitle: "Rs 1110",
                                    weight: FontWeight.w800,
                                    size: 16),
                              ],
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              width: double.infinity,
                              height: 50.h,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 25, vertical: 5),
                                      textStyle: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold)),
                                  onPressed: () {},
                                  child: Text(
                                    "Place the Order",
                                    style: TextStyle(
                                      color: Color(0xffCC0006),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ]);
                },
                child: Text(
                  "Confirm",
                  style: TextStyle(color: Color(0xffCC0006)),
                ))
          ],
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () async {
              Navigator.of(context).pop();
            },
            child: AvatarGlow(
              endRadius: 60.0,
              glowColor: Colors.red,
              child: Material(
                // Replace this child with your own
                elevation: 8.0,
                shadowColor: Colors.red,
                shape: CircleBorder(),
                child: CircleAvatar(
                  backgroundColor: Colors.grey[100],
                  child: Image.asset(
                    'assets/arrow_back.png',
                    height: 40,
                  ),
                  radius: 30.0,
                ),
              ),
            ),
          ),
          title: Text("Cart"),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: ListView.builder(
              itemCount: Provider11.items_in_cart!.length,
              itemBuilder: (BuildContext ctx, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 7.h, bottom: 7.h),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(15.r)),
                        width: double.infinity,
                        height: 150.h,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Container(
                                    height: 200.h,
                                    width: 200.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      image: DecorationImage(
                                        image: NetworkImage(Provider11
                                            .items_in_cart![index].imgAddress),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  )),
                              Expanded(
                                  flex: 4,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 27.h, horizontal: 10.w),
                                        child: Container(
                                          width: 110.w,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Multi2(
                                                  color: Colors.white,
                                                  subtitle:
                                                      "${Provider11.items_in_cart![index].title.length > 10 ? Provider11.items_in_cart![index].title.substring(0, 11) + "..." : Provider11.items_in_cart![index].title}",
                                                  weight: FontWeight.bold,
                                                  size: 20),
                                              Multi(
                                                  color: Colors.grey,
                                                  subtitle:
                                                      "${Provider11.items_in_cart![index].title.length > 10 ? Provider11.items_in_cart![index].title.substring(0, 11) + "..." : Provider11.items_in_cart![index].title}",
                                                  weight: FontWeight.bold,
                                                  size: 12),
                                              Multi(
                                                  color: Colors.white,
                                                  subtitle:
                                                      "\$ ${double.parse(Provider11.items_in_cart![index].eachCost.toString())}",
                                                  weight: FontWeight.w900,
                                                  size: 18),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 30.h),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Multi(
                                                color: Colors.grey,
                                                subtitle:
                                                    "\$${double.parse(Provider11.items_in_cart![index].cost.toString())}",
                                                weight: FontWeight.bold,
                                                size: 16),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Container(
                                                  height: 30.h,
                                                  width: 30.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color:
                                                            Color(0xffCC0006),
                                                        spreadRadius: 0.3,
                                                        blurRadius: 7,
                                                        offset:
                                                            const Offset(1, 1),
                                                      ),
                                                      const BoxShadow(
                                                          color: Colors.white,
                                                          offset:
                                                              Offset(-1, -1),
                                                          blurRadius: 7,
                                                          spreadRadius: 0.3),
                                                    ],
                                                    gradient: RadialGradient(
                                                      colors: [
                                                        Color.fromARGB(
                                                            255, 233, 48, 54),
                                                        Color(0xffCC0006),
                                                      ],
                                                    ),
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Provider11
                                                          .CartCountIncreament(
                                                              Provider11
                                                                  .items_in_cart![
                                                                      index]
                                                                  .count,
                                                              index);
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Multi(
                                                    color: Colors.white,
                                                    subtitle:
                                                        "${Provider11.items_in_cart![index].count}",
                                                    weight: FontWeight.w800,
                                                    size: 16),
                                                SizedBox(
                                                  width: 10,
                                                ),
                                                Container(
                                                  height: 30.h,
                                                  width: 30.w,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.r),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color:
                                                            Color(0xffCC0006),
                                                        spreadRadius: 0.3,
                                                        blurRadius: 7,
                                                        offset:
                                                            const Offset(1, 1),
                                                      ),
                                                      const BoxShadow(
                                                          color: Colors.white,
                                                          offset:
                                                              Offset(-1, -1),
                                                          blurRadius: 7,
                                                          spreadRadius: 0.3),
                                                    ],
                                                    gradient: RadialGradient(
                                                      colors: [
                                                        Color.fromARGB(
                                                            255, 233, 48, 54),
                                                        Color(0xffCC0006),
                                                      ],
                                                    ),
                                                  ),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                     if (Provider11.items_in_cart![index].count!=1) {
                                                        Provider11
                                                          .CartCountDecreament(
                                                              Provider11
                                                                  .items_in_cart![
                                                                      index]
                                                                  .count,
                                                              index);
                                                     } else {
                                                       Provider11.items_in_cart!.removeAt(index);
                                                       Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => super.widget));
                                                        Provider11.items_in_cart!.length==0? Navigator.of(context):null;
                                                     }
                                                    },
                                                    child: Icon(
                                                      Provider11
                                                                  .items_in_cart![
                                                                      index]
                                                                  .count ==
                                                              1
                                                          ? CupertinoIcons
                                                              .delete
                                                          : Icons.remove,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ))
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }
}
