import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:material_dialogs/dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:provider/provider.dart';

import '../provider/provider1.dart';
import '../utils/multiText.dart';


class AddressPayment extends StatefulWidget {
  const AddressPayment({super.key});

  @override
  State<AddressPayment> createState() => _AddressPaymentState();
}

class _AddressPaymentState extends State<AddressPayment> {
  TextEditingController user_instruction = TextEditingController(text: "Testing from abdul sami");
  bool val = false;
  final String apiKey = "c";
  final String apiSecret = "";

  Map<String, dynamic> orderData = {
    "payment_method": "cash on delievery",
    "payment_method_title": "cash on delievery",
    "status": "processing",
    "currency": "PKR",
    "version": "6.6.1",
    "billing": {
      "first_name": "",
      "last_name": "",
      "address_1": "",
      "address_2": "",
      "city": "Karachi",
      "state": "",
      "postcode": "",
      "country": "Pakistan",
      "email": "",
      "phone": ""
    },
    "shipping": {
      "first_name": "",
      "last_name": "",
      "address_1": "",
      "address_2": "",
      "city": "",
      "state": "",
      "postcode": "",
      "country": ""
    },
    "line_items": [

    ],
      "shipping_lines": [
    {
      "method_id": "flat_rate",
      "method_title": "Flat Rate",
      "total": "0"
    }
  ],
    "customer_id": 0,
    "customer_note": "Please deliver as soon as possible."
  };

  Future<void> createOrder(Map<String, dynamic> orderData) async {
    setState(() {
      val=true;
    });
    final String url = "https://www.sialkotbakers.pk/wp-json/wc/v3/orders";
    final String auth =
        'Basic ' + base64Encode(utf8.encode('$apiKey:$apiSecret'));

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Authorization': auth,
        'Content-Type': 'application/json',
      },
      body: json.encode(orderData),
    );

    if (response.statusCode == 201) {
      Map<String, dynamic> order = json.decode(response.body);
      int orderId = order['id'];
      print('Order created with ID: $orderId , ${order['number']}');
       setState(() {
      val=false;
    });
    } else {
      print("Failed to create order: ${response.body}");
       setState(() {
      val=false;
    });
    }
  }

  

  @override
  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context);
  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Multi(
            color: Colors.black,
            subtitle: "Address & Payment",
            weight: FontWeight.w700,
            size: 20),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.black
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15.h,
                              ),
                              Multi(
                                  color: Colors.white,
                                  subtitle: " DELIVERY ADDRESS",
                                  weight: FontWeight.w700,
                                  size: 12),
                              SizedBox(
                                height: 7.h,
                              ),
                              Container(
                                height: 140.h,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                   gradient: LinearGradient(colors: [
                        Color.fromARGB(255, 31, 30, 30),
                        Color.fromARGB(255, 54, 53, 53),
                      ]),
                                  borderRadius: BorderRadius.circular(15.r),
                                  
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(12),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Provider11.name == null
                                                  ? Icon(
                                                      CupertinoIcons.person_alt_circle,
                                                      color: Colors.red,
                                                      size: 20,
                                                    )
                                                  : Icon(
                                                      CupertinoIcons.person_alt_circle,
                                                      color: Color.fromARGB(
                                                          255, 91, 90, 90),
                                                      size: 20,
                                                    ),
                                              SizedBox(
                                                width: 10.w,
                                              ),
                                              Provider11.name == null
                                                  ? Multi(
                                                      color: Colors.red,
                                                      subtitle: "Name required",
                                                      weight: FontWeight.bold,
                                                      size: 12)
                                                  : Multi(
                                                      color: Color.fromARGB(
                                                          255, 91, 90, 90),
                                                      subtitle: "${Provider11.name}",
                                                      weight: FontWeight.bold,
                                                      size: 12),
                                            ],
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                             if (Provider11.mode=="not") {
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //       builder: (context) =>
                                                //           EditOrderDetail()));
                                             } else {
                                                // Navigator.push(
                                                //   context,
                                                //   MaterialPageRoute(
                                                //       builder: (context) =>
                                                //           MyDetails()));
                                             }
                                            },
                                            child: Icon(
                                              Icons.edit,
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Provider11.name == null
                                              ? Icon(
                                                  CupertinoIcons.phone_fill,
                                                  color: Colors.red,
                                                  size: 20,
                                                )
                                              : Icon(
                                                  CupertinoIcons.phone_fill,
                                                  color:
                                                      Color.fromARGB(255, 91, 90, 90),
                                                  size: 20,
                                                ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Provider11.name == null
                                              ? Multi(
                                                  color: Colors.red,
                                                  subtitle: "Phone number required",
                                                  weight: FontWeight.bold,
                                                  size: 12)
                                              : Multi(
                                                  color:
                                                      Color.fromARGB(255, 91, 90, 90),
                                                  subtitle: "${Provider11.number}",
                                                  weight: FontWeight.bold,
                                                  size: 12),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Provider11.name == null
                                              ? Icon(
                                                  CupertinoIcons.map_pin_ellipse,
                                                  color: Colors.red,
                                                  size: 20,
                                                )
                                              : Icon(
                                                  CupertinoIcons.map_pin_ellipse,
                                                  color:
                                                      Color.fromARGB(255, 91, 90, 90),
                                                  size: 20,
                                                ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Provider11.name == null
                                              ? Multi(
                                                  color: Colors.red,
                                                  subtitle: "Address required",
                                                  weight: FontWeight.bold,
                                                  size: 12)
                                              : Multi(
                                                  color:
                                                      Color.fromARGB(255, 91, 90, 90),
                                                  subtitle: "${Provider11.address}",
                                                  weight: FontWeight.bold,
                                                  size: 12),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Icon(
                                            CupertinoIcons.flag_fill,
                                            color: Color.fromARGB(255, 91, 90, 90),
                                            size: 20,
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Column(
                                            children: [
                                              Multi(
                                                  color:
                                                      Color.fromARGB(255, 91, 90, 90),
                                                  subtitle: "Nearest Land mark",
                                                  weight: FontWeight.w600,
                                                  size: 9),
                                              Provider11.name == null
                                                  ? Multi(
                                                      color: Color.fromARGB(
                                                          255, 91, 90, 90),
                                                      subtitle: "None",
                                                      weight: FontWeight.bold,
                                                      size: 12)
                                                  : Multi(
                                                      color: Color.fromARGB(
                                                          255, 91, 90, 90),
                                                      subtitle: "${Provider11.nearby}",
                                                      weight: FontWeight.bold,
                                                      size: 12),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              Multi(
                                  color: Colors.white,
                                  subtitle: "PAYMENT METHOD",
                                  weight: FontWeight.w700,
                                  size: 12),
                              SizedBox(
                                height: 7.h,
                              ),
                              Container(
                                  height: 40.h,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            // <-- Icon
                                            CupertinoIcons.check_mark_circled_solid,
                                            size: 16.0,
                                            color: Color(0xffD7A563),
                                          ),
                                          SizedBox(
                                            width: 2.w,
                                          ),
                                          Multi(
                                              color: Color(0xffD7A563),
                                              subtitle: "Cash on Delivery",
                                              weight: FontWeight.w700,
                                              size: 12), // <-- Text
                                        ],
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      side: BorderSide(
                                          width: 2.w, color: Color(0xffD7A563)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r), // <-- Radius
                                      ),
                                    ),
                                    onPressed: () {},
                                  )),
                              SizedBox(
                                height: 15.h,
                              ),
                              Multi(
                                  color: Colors.white,
                                  subtitle: "DELIEVERY INSTRUCTIONS",
                                  weight: FontWeight.w700,
                                  size: 12),
                              SizedBox(
                                height: 7.h,
                              ),
                              TextField(
                                controller: user_instruction,
                                cursorColor: Color.fromARGB(255, 91, 90, 90),
                                decoration: InputDecoration(
                                  hintText: "Enter your instructions here",
                                  helperStyle: TextStyle(fontSize: 10.sp),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Color.fromARGB(255, 91, 90, 90)),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 1,
                                        color: Color.fromARGB(255, 91, 90, 90)),
                                  ),
                                ),
                              ),
                              SizedBox(height: 15.h,),
                                Container(
                                  height: 50.h,
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 5.w),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Icon(
                                            // <-- Icon
                                            CupertinoIcons.check_mark_circled_solid,
                                            size: 20.0,
                                            color: Color(0xffD7A563),
                                          ),
                                          SizedBox(
                                            width: 10.w,
                                          ),
                                          Multi(
                                              color: Color(0xffD7A563),
                                              subtitle: "Place Order",
                                              weight: FontWeight.w700,
                                              size: 20), // <-- Text
                                        ],
                                      ),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.black,
                                      side: BorderSide(
                                          width: 2.w, color: Color(0xffD7A563)),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.r), // <-- Radius
                                      ),
                                    ),
                                    onPressed: () {
                                      Dialogs.bottomMaterialDialog(
        
            color: Color(0xffD7A563),
            context: context,
            actions: [
                  Container(
                height: 170.h,
                decoration: BoxDecoration(
                    color: Color(0xffD7A563),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.r),
                        topRight: Radius.circular(15.r))),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Multi(
                              color: Colors.black,
                              subtitle: "Sub Total",
                              weight: FontWeight.w600,
                              size: 12),
                          Multi(
                              color: Colors.black,
                              subtitle: "Rs ${Provider11.priceSum}",
                              weight: FontWeight.w600,
                              size: 12),
                        ],
                      ),
                      SizedBox(height: 2.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Multi(
                              color: Colors.black,
                              subtitle: "Tax 0%",
                              weight: FontWeight.w600,
                              size: 12),
                          Multi(
                              color: Colors.black,
                              subtitle: "Rs 0",
                              weight: FontWeight.w600,
                              size: 12),
                        ],
                      ),
                      SizedBox(height: 2.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            Multi(
                              color: Colors.black,
                              subtitle: "Delievery Fee(${Provider11.address})",
                              weight: FontWeight.w600,
                              size: 12),
                          Multi(
                              color: Colors.black,
                              subtitle: "Rs ${Provider11.priceSum}",
                              weight: FontWeight.w600,
                              size: 12),
                        ],
                      ),
                      SizedBox(height: 2.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                           Multi(
                              color: Colors.black,
                              subtitle: "Total",
                              weight: FontWeight.w800,
                              size: 14),
                          Multi(
                              color: Colors.black,
                              subtitle: "Rs ${int.parse(Provider11.priceSum.toString())+int.parse(Provider11.priceSum.toString())}",
                              weight: FontWeight.w800,
                              size: 14),
                        ],
                      ),
                      SizedBox(height: 2.h,),
                      val==false?Container(
                          height: 50.h,
                          width: double.infinity,
                          child: ElevatedButton(
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(),
                                  Multi(
                                      color: Color(0xffD7A563),
                                      subtitle: "Confirm Order",
                                      weight: FontWeight.w600,
                                      size: 18), // <-- Text
                                  Icon(
                                    // <-- Icon
                                    Icons.arrow_forward,
                                    size: 24.0,
                                    color: Color(0xffD7A563),
                                  ),
                                ],
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(15.r), // <-- Radius
                              ),
                            ),
                            onPressed: () {
                          
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => EditOrderDetail()));
                            },
                          )):Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              ),
                    ],
                  ),
                ),
              )
            ]);
                                    },
                                  )),
                            ],
                          ),
                          
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      
          
            ],
          ),
        ),
      ),
    ),
    builder: EasyLoading.init(),
    );
  }
}
