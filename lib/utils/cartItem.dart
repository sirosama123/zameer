import 'dart:collection';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:zameer/utils/multiText.dart';

import 'multi2.dart';

class CartItem extends StatefulWidget {
  String imgAddress;
  String title;
  double eachCost;
  double cost;
  int count;
  Function? inc;
  Function? dec;
  Function? del;
  
  CartItem({super.key,required this.imgAddress,required this.title,required this.eachCost,required this.cost,required this.count,required this.inc,required this.dec,required this.del});

  @override
  State<CartItem> createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
            
        Container(
          
          decoration: BoxDecoration(
            
              color: Colors.black.withOpacity(0.7), borderRadius: BorderRadius.circular(15.r)),
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
                          image: NetworkImage(widget.imgAddress),
                          fit: BoxFit.fill,
                        ),
                      ),
                    )),
                Expanded(
                    flex: 4,
                    child: Row(
                      children: [
                        Padding(
                          padding:  EdgeInsets.symmetric(vertical: 27.h,horizontal: 10.w),
                          child: Container(
                            width: 110.w,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              
                                Multi2(
                                    color: Colors.white,
                                    subtitle: "${widget.title.length>10?widget.title.substring(0,11)+"...":widget.title}",
                                    weight: FontWeight.bold,
                                    size: 20),
                                Multi(
                                    color: Colors.grey,
                                    subtitle: "${widget.title.length>10?widget.title.substring(0,11)+"...":widget.title}",
                                    weight: FontWeight.bold,
                                    size: 12),
                                Multi(
                                    color: Colors.white,
                                    subtitle: "\$ ${widget.eachCost}",
                                    weight: FontWeight.w900,
                                    size: 18),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                         padding:  EdgeInsets.symmetric(vertical: 30.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            
                            children: [
                              Multi(
                                  color: Colors.grey,
                                  subtitle: "\$${widget.cost}",
                                  weight: FontWeight.bold,
                                  size: 16),
                              
                              Row(
                                mainAxisAlignment:MainAxisAlignment.spaceBetween ,
                                children: [
                                  Container(
                                    height: 30.h,
                                    width: 30.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xffCC0006),
                                          spreadRadius: 0.3,
                                          blurRadius: 7,
                                          offset: const Offset(1, 1),
                                        ),
                                        const BoxShadow(
                                            color: Colors.white,
                                            offset: Offset(-1, -1),
                                            blurRadius: 7,
                                            spreadRadius: 0.3),
                                      ],
                                      gradient: RadialGradient(
                                        colors: [
                                          Color.fromARGB(255, 233, 48, 54),
                                          Color(0xffCC0006),
                                        ],
                                      ),
                                    ),
                                    child: GestureDetector(
                                      onTap: (){
                                        widget.inc;
                                      },
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10,),
                                  Multi(color: Colors.white, subtitle: "${widget.count}", weight: FontWeight.w800, size: 16),
                                  SizedBox(width: 10,),
                                   Container(
                                    height: 30.h,
                                    width: 30.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xffCC0006),
                                          spreadRadius: 0.3,
                                          blurRadius: 7,
                                          offset: const Offset(1, 1),
                                        ),
                                        const BoxShadow(
                                            color: Colors.white,
                                            offset: Offset(-1, -1),
                                            blurRadius: 7,
                                            spreadRadius: 0.3),
                                      ],
                                      gradient: RadialGradient(
                                        colors: [
                                          Color.fromARGB(255, 233, 48, 54),
                                          Color(0xffCC0006),
                                        ],
                                      ),
                                    ),
                                    child: GestureDetector(
                                      onTap: (){
                                        widget.dec;
                                      },
                                      child: Icon(
                                        widget.count==1?
                                        CupertinoIcons.delete:
                                        Icons.remove,
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
    );
  }
}
