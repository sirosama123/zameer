import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:zameer/pages/cartList.dart';
import 'package:zameer/provider/provider1.dart';
import 'package:zameer/utils/multi2.dart';
import 'package:zameer/utils/multi3.dart';
import 'package:zameer/utils/multiText.dart';
import 'package:http/http.dart' as http;
import 'package:zameer/utils/para.dart';
import 'package:zameer/utils/shadowText.dart';
import '../utils/ab.dart';
import '../utils/categories.dart';
import '../utils/displayProduct.dart';
import '../utils/products.dart';
import '../utils/special.dart';
import 'package:animated_item_picker/animated_item_picker.dart';
import 'package:stepper_counter_swipe/stepper_counter_swipe.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        
        body: Provider11.name!=null? Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color.fromARGB(255, 31, 30, 30),
            Color.fromARGB(255, 54, 53, 53),
          ]),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.3), //New
              blurRadius: 25.0,
              spreadRadius: 0.1,
              offset: const Offset(
                -5.0,
                5.0,
              ),
            )
          ],
        ),
        child: Column(
          children: [
            Multi3(color: Colors.white, subtitle: "Your Favourities", weight: FontWeight.normal, size: 26),
            Flexible(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('orders/${Provider11.uid}/suborders/orders')
                    .snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                   if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        
             return Container(
                    child: ListView(
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data() as Map<String, dynamic>;
                          return  Multi(color: Colors.white, subtitle: "id ${data['obj']}", weight: FontWeight.bold, size: 20);
                      }).toList(),
                    ),
                  );
      

      

       

              
                  
                  }
                
              ),
            ),
          ],
        ),
      ):Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg2.png"),
            fit: BoxFit.fitWidth
            )
        ),
        child: Center(
          child: Multi2(color: Colors.white, subtitle: "Login to see favourities", weight: FontWeight.bold, size: 25),
        ),
      ),
      ),
    );
  }
}


// Padding(
//                         padding: EdgeInsets.all(12),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                                 flex: 1,
//                                 child: Container(
//                                   height: 50.h,
//                                   width: 50.w,
//                                   decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(10.r),
//                                     image: DecorationImage(    
//                                       image:
//                                           NetworkImage(data['imgAddress']),
//                                           fit: BoxFit.fill,
//                                     ),
                                    
//                                   ),
//                                 )),
//                                 Expanded(
//                                 flex: 3,
//                                 child: Padding(
//                                   padding:  EdgeInsets.only(left: 20.w),
//                                   child: Container(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       mainAxisAlignment: MainAxisAlignment.center,
//                                       children: [
                                      
//                                         Multi(color: Colors.grey, subtitle: data['title'], weight: FontWeight.bold, size: 12),
//                                         Multi(color: Colors.grey, subtitle: "Rs ${data['price']}", weight: FontWeight.bold, size: 12),
//                                       ],
//                                     ),
//                                   ),
//                                 )),
//                                 Expanded(
//                                   flex: 2,
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Container(
//                                         color: Colors.white,
//                                         child: Multi(color: Colors.black, subtitle: data['tax'], weight: FontWeight.bold, size: 10)),
//                                       Container(
//                                         color: Colors.white,
//                                         child: Multi(color: Colors.black, subtitle: data['stock'], weight: FontWeight.bold, size: 10)),
//                                     ],
//                                   )
//                                   )
//                           ],
//                         ),
//                       ),