import 'dart:convert';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:zameer/pages/landingPage.dart';
import 'package:http/http.dart' as http;
import 'package:zameer/pages/mainLanding.dart';
import '../pages/cartList.dart';
import '../provider/provider1.dart';
import 'multiText.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:intl/intl.dart';

class DisplayProduct extends StatefulWidget {
  String imgAddress;
  String title;
  String price;
  List<dynamic>? variation;

  DisplayProduct(
      {super.key,
      required this.imgAddress,
      required this.title,
      required this.variation,
      required this.price});

  @override
  State<DisplayProduct> createState() => _DisplayProductState();
}

String? selectedValue;
String? price1;
int count = 1;

class _DisplayProductState extends State<DisplayProduct> {
  @override
   void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  @override
  void dispose() {
    BackButtonInterceptor.remove(myInterceptor);
    super.dispose();
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
   final Provider11 = Provider.of<Provider1>(context,listen: false);
      Provider11.options.clear();
      Provider11.prices1.clear();
      setState(() {
        selectedValue = null;
        price1 = null;
      });
      if (Provider11.myDictionary?.isEmpty==false) {
        Provider11.myDictionary={};
        Navigator.of(context).pop();
      }
      else{
       Navigator.of(context).pop();
      }
    return true;
  }
  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context);
    NumberFormat priceFormat = NumberFormat.currency(
      symbol: 'PKR', // currency symbol
      decimalDigits: 2, // number of decimal digits
    );
    // String? price2 = widget.price;

    final Map? items = Provider11.myDictionary;

    addItem() async {
      Provider11.items_in_cart!.add(CartItems(
        1,
        widget.imgAddress,
        widget.title,
        widget.title,
        int.parse(widget.price.toString()) * count,
        count,
        int.parse(widget.price.toString()),
      ));
      Provider11.options.clear();
      Provider11.prices1.clear();
      setState(() {
        selectedValue = null;
        price1 = null;
      });
      Provider11.increamentCart();
      if (Provider11.myDictionary?.isEmpty==false) {
        Provider11.myDictionary={};
        
        Navigator.of(context).pop();
      }
      else{
       Navigator.of(context).pop();
      }
      
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: GestureDetector(
            onTap: () async {
              Provider11.options.clear();
              Provider11.prices1.clear();
              Provider11.myDictionary!.clear();
              setState(() {
                selectedValue = null;
                price1 = null;
              });
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
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: AvatarGlow(
                endRadius: 60.0,
                glowColor: Colors.red,
                child: Material(
                  // Replace this child with your own
                  shadowColor: Colors.red,
                  elevation: 8.0,
                  shape: CircleBorder(),
                  child: CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    child: Image.asset(
                      'assets/share.png',
                      height: 40,
                    ),
                    radius: 30.0,
                  ),
                ),
              ),
            )
          ],
          title: Text("Sample"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            child: Stack(
              children: [
                ListView(
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 350.h,
                            decoration: BoxDecoration(
                                border: const GradientBoxBorder(
                                  gradient: LinearGradient(colors: [
                                    Colors.white,
                                    Color(0xffCC0006)
                                  ]),
                                  width: 8,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: Offset(0, 3),
                                  ),
                                ],
                                image: DecorationImage(
                                  image: NetworkImage("${widget.imgAddress}"),
                                  fit: BoxFit.fill,
                                ),
                                shape: BoxShape.circle),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                              height: 60.h,
                              width: 120.w,
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  isExpanded: true,
                                  hint: Row(
                                    children: const [
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Expanded(
                                        child: Text(
                                          'Select Size',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                  items: items?.entries.map((entry) {
                                    return DropdownMenuItem<String>(
                                      value: entry.key,
                                      child: Text(
                                        entry.value,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  }).toList(),
                                  value: selectedValue,
                                  onChanged: (value) {
                                    print("${value} value is here");
                                    setState(() {
                                      price1 = value;
                                      widget.price = value.toString();
                                      selectedValue = value as String;
                                    });
                                  },
                                  icon: Icon(Icons.arrow_downward_outlined),
                                  iconSize: 14,
                                  iconEnabledColor: Colors.white,
                                  iconDisabledColor: Colors.grey,
                                  buttonHeight: 50,
                                  buttonWidth: 160,
                                  buttonPadding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  buttonDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                      color: Colors.black26,
                                    ),
                                    color: Color(0xffCC0006),
                                  ),
                                  buttonElevation: 2,
                                  itemHeight: 40,
                                  itemPadding: const EdgeInsets.only(
                                      left: 14, right: 14),
                                  dropdownMaxHeight: 200,
                                  dropdownWidth: 200,
                                  dropdownPadding: null,
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(14),
                                    color: Color(0xffCC0006),
                                  ),
                                  dropdownElevation: 8,
                                  scrollbarRadius: const Radius.circular(40),
                                  scrollbarThickness: 6,
                                  scrollbarAlwaysShow: true,
                                  offset: const Offset(-20, 0),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 80.w,
                            left: 80.w,
                            child: Container(
                              height: 60.h,
                              width: 100.w,
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    offset: const Offset(
                                      0,
                                      0,
                                    ),
                                    blurRadius: 10.0,
                                    spreadRadius: 1.0,
                                  ), //BoxShadow
                                  BoxShadow(
                                    color: Colors.white,
                                    offset: const Offset(0.0, 0.0),
                                    blurRadius: 0.0,
                                    spreadRadius: 0.0,
                                  ), //BoxShadow
                                ],
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(colors: [
                                  Color(0xffCC0006),
                                  Color.fromARGB(255, 206, 39, 45),
                                  Color(0xffCC0006)
                                ]),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  CircleAvatar(
                                    radius: 20.r,
                                    backgroundColor: Colors.transparent,
                                    child: IconButton(
                                        disabledColor: Colors.grey,
                                        onPressed: () {
                                          setState(() {
                                            count++;
                                          });
                                        },
                                        icon: Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 25,
                                          weight: 40,
                                        )),
                                  ),
                                  CircleAvatar(
                                    radius: 20.r,
                                    backgroundColor: Colors.white,
                                    child: Multi(
                                        color: Color(0xffCC0006),
                                        subtitle: "$count",
                                        weight: FontWeight.bold,
                                        size: 21),
                                  ),
                                  CircleAvatar(
                                    radius: 20.r,
                                    backgroundColor: Colors.transparent,
                                    child: IconButton(
                                        onPressed: () {
                                          if (count == 1) {
                                            setState(() {
                                              count;
                                            });
                                          } else {
                                            setState(() {
                                              count--;
                                            });
                                          }
                                        },
                                        icon: Icon(
                                          Icons.remove,
                                          color: Colors.white,
                                          size: 25,
                                          weight: 40,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Multi(
                        color: Color(0xffCC0006),
                        subtitle: "${widget.title}",
                        weight: FontWeight.w700,
                        size: 35),
                    Multi(
                        color: Colors.grey,
                        subtitle:
                            "${priceFormat.format(double.parse(price1 == null ? widget.price : price1.toString()))}",
                        weight: FontWeight.w500,
                        size: 25),
                    SizedBox(
                      height: 20.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 50.h,
                            width: 170.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: const Offset(
                                    0,
                                    0,
                                  ),
                                  blurRadius: 10.0,
                                  spreadRadius: 1.0,
                                ), //BoxShadow
                                BoxShadow(
                                  color: Colors.white,
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ), //BoxShadow
                              ],
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  Image.asset("assets/clock.png"),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Multi(
                                          color: Colors.black,
                                          subtitle: "15 - 20 min",
                                          weight: FontWeight.bold,
                                          size: 15),
                                      Multi(
                                          color: Colors.black,
                                          subtitle: "delievery time",
                                          weight: FontWeight.normal,
                                          size: 15),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 50.h,
                            width: 120.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  offset: const Offset(
                                    0,
                                    0,
                                  ),
                                  blurRadius: 10.0,
                                  spreadRadius: 1.0,
                                ), //BoxShadow
                                BoxShadow(
                                  color: Colors.white,
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 0.0,
                                  spreadRadius: 0.0,
                                ), //BoxShadow
                              ],
                            ),
                            child: Center(
                              child: Row(
                                children: [
                                  Image.asset("assets/fire.png"),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Multi(
                                          color: Colors.black,
                                          subtitle: "xyz",
                                          weight: FontWeight.bold,
                                          size: 15),
                                      Multi(
                                          color: Colors.black,
                                          subtitle: "Fresh",
                                          weight: FontWeight.normal,
                                          size: 15),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: GestureDetector(
                        onTap: () {
                          addItem();
                        },
                        child: Container(
                          width: double.infinity,
                          height: 60.h,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey,
                                offset: const Offset(
                                  0,
                                  0,
                                ),
                                blurRadius: 10.0,
                                spreadRadius: 1.0,
                              ), //BoxShadow
                              BoxShadow(
                                color: Colors.white,
                                offset: const Offset(0.0, 0.0),
                                blurRadius: 0.0,
                                spreadRadius: 0.0,
                              ), //BoxShadow
                            ],
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(colors: [
                              Color(0xffCC0006),
                              Color.fromARGB(255, 206, 39, 45),
                              Color(0xffCC0006)
                            ]),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.white,
                                child: Image.asset("assets/cart.png",
                                    height: 40.h, width: 40.w),
                              ),
                              Multi(
                                  color: Colors.white,
                                  subtitle: "Add to cart",
                                  weight: FontWeight.w700,
                                  size: 21),
                              Row(
                                children: [
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color.fromARGB(255, 207, 105, 105),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color.fromARGB(255, 184, 124, 124),
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: Color.fromARGB(255, 141, 85, 85),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
