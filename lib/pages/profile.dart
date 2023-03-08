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


class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context);
    return SafeArea(
      child: Scaffold(
        body:Provider11.name!=null? Column(
          children: [
            Expanded(
              flex: 2,
              child:Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                                        Color.fromARGB(255, 31, 30, 30),
                                        Color.fromARGB(255, 54, 53, 53),
                                      ]),
                ),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60.r,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 58.r,
                          backgroundColor: Colors.blue,
                          child: Stack(
                            children: [
                              Provider11.imgAddress==null?Image.asset("assets/user.png",fit: BoxFit.fill,):Image.network("${Provider11.imgAddress}",fit: BoxFit.fill),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: CircleAvatar(
                                  radius: 12.r,
                                  backgroundColor: Colors.red,
                                  child: Icon(Icons.add,color: Colors.white,)
                                  ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Multi3(color: Colors.white, subtitle: "${Provider11.name}", weight: FontWeight.normal, size: 14),
                      Multi2(color: Colors.white, subtitle: "${Provider11.gmail}", weight: FontWeight.normal, size: 10),
                    ],
                  ),
                ),
              )
               ),
             Expanded(
              flex: 4,
              child:Container(
                 decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                                        Color.fromARGB(255, 31, 30, 30),
                                        Color.fromARGB(255, 54, 53, 53),
                                      ]),
                ),
                child: Padding(
                  padding:  EdgeInsets.symmetric(horizontal: 15.w),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white.withOpacity(0.3)
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.all(13),
                                    child: Image.asset("assets/profile.png",height: 60.h,width: 60.w,),
                                  ),
                                ),
                                SizedBox(width: 10.w,),
                                Multi(color: Colors.white, subtitle: "Edit Profile", weight: FontWeight.bold, size: 13),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios,color: Colors.white,)
                          ],
                        ),
                        SizedBox(height: 20.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white.withOpacity(0.3)
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.all(13),
                                    child: Image.asset("assets/stat.png",height: 60.h,width: 60.w,),
                                  ),
                                ),
                                SizedBox(width: 10.w,),
                                Multi(color: Colors.white, subtitle: "My Stats", weight: FontWeight.bold, size: 13),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios,color: Colors.white,)
                          ],
                        ),
                        SizedBox(height: 20.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white.withOpacity(0.3)
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.all(13),
                                    child: Image.asset("assets/settings.png",height: 60.h,width: 60.w,),
                                  ),
                                ),
                                SizedBox(width: 10.w,),
                                Multi(color: Colors.white, subtitle: "Settings", weight: FontWeight.bold, size: 13),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios,color: Colors.white,)
                          ],
                        ),
SizedBox(height: 20.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: 50.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10.r),
                                    color: Colors.white.withOpacity(0.3)
                                  ),
                                  child: Padding(
                                    padding:  EdgeInsets.all(13),
                                    child: Image.asset("assets/invite.png",height: 35.h,width: 60.w,),
                                  ),
                                ),
                                SizedBox(width: 10.w,),
                                Multi(color: Colors.white, subtitle: "invite a friend", weight: FontWeight.bold, size: 13),
                              ],
                            ),
                            Icon(Icons.arrow_forward_ios,color: Colors.white,)
                          ],
                        )
                      ],
                    )
                    ),
                ),
              )
               )
          ],
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
          child: Multi2(color: Colors.white, subtitle: "Login to see your profile", weight: FontWeight.bold, size: 25),
        ),
      ),
      ),
    );
  }
}