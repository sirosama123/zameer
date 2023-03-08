import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:woocommerce_api/woocommerce_api.dart';
import 'package:zameer/pages/features/onBoardingFeature/presentation/contentModel.dart';
import 'package:zameer/pages/features/widgets/description.dart';
import 'package:zameer/pages/features/widgets/heading.dart';
import 'package:im_stepper/main.dart';
import 'package:im_stepper/stepper.dart';
import 'package:zameer/pages/initial.dart';
import 'package:zameer/utils/multi2.dart';
import 'package:zameer/utils/multi3.dart';
import 'package:http/http.dart' as http;
import '../../../../provider/provider1.dart';
import '../../../../utils/multiText.dart';
import '../../../landingPage.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  @override
  int activeStep = 0;
  int dotCount = 3;
  bool state = false;

  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context);
    final WooCommerceAPI wc = WooCommerceAPI(
      consumerKey: 'ck_b8a58a9620e9f44935ece14278bc9df3ead71632',
      consumerSecret: 'cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39',
      url: 'https://zameeransari.com.pk',
    );

    Future<void> getData() async {
      // Provider11.today = await wc.getAsync('products?',);

      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products?consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      Provider11.today = json.decode(response.body);
    }

    Future<void> Addons() async {
      // Provider11.addon = await wc.getAsync('products?category=64&page=1&per_page=100',);
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products?category=64&page=1&per_page=100&consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      Provider11.addon = json.decode(response.body);
    }

    Future<void> Beef() async {
      // Provider11.beef = await wc.getAsync('products?category=59&page=1&per_page=100',);
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products?category=59&page=1&per_page=100&consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      Provider11.beef = json.decode(response.body);
    }

    Future<void> Beverages() async {
      // Provider11.beverage = await wc.getAsync('products?category=63&page=1&per_page=100',);
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products?category=63&page=1&per_page=100&consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      Provider11.beverage = json.decode(response.body);
    }

    Future<void> Chicken() async {
      // Provider11.chicken = await wc.getAsync('products?category=61&page=1&per_page=100',);
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products?category=61&page=1&per_page=100&consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      Provider11.chicken = json.decode(response.body);
    }

    Future<void> Ck() async {
      // Provider11.ck = await wc.getAsync('products?category=56&page=1&per_page=100',);
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products?category=56&page=1&per_page=100&consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      Provider11.ck = json.decode(response.body);
    }

    Future<void> Ct() async {
      // Provider11.ct = await wc.getAsync('products?category=58&page=1&per_page=100',);
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products?category=58&page=1&per_page=100&consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      Provider11.ct = json.decode(response.body);
    }

    Future<void> Mutton() async {
      // Provider11.mutton = await wc.getAsync('products?category=60&page=1&per_page=100',);
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products?category=60&page=1&per_page=100&consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      Provider11.mutton = json.decode(response.body);
    }

    Future<void> Mk() async {
      // Provider11.mk = await wc.getAsync('products?category=57&page=1&per_page=100',);
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products?category=57&page=1&per_page=100&consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      Provider11.mk = json.decode(response.body);
    }

    Future<void> Roll() async {
      // Provider11.roll = await wc.getAsync('products?category=65&page=1&per_page=100',);
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products?category=65&page=1&per_page=100&consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      Provider11.roll = json.decode(response.body);
    }

    Future<void> Starter() async {
      // Provider11.starter = await wc.getAsync('products?category=74&page=1&per_page=100',);
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products?category=74&page=1&per_page=100&consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      Provider11.starter = json.decode(response.body);
    }

    return Scaffold(
      body: Container(
       
            height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/bg2.png'),
          fit: BoxFit.fill,
        ),
       
    
        ),
        child: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 68.h,
            ),
            SizedBox(
              height: 272.h,
              width: 280.w,
              child: Image(
                image: AssetImage(contents[activeStep].image),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              height: 32.h,
            ),
            DotStepper(
              activeStep: activeStep,
              dotCount: dotCount,
              shape: Shape.circle,
              dotRadius: 6,
              spacing: 8,
              indicator: Indicator.worm,
              onDotTapped: (dotindex) {
                setState(() {
                  activeStep = dotindex;
                });
              },
              fixedDotDecoration: FixedDotDecoration(
                color: Color(0xffDADADA),
              ),
              indicatorDecoration: IndicatorDecoration(color: Colors.black),
            ),
            SizedBox(height: 15.h),
            Multi3(
                color: Colors.white,
                subtitle: contents[activeStep].title,
                weight: FontWeight.normal,
                size: 30),
            contents[activeStep].subtitle == ""
                ? SizedBox(
                    height: 15.h,
                  )
                : Column(
                    children: [
                      SizedBox(height: 5.h),
                      Multi3(
                          color: Colors.white,
                          subtitle: contents[activeStep].subtitle,
                          weight: FontWeight.normal,
                          size: 20),
                      SizedBox(height: 5.h),
                    ],
                  ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Multi(
                  color: Colors.white,
                  subtitle: contents[activeStep].description,
                  weight: FontWeight.bold,
                  size: 12),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Container(
                child: activeStep > 1
                    ? Container(
                        height: 48.h,
                        width: 312.w,
                        child: state == false
                            ? ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    state = true;
                                  });
                                  await Future.delayed(Duration(seconds: 7));
                                  setState(() {
                                    state = false;
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Initail1()));
                                },
                                child: Text("See Menu"),
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color(0xff1C1C1C)),
                                ),
                              )
                            : Center(
                                child: CircularProgressIndicator(
                                color: Colors.white,
                              )))
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                            ElevatedButton(
                              onPressed: () async {
                                await Future.delayed(Duration(seconds: 2));
                                setState(() {
                                  activeStep++;
                                });
                                getData();
                                Addons();
                                Beef();
                                Beverages();
                                Chicken();
                                Ck();
                                Ct();
                                Mutton();
                                Mk();
                                Roll();
                                Starter();
                              },
                              child: Text(
                                "Skip",
                                style: TextStyle(color: Color(0xff1C1C1C)),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                await Future.delayed(Duration(seconds: 2));
                                setState(() {
                                  activeStep++;
                                });
                                await getData();
                                Addons();
                                Beef();
                                Beverages();
                                Chicken();
                                Ck();
                                Ct();
                                Mutton();
                                Mk();
                                Roll();
                                Starter();
                              },
                              child: Text("Next"),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                    Color(0xff1C1C1C)),
                              ),
                            ),
                          ]),
              ),
            )
          ],
        )),
      ),
    );
  }
}
