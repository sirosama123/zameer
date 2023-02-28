import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:zameer/provider/provider1.dart';
import 'package:zameer/utils/multiText.dart';
import 'package:http/http.dart' as http;
import '../utils/categories.dart';
import '../utils/displayProduct.dart';
import '../utils/products.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context);
    final scrollController = ScrollController();
    Future<void> getData(String id) async {
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products/$id?consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      Provider11.prices1.add("${json.decode(response.body)['price']}");
      Provider11.options.add("${json.decode(response.body)['name']}");
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      home: Scaffold(
        backgroundColor: Colors.black,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  // do something
                  Navigator.of(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.help),
                title: Text('Help'),
                onTap: () {
                  // do something
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Container(
            child: Stack(
              children: [
                ListView(
                  controller: scrollController,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: double.infinity,
                        height: 55.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Builder(builder: (context) {
                              return GestureDetector(
                                onTap: () {
                                  Scaffold.of(context).openDrawer();
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
                                        'assets/drawer.png',
                                        height: 30,
                                      ),
                                      radius: 30.0,
                                    ),
                                  ),
                                ),
                              );
                            }),
                            Multi(
                                color: Colors.white,
                                subtitle: "Zameer Ansari",
                                weight: FontWeight.bold,
                                size: 16),
                            AvatarGlow(
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
                                    'assets/user.png',
                                    height: 30,
                                  ),
                                  radius: 30.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Container(
                          child: Container(
                            height: 55.h,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.red.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Center(
                              child: Padding(
                                padding:
                                    EdgeInsets.only(right: 10.w, left: 10.w),
                                child: TextField(
                                  decoration: InputDecoration(
                                      prefixIcon: Icon(
                                        Icons.search_outlined,
                                        color: Color(0xffCC0006),
                                        size: 35,
                                        weight: 200,
                                      ),
                                      suffixIcon: Container(
                                        width: 75.w,
                                        height: 40.h,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25.r),
                                          color: Color(0xffCC0006),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 7,
                                              offset: Offset(0,
                                                  3), // changes position of shadow
                                            ),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Multi(
                                                color: Colors.white,
                                                subtitle: "Filter",
                                                weight: FontWeight.bold,
                                                size: 13),
                                            Icon(CupertinoIcons.color_filter,
                                                color: Colors.white, size: 20)
                                          ],
                                        ),
                                      ),
                                      border: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      disabledBorder: InputBorder.none,
                                      hintText: "Search here",
                                      hintStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Container(
                        height: 120.h,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            GestureDetector(
                              onTap: () {
                                scrollController.animateTo(
                                  200.h, // Replace 100 with the Y offset of the item you want to scroll to
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: CategoryData(
                                imgAddress: "assets/beef.png",
                                title: 'Beef',
                                color1: Colors.transparent,
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                scrollController.animateTo(
                                  500.h,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: CategoryData(
                                imgAddress: "assets/mutton.jpg",
                                title: 'mutton',
                                color1: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                scrollController.animateTo(
                                  800.h, // Replace 100 with the Y offset of the item you want to scroll to
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: CategoryData(
                                imgAddress: "assets/chicken.png",
                                title: 'chicken',
                                color1: Colors.transparent,
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            GestureDetector(
                              onTap: () {
                                scrollController.animateTo(
                                  1100.h, // Replace 100 with the Y offset of the item you want to scroll to
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              },
                              child: CategoryData(
                                imgAddress: "assets/tikka.jpg",
                                title: 'Tikka',
                                color1: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            CategoryData(
                              imgAddress: "assets/beverages.png",
                              title: 'Beverage',
                              color1: Colors.transparent,
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            CategoryData(
                              imgAddress: "assets/roll.png",
                              title: 'Roll',
                              color1: Colors.transparent,
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            CategoryData(
                              imgAddress: "assets/pizza.png",
                              title: 'Addons',
                              color1: Colors.transparent,
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            CategoryData(
                              imgAddress: "assets/salad.png",
                              title: 'Starter',
                              color1: Colors.transparent,
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            CategoryData(
                              imgAddress: "assets/ck2.jpg",
                              title: 'Chicken Koyla Karahi',
                              color1: Colors.white,
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            CategoryData(
                              imgAddress: "assets/tikka.jpg",
                              title: 'Chicken Tikka',
                              color1: Colors.white,
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            CategoryData(
                              imgAddress: "assets/mutton.jpg",
                              title: 'Mutton Kolya Karahi',
                              color1: Colors.white,
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 1.5,
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Multi(
                              color: Colors.white,
                              subtitle: "Today's Special",
                              weight: FontWeight.bold,
                              size: 18),
                          Container()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Container(
                        height: 250.h,
                        child: FutureBuilder(
                            // future: Beef(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error"),
                            );
                          }

                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Provider11.today!.length,
                              itemBuilder: (BuildContext context, int index) {
                                print(index);
                                fn() {
                                  for (var i = 0;
                                      i <
                                          Provider11.today![index]['variations']
                                              .length;
                                      i++) {
                                    Provider11.getData(Provider11.today![index]
                                            ['variations'][i]
                                        .toString());
                                    //  Provider11.options.add(Provider11.today![index]['attributes'][0]['options'][i]);
                                  }
                                }

                                return GestureDetector(
                                  onTap: () async {
                                    if (Provider11.today![index]['variations']
                                            .isEmpty ==
                                        true) {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  DisplayProduct(
                                                    imgAddress: Provider11
                                                            .today![index]
                                                                ['images']
                                                            .isEmpty
                                                        ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                        : Provider11.today![
                                                                index]['images']
                                                            [0]['src'],
                                                    title: Provider11
                                                        .today![index]['name'],
                                                    variation: Provider11
                                                                .today![index][
                                                                    'attributes']
                                                                .isEmpty ==
                                                            true
                                                        ? ["no variation"]
                                                        : Provider11.today![
                                                                    index]
                                                                ['attributes']
                                                            [0]['options'],
                                                    price: Provider11
                                                        .today![index]['price'],
                                                  )));
                                    } else {
                                      await EasyLoading.show(status: 'wait...');
                                      await fn();
                                      await Future.delayed(
                                          Duration(seconds: 3));
                                    
                                      try {
                                        await Provider11.makeClass();
                                      } catch (e) {
                                        print("${e} error is heree");
                                      }
                                      await Future.delayed(
                                          Duration(microseconds: 1000));
                                     

                                      if (Provider11.today![index]['variations']
                                                  .isEmpty ==
                                              false &&
                                          Provider11.options.isEmpty == false) {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    DisplayProduct(
                                                      imgAddress: Provider11
                                                              .today![index]
                                                                  ['images']
                                                              .isEmpty
                                                          ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                          : Provider11.today![
                                                                      index]
                                                                  ['images'][0]
                                                              ['src'],
                                                      title: Provider11
                                                              .today![index]
                                                          ['name'],
                                                      variation: Provider11
                                                                  .today![index]
                                                                      [
                                                                      'attributes']
                                                                  .isEmpty ==
                                                              true
                                                          ? ["no variation"]
                                                          : Provider11.today![
                                                                      index]
                                                                  ['attributes']
                                                              [0]['options'],
                                                      price: Provider11
                                                              .today![index]
                                                          ['price'],
                                                    )));
                                        await EasyLoading.showSuccess("Enjoy");
                                      } else {
                                        print("netwok error");
                                        await EasyLoading.showError(
                                            "Network Problem");
                                      
                                        Provider11.options.clear();
                                        Provider11.prices1.clear();
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Products(
                                      imgAddress: Provider11
                                              .today![index]['images'].isEmpty
                                          ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                          : Provider11.today![index]['images']
                                              [0]['src'],
                                      price: Provider11.today![index]['price']
                                          .toString(),
                                      title: Provider11.today![index]['name']
                                          .toString(),
                                    ),
                                  ),
                                );
                              });
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Divider(
                      color: Colors.white,
                      thickness: 1.5,
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Multi(
                              color: Colors.white,
                              subtitle: "Beef",
                              weight: FontWeight.bold,
                              size: 18),
                          Container()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Container(
                        height: 250.h,
                        child: FutureBuilder(
                            // future: Beef(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error"),
                            );
                          }

                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Provider11.beef!.length,
                              itemBuilder: (BuildContext context, int index) {
                                print(index);
                                fn() {
                                  for (var i = 0;
                                      i <
                                          Provider11.beef![index]['variations']
                                              .length;
                                      i++) {
                                    Provider11.getData(Provider11.beef![index]
                                            ['variations'][i]
                                        .toString());
                                    //  Provider11.options.add(Provider11.today![index]['attributes'][0]['options'][i]);
                                  }
                                }

                                return GestureDetector(
                                  onTap: () async {
                                    if (Provider11.beef![index]['variations']
                                            .isEmpty ==
                                        true) {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  DisplayProduct(
                                                    imgAddress: Provider11
                                                            .beef![index]
                                                                ['images']
                                                            .isEmpty
                                                        ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                        : Provider11.beef![
                                                                index]['images']
                                                            [0]['src'],
                                                    title: Provider11
                                                        .beef![index]['name'],
                                                    variation: Provider11
                                                                .beef![index][
                                                                    'attributes']
                                                                .isEmpty ==
                                                            true
                                                        ? ["no variation"]
                                                        : Provider11.beef![
                                                                    index]
                                                                ['attributes']
                                                            [0]['options'],
                                                    price: Provider11
                                                        .beef![index]['price'],
                                                  )));
                                    } else {
                                      //  for (var i = 0; i < Provider11.options.length; i++) {
                                      //    Provider11.p.add("${Provider11.options[i]} ${Provider11.prices1[i]}");
                                      //  }
                                      //   print("done2");
                                      //  await Future.delayed(Duration(seconds:1));
                                     await EasyLoading.show(status: 'wait...');
                                      await fn();
                                      await Future.delayed(
                                          Duration(seconds: 3));
                                    
                                      try {
                                        await Provider11.makeClass();
                                      } catch (e) {
                                        print("${e} error is heree");
                                      }
                                      await Future.delayed(
                                          Duration(microseconds: 1000));
                                      

                                      if (Provider11.beef![index]['variations']
                                                  .isEmpty ==
                                              false &&
                                          Provider11.options.isEmpty == false) {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    DisplayProduct(
                                                      imgAddress: Provider11
                                                              .beef![index]
                                                                  ['images']
                                                              .isEmpty
                                                          ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                          : Provider11.beef![
                                                                      index]
                                                                  ['images'][0]
                                                              ['src'],
                                                      title: Provider11
                                                          .beef![index]['name'],
                                                      variation: Provider11
                                                                  .beef![index][
                                                                      'attributes']
                                                                  .isEmpty ==
                                                              true
                                                          ? ["no variation"]
                                                          : Provider11.beef![
                                                                      index]
                                                                  ['attributes']
                                                              [0]['options'],
                                                      price: Provider11
                                                              .beef![index]
                                                          ['price'],
                                                    )));
                                      } else {
                                        print("netwok error");
                                        await EasyLoading.showError(
                                            "Network Problem");
                                      
                                        Provider11.options.clear();
                                        Provider11.prices1.clear();
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Products(
                                      imgAddress: Provider11
                                              .beef![index]['images'].isEmpty
                                          ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                          : Provider11.beef![index]['images'][0]
                                              ['src'],
                                      price: Provider11.beef![index]['price']
                                          .toString(),
                                      title: Provider11.beef![index]['name']
                                          .toString(),
                                    ),
                                  ),
                                );
                              });
                        }),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Multi(
                              color: Colors.white,
                              subtitle: "Mutton",
                              weight: FontWeight.bold,
                              size: 18),
                          Container()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Container(
                        height: 250.h,
                        child: FutureBuilder(builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error"),
                            );
                          }

                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Provider11.mutton!.length,
                              itemBuilder: (BuildContext context, int index) {
                                fn() {
                                  for (var i = 0;
                                      i <
                                          Provider11
                                              .mutton![index]['variations']
                                              .length;
                                      i++) {
                                    Provider11.getData(Provider11.mutton![index]
                                            ['variations'][i]
                                        .toString());
                                    //  Provider11.options.add(Provider11.today![index]['attributes'][0]['options'][i]);
                                  }
                                }

                                print(index);
                                return GestureDetector(
                                  onTap: () async {
                                    if (Provider11.mutton![index]['variations']
                                            .isEmpty ==
                                        true) {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  DisplayProduct(
                                                    imgAddress: Provider11
                                                            .mutton![index]
                                                                ['images']
                                                            .isEmpty
                                                        ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                        : Provider11.mutton![
                                                                index]['images']
                                                            [0]['src'],
                                                    title: Provider11
                                                        .mutton![index]['name'],
                                                    variation: Provider11
                                                                .mutton![index][
                                                                    'attributes']
                                                                .isEmpty ==
                                                            true
                                                        ? ["no variation"]
                                                        : Provider11.mutton![
                                                                    index]
                                                                ['attributes']
                                                            [0]['options'],
                                                    price: Provider11
                                                            .mutton![index]
                                                        ['price'],
                                                  )));
                                    } else {
                                      //  for (var i = 0; i < Provider11.options.length; i++) {
                                      //    Provider11.p.add("${Provider11.options[i]} ${Provider11.prices1[i]}");
                                      //  }
                                      //   print("done2");
                                      //  await Future.delayed(Duration(seconds:1));
                                    await EasyLoading.show(status: 'wait...');
                                      await fn();
                                      await Future.delayed(
                                          Duration(seconds: 3));
                                    
                                      try {
                                        await Provider11.makeClass();
                                      } catch (e) {
                                        print("${e} error is heree");
                                      }
                                      await Future.delayed(
                                          Duration(microseconds: 1000));
                                    

                                      if (Provider11
                                                  .mutton![index]['variations']
                                                  .isEmpty ==
                                              false &&
                                          Provider11.options.isEmpty == false) {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    DisplayProduct(
                                                      imgAddress: Provider11
                                                              .mutton![index]
                                                                  ['images']
                                                              .isEmpty
                                                          ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                          : Provider11.mutton![
                                                                      index]
                                                                  ['images'][0]
                                                              ['src'],
                                                      title: Provider11
                                                              .mutton![index]
                                                          ['name'],
                                                      variation: Provider11
                                                                  .mutton![
                                                                      index][
                                                                      'attributes']
                                                                  .isEmpty ==
                                                              true
                                                          ? ["no variation"]
                                                          : Provider11.mutton![
                                                                      index]
                                                                  ['attributes']
                                                              [0]['options'],
                                                      price: Provider11
                                                              .mutton![index]
                                                          ['price'],
                                                    )));
                                      } else {
                                        print("netwok error");
                                         await EasyLoading.showError(
                                            "Network Problem");
                                      
                                        Provider11.options.clear();
                                        Provider11.prices1.clear();
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Products(
                                      imgAddress: Provider11
                                              .mutton![index]['images'].isEmpty
                                          ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                          : Provider11.mutton![index]['images']
                                              [0]['src'],
                                      price: Provider11.mutton![index]['price']
                                          .toString(),
                                      title: Provider11.mutton![index]['name']
                                          .toString(),
                                    ),
                                  ),
                                );
                              });
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Multi(
                              color: Colors.white,
                              subtitle: "Chicken",
                              weight: FontWeight.bold,
                              size: 18),
                          Container()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Container(
                        height: 250.h,
                        child: FutureBuilder(builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error"),
                            );
                          }

                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Provider11.chicken!.length,
                              itemBuilder: (BuildContext context, int index) {
                                fn() {
                                  for (var i = 0;
                                      i <
                                          Provider11
                                              .chicken![index]['variations']
                                              .length;
                                      i++) {
                                    Provider11.getData(Provider11
                                        .chicken![index]['variations'][i]
                                        .toString());
                                    //  Provider11.options.add(Provider11.today![index]['attributes'][0]['options'][i]);
                                  }
                                }

                                print(index);
                                return GestureDetector(
                                  onTap: () async {
                                    if (Provider11.chicken![index]['variations']
                                            .isEmpty ==
                                        true) {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  DisplayProduct(
                                                    imgAddress: Provider11
                                                            .chicken![index]
                                                                ['images']
                                                            .isEmpty
                                                        ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                        : Provider11.chicken![
                                                                index]['images']
                                                            [0]['src'],
                                                    title: Provider11
                                                            .chicken![index]
                                                        ['name'],
                                                    variation: Provider11
                                                                .chicken![index]
                                                                    [
                                                                    'attributes']
                                                                .isEmpty ==
                                                            true
                                                        ? ["no variation"]
                                                        : Provider11.chicken![
                                                                    index]
                                                                ['attributes']
                                                            [0]['options'],
                                                    price: Provider11
                                                            .chicken![index]
                                                        ['price'],
                                                  )));
                                    } else {
                                      //  for (var i = 0; i < Provider11.options.length; i++) {
                                      //    Provider11.p.add("${Provider11.options[i]} ${Provider11.prices1[i]}");
                                      //  }
                                      //   print("done2");
                                      //  await Future.delayed(Duration(seconds:1));
                                     await EasyLoading.show(status: 'wait...');
                                      await fn();
                                      await Future.delayed(
                                          Duration(seconds: 3));
                                    
                                      try {
                                        await Provider11.makeClass();
                                      } catch (e) {
                                        print("${e} error is heree");
                                      }
                                      await Future.delayed(
                                          Duration(microseconds: 1000));
                                     

                                      if (Provider11
                                                  .chicken![index]['variations']
                                                  .isEmpty ==
                                              false &&
                                          Provider11.options.isEmpty == false) {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    DisplayProduct(
                                                      imgAddress: Provider11
                                                              .chicken![index]
                                                                  ['images']
                                                              .isEmpty
                                                          ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                          : Provider11.chicken![
                                                                      index]
                                                                  ['images'][0]
                                                              ['src'],
                                                      title: Provider11
                                                              .chicken![index]
                                                          ['name'],
                                                      variation: Provider11
                                                                  .chicken![
                                                                      index][
                                                                      'attributes']
                                                                  .isEmpty ==
                                                              true
                                                          ? ["no variation"]
                                                          : Provider11.chicken![
                                                                      index]
                                                                  ['attributes']
                                                              [0]['options'],
                                                      price: Provider11
                                                              .chicken![index]
                                                          ['price'],
                                                    )));
                                      } else {
                                        print("netwok error");
                                         await EasyLoading.showError(
                                            "Network Problem");
                                      
                                        Provider11.options.clear();
                                        Provider11.prices1.clear();
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Products(
                                      imgAddress: Provider11
                                              .chicken![index]['images'].isEmpty
                                          ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                          : Provider11.chicken![index]['images']
                                              [0]['src'],
                                      price: Provider11.chicken![index]['price']
                                          .toString(),
                                      title: Provider11.chicken![index]['name']
                                          .toString(),
                                    ),
                                  ),
                                );
                              });
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Multi(
                              color: Colors.white,
                              subtitle: "Tikka",
                              weight: FontWeight.bold,
                              size: 18),
                          Container()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Container(
                        height: 250.h,
                        child: FutureBuilder(builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error"),
                            );
                          }

                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Provider11.ct!.length,
                              itemBuilder: (BuildContext context, int index) {
                                print(index);
                                fn() {
                                  for (var i = 0;
                                      i <
                                          Provider11
                                              .ct![index]['variations'].length;
                                      i++) {
                                    Provider11.getData(Provider11.ct![index]
                                            ['variations'][i]
                                        .toString());
                                    //  Provider11.options.add(Provider11.today![index]['attributes'][0]['options'][i]);
                                  }
                                }

                                print(index);
                                return GestureDetector(
                                  onTap: () async {
                                    if (Provider11
                                            .ct![index]['variations'].isEmpty ==
                                        true) {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  DisplayProduct(
                                                    imgAddress: Provider11
                                                            .ct![index]
                                                                ['images']
                                                            .isEmpty
                                                        ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                        : Provider11.ct![index]
                                                                ['images'][0]
                                                            ['src'],
                                                    title: Provider11.ct![index]
                                                        ['name'],
                                                    variation: Provider11
                                                                .ct![index][
                                                                    'attributes']
                                                                .isEmpty ==
                                                            true
                                                        ? ["no variation"]
                                                        : Provider11.ct![index]
                                                                ['attributes']
                                                            [0]['options'],
                                                    price: Provider11.ct![index]
                                                        ['price'],
                                                  )));
                                    } else {
                                      //  for (var i = 0; i < Provider11.options.length; i++) {
                                      //    Provider11.p.add("${Provider11.options[i]} ${Provider11.prices1[i]}");
                                      //  }
                                      //   print("done2");
                                      //  await Future.delayed(Duration(seconds:1));
                                    await EasyLoading.show(status: 'wait...');
                                      await fn();
                                      await Future.delayed(
                                          Duration(seconds: 3));
                                    
                                      try {
                                        await Provider11.makeClass();
                                      } catch (e) {
                                        print("${e} error is heree");
                                      }
                                      await Future.delayed(
                                          Duration(microseconds: 1000));
                                     

                                      if (Provider11.ct![index]['variations']
                                                  .isEmpty ==
                                              false &&
                                          Provider11.options.isEmpty == false) {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    DisplayProduct(
                                                      imgAddress: Provider11
                                                              .ct![index]
                                                                  ['images']
                                                              .isEmpty
                                                          ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                          : Provider11.ct![
                                                                      index]
                                                                  ['images'][0]
                                                              ['src'],
                                                      title: Provider11
                                                          .ct![index]['name'],
                                                      variation: Provider11
                                                                  .ct![index][
                                                                      'attributes']
                                                                  .isEmpty ==
                                                              true
                                                          ? ["no variation"]
                                                          : Provider11.ct![
                                                                      index]
                                                                  ['attributes']
                                                              [0]['options'],
                                                      price: Provider11
                                                          .ct![index]['price'],
                                                    )));
                                      } else {
                                        print("netwok error");
                                         await EasyLoading.showError(
                                            "Network Problem");
                                      
                                        Provider11.options.clear();
                                        Provider11.prices1.clear();
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Products(
                                      imgAddress: Provider11
                                              .ct![index]['images'].isEmpty
                                          ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                          : Provider11.ct![index]['images'][0]
                                              ['src'],
                                      price: Provider11.ct![index]['price']
                                          .toString(),
                                      title: Provider11.ct![index]['name']
                                          .toString(),
                                    ),
                                  ),
                                );
                              });
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Multi(
                              color: Colors.white,
                              subtitle: "Beverages",
                              weight: FontWeight.bold,
                              size: 18),
                          Container()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Container(
                        height: 250.h,
                        child: FutureBuilder(builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error"),
                            );
                          }

                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Provider11.beverage!.length,
                              itemBuilder: (BuildContext context, int index) {
                                print(index);
                                fn() {
                                  for (var i = 0;
                                      i <
                                          Provider11
                                              .beverage![index]['variations']
                                              .length;
                                      i++) {
                                    Provider11.getData(Provider11
                                        .beverage![index]['variations'][i]
                                        .toString());
                                    //  Provider11.options.add(Provider11.today![index]['attributes'][0]['options'][i]);
                                  }
                                }

                                print(index);
                                return GestureDetector(
                                  onTap: () async {
                                    if (Provider11
                                            .beverage![index]['variations']
                                            .isEmpty ==
                                        true) {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  DisplayProduct(
                                                    imgAddress: Provider11
                                                            .beverage![index]
                                                                ['images']
                                                            .isEmpty
                                                        ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                        : Provider11.beverage![
                                                                index]['images']
                                                            [0]['src'],
                                                    title: Provider11
                                                            .beverage![index]
                                                        ['name'],
                                                    variation: Provider11
                                                                .beverage![
                                                                    index][
                                                                    'attributes']
                                                                .isEmpty ==
                                                            true
                                                        ? ["no variation"]
                                                        : Provider11.beverage![
                                                                    index]
                                                                ['attributes']
                                                            [0]['options'],
                                                    price: Provider11
                                                            .beverage![index]
                                                        ['price'],
                                                  )));
                                    } else {
                                      //  for (var i = 0; i < Provider11.options.length; i++) {
                                      //    Provider11.p.add("${Provider11.options[i]} ${Provider11.prices1[i]}");
                                      //  }
                                      //   print("done2");
                                      //  await Future.delayed(Duration(seconds:1));
                                    await EasyLoading.show(status: 'wait...');
                                      await fn();
                                      await Future.delayed(
                                          Duration(seconds: 3));
                                    
                                      try {
                                        await Provider11.makeClass();
                                      } catch (e) {
                                        print("${e} error is heree");
                                      }
                                      await Future.delayed(
                                          Duration(microseconds: 1000));
                                     

                                      if (Provider11
                                                  .beverage![index]
                                                      ['variations']
                                                  .isEmpty ==
                                              false &&
                                          Provider11.options.isEmpty == false) {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    DisplayProduct(
                                                      imgAddress: Provider11
                                                              .beverage![index]
                                                                  ['images']
                                                              .isEmpty
                                                          ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                          : Provider11.beverage![
                                                                      index]
                                                                  ['images'][0]
                                                              ['src'],
                                                      title: Provider11
                                                              .beverage![index]
                                                          ['name'],
                                                      variation: Provider11
                                                                  .beverage![
                                                                      index][
                                                                      'attributes']
                                                                  .isEmpty ==
                                                              true
                                                          ? ["no variation"]
                                                          : Provider11.beverage![
                                                                      index]
                                                                  ['attributes']
                                                              [0]['options'],
                                                      price: Provider11
                                                              .beverage![index]
                                                          ['price'],
                                                    )));
                                      } else {
                                        print("netwok error");
                                         await EasyLoading.showError(
                                            "Network Problem");
                                      
                                        Provider11.options.clear();
                                        Provider11.prices1.clear();
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Products(
                                      imgAddress: Provider11
                                              .beverage![index]['images']
                                              .isEmpty
                                          ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                          : Provider11.beverage![index]
                                              ['images'][0]['src'],
                                      price: Provider11.beverage![index]
                                              ['price']
                                          .toString(),
                                      title: Provider11.beverage![index]['name']
                                          .toString(),
                                    ),
                                  ),
                                );
                              });
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Multi(
                              color: Colors.white,
                              subtitle: "Rolls",
                              weight: FontWeight.bold,
                              size: 18),
                          Container()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Container(
                        height: 250.h,
                        child: FutureBuilder(builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error"),
                            );
                          }

                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Provider11.roll!.length,
                              itemBuilder: (BuildContext context, int index) {
                                print(index);
                                fn() {
                                  for (var i = 0;
                                      i <
                                          Provider11.roll![index]['variations']
                                              .length;
                                      i++) {
                                    Provider11.getData(Provider11.roll![index]
                                            ['variations'][i]
                                        .toString());
                                    //  Provider11.options.add(Provider11.today![index]['attributes'][0]['options'][i]);
                                  }
                                }

                                print(index);
                                return GestureDetector(
                                  onTap: () async {
                                    if (Provider11.roll![index]['variations']
                                            .isEmpty ==
                                        true) {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  DisplayProduct(
                                                    imgAddress: Provider11
                                                            .roll![index]
                                                                ['images']
                                                            .isEmpty
                                                        ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                        : Provider11.roll![
                                                                index]['images']
                                                            [0]['src'],
                                                    title: Provider11
                                                        .roll![index]['name'],
                                                    variation: Provider11
                                                                .roll![index][
                                                                    'attributes']
                                                                .isEmpty ==
                                                            true
                                                        ? ["no variation"]
                                                        : Provider11.roll![
                                                                    index]
                                                                ['attributes']
                                                            [0]['options'],
                                                    price: Provider11
                                                        .roll![index]['price'],
                                                  )));
                                    } else {
                                      //  for (var i = 0; i < Provider11.options.length; i++) {
                                      //    Provider11.p.add("${Provider11.options[i]} ${Provider11.prices1[i]}");
                                      //  }
                                      //   print("done2");
                                      //  await Future.delayed(Duration(seconds:1));
                                    await EasyLoading.show(status: 'wait...');
                                      await fn();
                                      await Future.delayed(
                                          Duration(seconds: 3));
                                    
                                      try {
                                        await Provider11.makeClass();
                                      } catch (e) {
                                        print("${e} error is heree");
                                      }
                                      await Future.delayed(
                                          Duration(microseconds: 1000));

                                      if (Provider11.roll![index]['variations']
                                                  .isEmpty ==
                                              false &&
                                          Provider11.options.isEmpty == false) {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    DisplayProduct(
                                                      imgAddress: Provider11
                                                              .roll![index]
                                                                  ['images']
                                                              .isEmpty
                                                          ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                          : Provider11.roll![
                                                                      index]
                                                                  ['images'][0]
                                                              ['src'],
                                                      title: Provider11
                                                          .roll![index]['name'],
                                                      variation: Provider11
                                                                  .roll![index][
                                                                      'attributes']
                                                                  .isEmpty ==
                                                              true
                                                          ? ["no variation"]
                                                          : Provider11.roll![
                                                                      index]
                                                                  ['attributes']
                                                              [0]['options'],
                                                      price: Provider11
                                                              .roll![index]
                                                          ['price'],
                                                    )));
                                      } else {
                                        print("netwok error");
                                         await EasyLoading.showError(
                                            "Network Problem");
                                      
                                        Provider11.options.clear();
                                        Provider11.prices1.clear();
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Products(
                                      imgAddress: Provider11
                                              .roll![index]['images'].isEmpty
                                          ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                          : Provider11.roll![index]['images'][0]
                                              ['src'],
                                      price: Provider11.roll![index]['price']
                                          .toString(),
                                      title: Provider11.roll![index]['name']
                                          .toString(),
                                    ),
                                  ),
                                );
                              });
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Multi(
                              color: Colors.white,
                              subtitle: "Addons",
                              weight: FontWeight.bold,
                              size: 18),
                          Container()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Container(
                        height: 250.h,
                        child: FutureBuilder(builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error"),
                            );
                          }

                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Provider11.addon!.length,
                              itemBuilder: (BuildContext context, int index) {
                                print(index);
                                fn() {
                                  for (var i = 0;
                                      i <
                                          Provider11.addon![index]['variations']
                                              .length;
                                      i++) {
                                    Provider11.getData(Provider11.addon![index]
                                            ['variations'][i]
                                        .toString());
                                    //  Provider11.options.add(Provider11.today![index]['attributes'][0]['options'][i]);
                                  }
                                }

                                print(index);
                                return GestureDetector(
                                  onTap: () async {
                                    if (Provider11.addon![index]['variations']
                                            .isEmpty ==
                                        true) {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  DisplayProduct(
                                                    imgAddress: Provider11
                                                            .addon![index]
                                                                ['images']
                                                            .isEmpty
                                                        ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                        : Provider11.addon![
                                                                index]['images']
                                                            [0]['src'],
                                                    title: Provider11
                                                        .addon![index]['name'],
                                                    variation: Provider11
                                                                .addon![index][
                                                                    'attributes']
                                                                .isEmpty ==
                                                            true
                                                        ? ["no variation"]
                                                        : Provider11.addon![
                                                                    index]
                                                                ['attributes']
                                                            [0]['options'],
                                                    price: Provider11
                                                        .addon![index]['price'],
                                                  )));
                                    } else {
                                      //  for (var i = 0; i < Provider11.options.length; i++) {
                                      //    Provider11.p.add("${Provider11.options[i]} ${Provider11.prices1[i]}");
                                      //  }
                                      //   print("done2");
                                      //  await Future.delayed(Duration(seconds:1));
                                    await EasyLoading.show(status: 'wait...');
                                      await fn();
                                      await Future.delayed(
                                          Duration(seconds: 3));
                                    
                                      try {
                                        await Provider11.makeClass();
                                      } catch (e) {
                                        print("${e} error is heree");
                                      }
                                      await Future.delayed(
                                          Duration(microseconds: 1000));
                                   

                                      if (Provider11.addon![index]['variations']
                                                  .isEmpty ==
                                              false &&
                                          Provider11.options.isEmpty == false) {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    DisplayProduct(
                                                      imgAddress: Provider11
                                                              .addon![index]
                                                                  ['images']
                                                              .isEmpty
                                                          ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                          : Provider11.addon![
                                                                      index]
                                                                  ['images'][0]
                                                              ['src'],
                                                      title: Provider11
                                                              .addon![index]
                                                          ['name'],
                                                      variation: Provider11
                                                                  .addon![index]
                                                                      [
                                                                      'attributes']
                                                                  .isEmpty ==
                                                              true
                                                          ? ["no variation"]
                                                          : Provider11.addon![
                                                                      index]
                                                                  ['attributes']
                                                              [0]['options'],
                                                      price: Provider11
                                                              .addon![index]
                                                          ['price'],
                                                    )));
                                      } else {
                                        print("netwok error");
                                         await EasyLoading.showError(
                                            "Network Problem");
                                      
                                        Provider11.options.clear();
                                        Provider11.prices1.clear();
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Products(
                                      imgAddress: Provider11
                                              .addon![index]['images'].isEmpty
                                          ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                          : Provider11.addon![index]['images']
                                              [0]['src'],
                                      price: Provider11.addon![index]['price']
                                          .toString(),
                                      title: Provider11.addon![index]['name']
                                          .toString(),
                                    ),
                                  ),
                                );
                              });
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Multi(
                              color: Colors.white,
                              subtitle: "Starter",
                              weight: FontWeight.bold,
                              size: 18),
                          Container()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Container(
                        height: 250.h,
                        child: FutureBuilder(builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error"),
                            );
                          }

                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Provider11.starter!.length,
                              itemBuilder: (BuildContext context, int index) {
                                print(index);
                                fn() {
                                  for (var i = 0;
                                      i <
                                          Provider11
                                              .starter![index]['variations']
                                              .length;
                                      i++) {
                                    Provider11.getData(Provider11
                                        .starter![index]['variations'][i]
                                        .toString());
                                    //  Provider11.options.add(Provider11.today![index]['attributes'][0]['options'][i]);
                                  }
                                }

                                print(index);
                                return GestureDetector(
                                  onTap: () async {
                                    if (Provider11.starter![index]['variations']
                                            .isEmpty ==
                                        true) {
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: (context, animation,
                                                      secondaryAnimation) =>
                                                  DisplayProduct(
                                                    imgAddress: Provider11
                                                            .starter![index]
                                                                ['images']
                                                            .isEmpty
                                                        ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                        : Provider11.starter![
                                                                index]['images']
                                                            [0]['src'],
                                                    title: Provider11
                                                            .starter![index]
                                                        ['name'],
                                                    variation: Provider11
                                                                .starter![index]
                                                                    [
                                                                    'attributes']
                                                                .isEmpty ==
                                                            true
                                                        ? ["no variation"]
                                                        : Provider11.starter![
                                                                    index]
                                                                ['attributes']
                                                            [0]['options'],
                                                    price: Provider11
                                                            .starter![index]
                                                        ['price'],
                                                  )));
                                    } else {
                                      //  for (var i = 0; i < Provider11.options.length; i++) {
                                      //    Provider11.p.add("${Provider11.options[i]} ${Provider11.prices1[i]}");
                                      //  }
                                      //   print("done2");
                                      //  await Future.delayed(Duration(seconds:1));
                                    await EasyLoading.show(status: 'wait...');
                                      await fn();
                                      await Future.delayed(
                                          Duration(seconds: 3));
                                    
                                      try {
                                        await Provider11.makeClass();
                                      } catch (e) {
                                        print("${e} error is heree");
                                      }
                                      await Future.delayed(
                                          Duration(microseconds: 1000));
                                      if (Provider11
                                                  .starter![index]['variations']
                                                  .isEmpty ==
                                              false &&
                                          Provider11.options.isEmpty == false) {
                                        Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation,
                                                        secondaryAnimation) =>
                                                    DisplayProduct(
                                                      imgAddress: Provider11
                                                              .starter![index]
                                                                  ['images']
                                                              .isEmpty
                                                          ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                          : Provider11.starter![
                                                                      index]
                                                                  ['images'][0]
                                                              ['src'],
                                                      title: Provider11
                                                              .starter![index]
                                                          ['name'],
                                                      variation: Provider11
                                                                  .starter![
                                                                      index][
                                                                      'attributes']
                                                                  .isEmpty ==
                                                              true
                                                          ? ["no variation"]
                                                          : Provider11.starter![
                                                                      index]
                                                                  ['attributes']
                                                              [0]['options'],
                                                      price: Provider11
                                                              .starter![index]
                                                          ['price'],
                                                    )));
                                      } else {
                                        print("netwok error");
                                         await EasyLoading.showError(
                                            "Network Problem");
                                      
                                        Provider11.options.clear();
                                        Provider11.prices1.clear();
                                      }
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Products(
                                      imgAddress: Provider11
                                              .starter![index]['images'].isEmpty
                                          ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                          : Provider11.starter![index]['images']
                                              [0]['src'],
                                      price: Provider11.starter![index]['price']
                                          .toString(),
                                      title: Provider11.starter![index]['name']
                                          .toString(),
                                    ),
                                  ),
                                );
                              });
                        }),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Multi(
                              color: Colors.white,
                              subtitle: "Chicken Koyla Karahi",
                              weight: FontWeight.bold,
                              size: 18),
                          Container()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Container(
                        height: 250.h,
                        child: FutureBuilder(builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error"),
                            );
                          }

                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Provider11.ck!.length,
                              itemBuilder: (BuildContext context, int index) {
                                print(index);
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Products(
                                    imgAddress: Provider11
                                            .ck![index]['images'].isEmpty
                                        ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                        : Provider11.ck![index]['images'][0]
                                            ['src'],
                                    price: Provider11.ck![index]['price']
                                        .toString(),
                                    title: Provider11.ck![index]['name']
                                        .toString(),
                                  ),
                                );
                              });
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Multi(
                              color: Colors.white,
                              subtitle: "Chicken Tikka",
                              weight: FontWeight.bold,
                              size: 18),
                          Container()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Container(
                        height: 250.h,
                        child: FutureBuilder(builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error"),
                            );
                          }

                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Provider11.ct!.length,
                              itemBuilder: (BuildContext context, int index) {
                                print(index);
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Products(
                                    imgAddress: Provider11
                                            .ct![index]['images'].isEmpty
                                        ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                        : Provider11.ct![index]['images'][0]
                                            ['src'],
                                    price: Provider11.ct![index]['price']
                                        .toString(),
                                    title: Provider11.ct![index]['name']
                                        .toString(),
                                  ),
                                );
                              });
                        }),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Multi(
                              color: Colors.white,
                              subtitle: "Mutton Kolya Karahi",
                              weight: FontWeight.bold,
                              size: 18),
                          Container()
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 15.w),
                      child: Container(
                        height: 250.h,
                        child: FutureBuilder(builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasError) {
                            return Center(
                              child: Text("Error"),
                            );
                          }

                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: Provider11.mk!.length,
                              itemBuilder: (BuildContext context, int index) {
                                print(index);
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Products(
                                    imgAddress: Provider11
                                            .mk![index]['images'].isEmpty
                                        ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                        : Provider11.mk![index]['images'][0]
                                            ['src'],
                                    price: Provider11.mk![index]['price']
                                        .toString(),
                                    title: Provider11.mk![index]['name']
                                        .toString(),
                                  ),
                                );
                              });
                        }),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
