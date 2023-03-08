import 'dart:collection';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:zameer/utils/multiText.dart';

class CategoryData extends StatelessWidget {
  String imgAddress;
  Color color1;
  String title;
  CategoryData(
      {super.key,
      required this.imgAddress,
      required this.color1,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90.h,
      width: 80.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.r),
        gradient:  LinearGradient(
          colors: [
            Color.fromARGB(255, 31, 30, 30),
            Color.fromARGB(255, 54, 53, 53),
          ]
          ),
      
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 5.h,),
          CircleAvatar(
            radius: 25.r,
            backgroundColor: Colors.transparent,
            backgroundImage:AssetImage(imgAddress),
          ),
          // Container(
          //   height: 50.h,
          //   width: 50.w,
          //   decoration: BoxDecoration(
          //     color: color1,
          //     image: DecorationImage(
          //       image: AssetImage(imgAddress),
          //       fit: BoxFit.fill,
          //     ),
          //     shape: BoxShape.circle,
          //   ),
          // ),
          SizedBox(height: 5.h,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 5.w),
            child: Multi(color: Colors.white, subtitle: title, weight: FontWeight.bold, size: 10),
          ),
          SizedBox(height: 5.h,),
        ],
      ),
    );
  }
}
