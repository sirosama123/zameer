import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:woocommerce_api/woocommerce_api.dart';
import 'package:zameer/pages/cartList.dart';
import 'package:zameer/pages/displayProduct2.dart';
import 'package:zameer/pages/displayProduct3.dart';
import 'package:zameer/provider/provider1.dart';
import 'package:zameer/utils/multiText.dart';
import 'package:http/http.dart' as http;
import '../utils/categories.dart';
import '../utils/displayProduct.dart';
import '../utils/multi3.dart';
import '../utils/multi5.dart';
import '../utils/products.dart';
import '../utils/special.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  bool val = false;
  late Future<List<dynamic>> _futureCategories;

  final _searchController = TextEditingController();
  final WooCommerceAPI wc = WooCommerceAPI(
    consumerKey: 'ck_b8a58a9620e9f44935ece14278bc9df3ead71632',
    consumerSecret: 'cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39',
    url: 'https://zameeransari.com.pk',
  );

  Future<List<dynamic>> fetchCategories() async {
    int page = 1;
    int perPage = 100;
    final List<dynamic> categories = await wc.getAsync(
      'products?per_page=$perPage&page=$page',
    );
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
        floatingActionButton: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        CartList()));
          },
          child: Align(
            alignment: Alignment.bottomRight,
            child: CircleAvatar(
              radius: 25.r,
              child: Stack(
                children: [
                  CircleAvatar(
                      radius: 60,
                      backgroundColor: Colors.white,
                      child: Image.asset("assets/cart4.png",
                          height: 60.h, width: 60.w)),
                  Align(
                      alignment: Alignment.topRight,
                      child: CircleAvatar(
                        backgroundColor: Colors.amber,
                        radius: 8.r,
                        child: Multi(
                            color: Colors.white,
                            subtitle: "${Provider11.itemLength}",
                            weight: FontWeight.w800,
                            size: 10),
                      )),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Colors.black,
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:[
                    CircleAvatar(
                      radius:35.r,
                      backgroundColor:Colors.white,
                      child:Image.asset("assets/user.png",height:55.h,width:55.w)
                    ),
                    Multi3(color: Colors.white, subtitle: "${Provider11.name}", weight: FontWeight.normal, size: 12),
                    Multi(color: Colors.white, subtitle: "${Provider11.gmail}", weight: FontWeight.normal, size: 12)
                  ]
                ),
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 31, 30, 30),
                  Color.fromARGB(255, 23, 23, 23),
                ])),
              ),
              ListTile(
                leading: Icon(Icons.home,color:Color.fromARGB(255, 23, 23, 23)),
                title: Text('Address'),
                onTap: () {
                },
              ),
              ListTile(
                leading: Image.asset("assets/track.png",height:25.h,width:25.w),
                title: Text('Track Order'),
                onTap: () {
                },
              ),
               ListTile(
                leading: Icon(Icons.history,color:Color.fromARGB(255, 23, 23, 23)),
                title: Text('Order History'),
                onTap: () {
                },
              ),
               ListTile(
                leading: Icon(Icons.menu,color:Color.fromARGB(255, 23, 23, 23)),
                title: Text('Download Menu'),
                onTap: () {
                },
              ),
               ListTile(
                leading: Icon(Icons.qr_code,color:Color.fromARGB(255, 23, 23, 23)),
                title: Text('Scan QR'),
                onTap: () {
                },
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal:10.w),
                child: Container(
                          height: 48.h,
                          width: 312.w,
                          child: 
                              ElevatedButton(
                                  onPressed: () async {
                                   
                                  },
                                  child: Text("Log out"),
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Color(0xff1C1C1C)),
                                  ),
                                )
                             ),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: Container(
            child: Stack(
              fit: StackFit.expand,
              children: [
                ListView(
                  controller: scrollController,
                  children: [
                    Container(height: 180.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          color: Colors.black,
                          child: Container(
                            height: 40.h,
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
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      val = true;
                                    });
                                  },
                                  child: TextField(
                                    enabled: val,
                                    controller: _searchController,
                                    onChanged: (value) {
                                      setState(() {
                                        val = true;
                                      });
                                    },
                                    decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.search_outlined,
                                          color: Color(0xffCC0006),
                                          size: 28,
                                          weight: 200,
                                        ),
                                        suffixIcon: val == false
                                            ? Container()
                                            : IconButton(
                                                icon: Icon(
                                                  Icons.cancel,
                                                  color: Color(0xffCC0006),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    val = false;
                                                  });
                                                  _searchController.clear();
                                                },
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
                    ),
                    val == true
                        ? FutureBuilder(
                            future: fetchCategories(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                final List<dynamic>? categories =
                                    snapshot.data as List<dynamic>;
                                final filteredCategories = categories!.where(
                                    (category) => category['name']
                                        .toLowerCase()
                                        .contains(_searchController.text
                                            .toLowerCase()));
                                return ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: filteredCategories.length,
                                  itemBuilder: (context, index) {
                                    final category =
                                        filteredCategories.elementAt(index);
                                    fn() {
                                      for (var i = 0;
                                          i < category['variations'].length;
                                          i++) {
                                        Provider11.getData(
                                            category['variations'][i]
                                                .toString());
                                        //  Provider11.options.add(Provider11.today![index]['attributes'][0]['options'][i]);
                                      }
                                    }

                                    return GestureDetector(
                                      onTap: () {
                                        print(category['variations']);
                                      },
                                      child: GestureDetector(
                                        onTap: () async {
                                          if (category['variations'].isEmpty ==
                                              true) {
                                            await Future.delayed(
                                                Duration(seconds: 1));
                                            await Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        DisplayProduct3(
                                                          imgAddress:
                                                              category['images']
                                                                  [0]['src'],
                                                          title:
                                                              category['name'],
                                                          price:
                                                              category['price'],
                                                          stock: category[
                                                              'stock_status'],
                                                          tax: category[
                                                              'tax_status'], id: category['id'],
                                                        )));
                                          } else {
                                            await EasyLoading.show(
                                                status: 'wait...');
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

                                            if (category['variations']
                                                        .isEmpty ==
                                                    false &&
                                                Provider11.options.isEmpty ==
                                                    false) {
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                      pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) =>
                                                          DisplayProduct2(
                                                            imgAddress: category[
                                                                        'images']
                                                                    .isEmpty
                                                                ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                                : category[
                                                                        'images']
                                                                    [0]['src'],
                                                            title: category[
                                                                'name'],
                                                            price: category[
                                                                'price'],
                                                            stock: category[
                                                                'stock_status'],
                                                            tax: category[
                                                                'tax_status'], id: category[
                                                                'id'],
                                                          )));
                                              await EasyLoading.showSuccess(
                                                  "Enjoy");
                                            } else {
                                              print("netwok error");
                                              await EasyLoading.showError(
                                                  "Network Problem");

                                              Provider11.options.clear();
                                              Provider11.prices1.clear();
                                            }
                                          }
                                        },
                                        child: ListTile(
                                          title: Multi5(
                                              color: Colors.white,
                                              subtitle: category['name'],
                                              weight: FontWeight.bold,
                                              size: 12),
                                          subtitle: Multi5(
                                              color: Colors.white,
                                              subtitle:
                                                  "Rs ${category['price']}",
                                              weight: FontWeight.bold,
                                              size: 10),
                                          trailing: Container(
                                              width: 100.h,
                                              height: 100.w,
                                              decoration: new BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(7.r),
                                                image: new DecorationImage(
                                                  image: NetworkImage(
                                                      category['images'][0]
                                                          ['src']),
                                                  fit: BoxFit.fitHeight,
                                                ),
                                              )),
                                        ),
                                      ),
                                    );
                                  },
                                );
                              } else if (snapshot.hasError) {
                                return Text('${snapshot.error}');
                              }
                              return Center(
                                  child: CircularProgressIndicator(
                                color: Colors.white,
                              ));
                            },
                          )
                        : SingleChildScrollView(
                            child: Column(children: [
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              FutureBuilder(
                                  // future: Beef(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text("Error"),
                                  );
                                }

                                return GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: Provider11.today!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    print(index);
                                    fn() {
                                      for (var i = 0;
                                          i <
                                              Provider11
                                                  .today![index]['variations']
                                                  .length;
                                          i++) {
                                        Provider11.getData(Provider11
                                            .today![index]['variations'][i]
                                            .toString());
                                        //  Provider11.options.add(Provider11.today![index]['attributes'][0]['options'][i]);
                                      }
                                    }

                                    return GestureDetector(
                                      onTap: () async {
                                        if (Provider11
                                                .today![index]['variations']
                                                .isEmpty ==
                                            true) {
                                          await Future.delayed(
                                              Duration(seconds: 1));
                                          await Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      DisplayProduct3(
                                                        imgAddress: Provider11
                                                                .today![index]
                                                                    ['images']
                                                                .isEmpty
                                                            ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                            : Provider11.today![
                                                                        index]
                                                                    ['images']
                                                                [0]['src'],
                                                        title: Provider11
                                                                .today![index]
                                                            ['name'],
                                                        price: Provider11
                                                                .today![index]
                                                            ['price'],
                                                        stock: Provider11
                                                                .today![index]
                                                            ['stock_status'],
                                                        tax: Provider11
                                                                .today![index]
                                                            ['tax_status'], id: Provider11
                                                                .today![index]
                                                                    ['id'],
                                                      )));
                                        } else {
                                          await EasyLoading.show(
                                              status: 'wait...');
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
                                                      .today![index]
                                                          ['variations']
                                                      .isEmpty ==
                                                  false &&
                                              Provider11.options.isEmpty ==
                                                  false) {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        DisplayProduct2(
                                                          imgAddress: Provider11
                                                                  .today![index]
                                                                      ['images']
                                                                  .isEmpty
                                                              ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                              : Provider11.today![
                                                                          index]
                                                                      ['images']
                                                                  [0]['src'],
                                                          title: Provider11
                                                                  .today![index]
                                                              ['name'],
                                                          price: Provider11
                                                                  .today![index]
                                                              ['price'],
                                                          stock: Provider11
                                                                  .today![index]
                                                              ['stock_status'],
                                                          tax: Provider11
                                                                  .today![index]
                                                              ['tax_status'], id: Provider11
                                                                  .today![index]
                                                                      ['id'],
                                                        )));
                                            await EasyLoading.showSuccess(
                                                "Enjoy");
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
                                        child: Special(
                                          imgAddress: Provider11
                                                  .today![index]['images']
                                                  .isEmpty
                                              ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                              : Provider11.today![index]
                                                  ['images'][0]['src'],
                                          price: Provider11.today![index]
                                                  ['price']
                                              .toString(),
                                          title: Provider11.today![index]
                                                  ['name']
                                              .toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 210.h,
                                    crossAxisCount: 2,
                                  ),
                                  physics: BouncingScrollPhysics(),
                                );
                              }),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisSpacing: 10,
                                    mainAxisSpacing: 10,
                                    mainAxisExtent: 210.h,
                                    crossAxisCount: 2,
                                  ),
                                  physics: BouncingScrollPhysics(),
                                  itemCount: Provider11.beef!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    print(index);
                                    fn() {
                                      for (var i = 0;
                                          i <
                                              Provider11
                                                  .beef![index]['variations']
                                                  .length;
                                          i++) {
                                        Provider11.getData(Provider11
                                            .beef![index]['variations'][i]
                                            .toString());
                                        //  Provider11.options.add(Provider11.today![index]['attributes'][0]['options'][i]);
                                      }
                                    }

                                    return GestureDetector(
                                      onTap: () async {
                                        if (Provider11
                                                .beef![index]['variations']
                                                .isEmpty ==
                                            true) {
                                          Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      DisplayProduct3(
                                                        imgAddress: Provider11
                                                                .beef![index]
                                                                    ['images']
                                                                .isEmpty
                                                            ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                            : Provider11.beef![
                                                                        index]
                                                                    ['images']
                                                                [0]['src'],
                                                        title: Provider11
                                                                .beef![index]
                                                            ['name'],
                                                        price: Provider11
                                                                .beef![index]
                                                            ['price'],
                                                        stock: Provider11
                                                                .beef![index]
                                                            ['stock_status'],
                                                        tax: Provider11
                                                                .beef![index]
                                                            ['tax_status'], id: Provider11
                                                                .beef![index]
                                                                    ['id'],
                                                      )));
                                        } else {
                                          //  for (var i = 0; i < Provider11.options.length; i++) {
                                          //    Provider11.p.add("${Provider11.options[i]} ${Provider11.prices1[i]}");
                                          //  }
                                          //   print("done2");
                                          //  await Future.delayed(Duration(seconds:1));
                                          await EasyLoading.show(
                                              status: 'wait...');
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
                                                      .beef![index]
                                                          ['variations']
                                                      .isEmpty ==
                                                  false &&
                                              Provider11.options.isEmpty ==
                                                  false) {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        DisplayProduct2(
                                                          imgAddress: Provider11
                                                                  .beef![index]
                                                                      ['images']
                                                                  .isEmpty
                                                              ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                              : Provider11.beef![
                                                                          index]
                                                                      ['images']
                                                                  [0]['src'],
                                                          title: Provider11
                                                                  .beef![index]
                                                              ['name'],
                                                          price: Provider11
                                                                  .beef![index]
                                                              ['price'],
                                                          stock: Provider11
                                                                  .beef![index]
                                                              ['stock_status'],
                                                          tax: Provider11
                                                                  .beef![index]
                                                              ['tax_status'], id: Provider11
                                                                  .beef![index]
                                                                      ['id'],
                                                        )));
                                            await EasyLoading.showSuccess(
                                                "Enjoy");
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
                                        child: Special(
                                          imgAddress: Provider11
                                                  .beef![index]['images']
                                                  .isEmpty
                                              ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                              : Provider11.beef![index]
                                                  ['images'][0]['src'],
                                          price: Provider11.beef![index]
                                                  ['price']
                                              .toString(),
                                          title: Provider11.beef![index]['name']
                                              .toString(),
                                        ),
                                      ),
                                    );
                                  }),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              FutureBuilder(builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text("Error"),
                                  );
                                }

                                return GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 210.h,
                                      crossAxisCount: 2,
                                    ),
                                    physics: BouncingScrollPhysics(),
                                    itemCount: Provider11.mutton!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      fn() {
                                        for (var i = 0;
                                            i <
                                                Provider11
                                                    .mutton![index]
                                                        ['variations']
                                                    .length;
                                            i++) {
                                          Provider11.getData(Provider11
                                              .mutton![index]['variations'][i]
                                              .toString());
                                          //  Provider11.options.add(Provider11.today![index]['attributes'][0]['options'][i]);
                                        }
                                      }

                                      print(index);
                                      return GestureDetector(
                                        onTap: () async {
                                          if (Provider11
                                                  .mutton![index]['variations']
                                                  .isEmpty ==
                                              true) {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        DisplayProduct3(
                                                          imgAddress: Provider11
                                                                  .mutton![
                                                                      index]
                                                                      ['images']
                                                                  .isEmpty
                                                              ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                              : Provider11.mutton![
                                                                          index]
                                                                      ['images']
                                                                  [0]['src'],
                                                          title: Provider11
                                                                  .mutton![
                                                              index]['name'],
                                                          price: Provider11
                                                                  .mutton![
                                                              index]['price'],
                                                          stock: Provider11
                                                                      .mutton![
                                                                  index]
                                                              ['stock_status'],
                                                          tax: Provider11
                                                                      .mutton![
                                                                  index]
                                                              ['tax_status'], id: Provider11
                                                                  .mutton![
                                                                      index]
                                                                      ['id'],
                                                        )));
                                          } else {
                                            //  for (var i = 0; i < Provider11.options.length; i++) {
                                            //    Provider11.p.add("${Provider11.options[i]} ${Provider11.prices1[i]}");
                                            //  }
                                            //   print("done2");
                                            //  await Future.delayed(Duration(seconds:1));
                                            await EasyLoading.show(
                                                status: 'wait...');
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
                                                        .mutton![index]
                                                            ['variations']
                                                        .isEmpty ==
                                                    false &&
                                                Provider11.options.isEmpty ==
                                                    false) {
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                      pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) =>
                                                          DisplayProduct2(
                                                            imgAddress: Provider11
                                                                    .mutton![
                                                                        index][
                                                                        'images']
                                                                    .isEmpty
                                                                ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                                : Provider11.mutton![
                                                                            index]
                                                                        [
                                                                        'images']
                                                                    [0]['src'],
                                                            title: Provider11
                                                                    .mutton![
                                                                index]['name'],
                                                            price: Provider11
                                                                    .mutton![
                                                                index]['price'],
                                                            stock: Provider11
                                                                        .mutton![
                                                                    index][
                                                                'stock_status'],
                                                            tax: Provider11
                                                                        .mutton![
                                                                    index]
                                                                ['tax_status'], id: Provider11
                                                                        .mutton![
                                                                    index]
                                                                ['id'],
                                                          )));
                                              await EasyLoading.showSuccess(
                                                  "Enjoy");
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
                                          child: Special(
                                            imgAddress: Provider11
                                                    .mutton![index]['images']
                                                    .isEmpty
                                                ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                : Provider11.mutton![index]
                                                    ['images'][0]['src'],
                                            price: Provider11.mutton![index]
                                                    ['price']
                                                .toString(),
                                            title: Provider11.mutton![index]
                                                    ['name']
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    });
                              }),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              FutureBuilder(builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text("Error"),
                                  );
                                }

                                return GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 210.h,
                                      crossAxisCount: 2,
                                    ),
                                    physics: BouncingScrollPhysics(),
                                    itemCount: Provider11.chicken!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      fn() {
                                        for (var i = 0;
                                            i <
                                                Provider11
                                                    .chicken![index]
                                                        ['variations']
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
                                          if (Provider11
                                                  .chicken![index]['variations']
                                                  .isEmpty ==
                                              true) {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        DisplayProduct3(
                                                          imgAddress: Provider11
                                                                  .chicken![
                                                                      index]
                                                                      ['images']
                                                                  .isEmpty
                                                              ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                              : Provider11.chicken![
                                                                          index]
                                                                      ['images']
                                                                  [0]['src'],
                                                          title: Provider11
                                                                  .chicken![
                                                              index]['name'],
                                                          price: Provider11
                                                                  .chicken![
                                                              index]['price'],
                                                          stock: Provider11
                                                                      .chicken![
                                                                  index]
                                                              ['stock_status'],
                                                          tax: Provider11
                                                                      .chicken![
                                                                  index]
                                                              ['tax_status'], id: Provider11
                                                                  .chicken![
                                                                      index]
                                                                      ['id'],
                                                        )));
                                            await EasyLoading.showSuccess(
                                                "Enjoy");
                                          } else {
                                            //  for (var i = 0; i < Provider11.options.length; i++) {
                                            //    Provider11.p.add("${Provider11.options[i]} ${Provider11.prices1[i]}");
                                            //  }
                                            //   print("done2");
                                            //  await Future.delayed(Duration(seconds:1));
                                            await EasyLoading.show(
                                                status: 'wait...');
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
                                                        .chicken![index]
                                                            ['variations']
                                                        .isEmpty ==
                                                    false &&
                                                Provider11.options.isEmpty ==
                                                    false) {
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                      pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) =>
                                                          DisplayProduct2(
                                                            imgAddress: Provider11
                                                                    .today![
                                                                        index][
                                                                        'images']
                                                                    .isEmpty
                                                                ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                                : Provider11.today![
                                                                            index]
                                                                        [
                                                                        'images']
                                                                    [0]['src'],
                                                            title: Provider11
                                                                    .today![
                                                                index]['name'],
                                                            price: Provider11
                                                                    .today![
                                                                index]['price'],
                                                            stock: Provider11
                                                                        .today![
                                                                    index][
                                                                'stock_status'],
                                                            tax: Provider11
                                                                        .today![
                                                                    index]
                                                                ['tax_status'], id:  Provider11
                                                                    .today![
                                                                        index][
                                                                        'id'],
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
                                          child: Special(
                                            imgAddress: Provider11
                                                    .chicken![index]['images']
                                                    .isEmpty
                                                ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                : Provider11.chicken![index]
                                                    ['images'][0]['src'],
                                            price: Provider11.chicken![index]
                                                    ['price']
                                                .toString(),
                                            title: Provider11.chicken![index]
                                                    ['name']
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    });
                              }),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              FutureBuilder(builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text("Error"),
                                  );
                                }

                                return GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 210.h,
                                      crossAxisCount: 2,
                                    ),
                                    physics: BouncingScrollPhysics(),
                                    itemCount: Provider11.ct!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      print(index);
                                      fn() {
                                        for (var i = 0;
                                            i <
                                                Provider11
                                                    .ct![index]['variations']
                                                    .length;
                                            i++) {
                                          Provider11.getData(Provider11
                                              .ct![index]['variations'][i]
                                              .toString());
                                          //  Provider11.options.add(Provider11.today![index]['attributes'][0]['options'][i]);
                                        }
                                      }

                                      print(index);
                                      return GestureDetector(
                                        onTap: () async {
                                          if (Provider11
                                                  .ct![index]['variations']
                                                  .isEmpty ==
                                              true) {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        DisplayProduct3(
                                                          imgAddress: Provider11
                                                                  .ct![index]
                                                                      ['images']
                                                                  .isEmpty
                                                              ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                              : Provider11.ct![
                                                                          index]
                                                                      ['images']
                                                                  [0]['src'],
                                                          title: Provider11
                                                                  .ct![index]
                                                              ['name'],
                                                          price: Provider11
                                                                  .ct![index]
                                                              ['price'],
                                                          stock: Provider11
                                                                  .ct![index]
                                                              ['stock_status'],
                                                          tax: Provider11
                                                                  .ct![index]
                                                              ['tax_status'], id: Provider11
                                                                  .ct![index]
                                                                      ['id'],
                                                        )));
                                            await EasyLoading.showSuccess(
                                                "Enjoy");
                                          } else {
                                            //  for (var i = 0; i < Provider11.options.length; i++) {
                                            //    Provider11.p.add("${Provider11.options[i]} ${Provider11.prices1[i]}");
                                            //  }
                                            //   print("done2");
                                            //  await Future.delayed(Duration(seconds:1));
                                            await EasyLoading.show(
                                                status: 'wait...');
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
                                                        .ct![index]
                                                            ['variations']
                                                        .isEmpty ==
                                                    false &&
                                                Provider11.options.isEmpty ==
                                                    false) {
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                      pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) =>
                                                          DisplayProduct2(
                                                            imgAddress: Provider11
                                                                    .ct![index][
                                                                        'images']
                                                                    .isEmpty
                                                                ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                                : Provider11.ct![
                                                                            index]
                                                                        [
                                                                        'images']
                                                                    [0]['src'],
                                                            title: Provider11
                                                                    .ct![index]
                                                                ['name'],
                                                            price: Provider11
                                                                    .ct![index]
                                                                ['price'],
                                                            stock: Provider11
                                                                    .ct![index][
                                                                'stock_status'],
                                                            tax: Provider11
                                                                    .ct![index]
                                                                ['tax_status'], id:  Provider11
                                                                    .ct![index][
                                                                        'id'],
                                                          )));
                                              await EasyLoading.showSuccess(
                                                  "Enjoy");
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
                                          child: Special(
                                            imgAddress: Provider11
                                                    .ct![index]['images']
                                                    .isEmpty
                                                ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                : Provider11.ct![index]
                                                    ['images'][0]['src'],
                                            price: Provider11.ct![index]
                                                    ['price']
                                                .toString(),
                                            title: Provider11.ct![index]['name']
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    });
                              }),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              FutureBuilder(builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text("Error"),
                                  );
                                }

                                return GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 210.h,
                                      crossAxisCount: 2,
                                    ),
                                    physics: BouncingScrollPhysics(),
                                    itemCount: Provider11.beverage!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      print(index);
                                      fn() {
                                        for (var i = 0;
                                            i <
                                                Provider11
                                                    .beverage![index]
                                                        ['variations']
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
                                                  .beverage![index]
                                                      ['variations']
                                                  .isEmpty ==
                                              true) {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        DisplayProduct3(
                                                          imgAddress: Provider11
                                                                  .beverage![
                                                                      index]
                                                                      ['images']
                                                                  .isEmpty
                                                              ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                              : Provider11.beverage![
                                                                          index]
                                                                      ['images']
                                                                  [0]['src'],
                                                          title: Provider11
                                                                  .beverage![
                                                              index]['name'],
                                                          price: Provider11
                                                                  .beverage![
                                                              index]['price'],
                                                          stock: Provider11
                                                                      .beverage![
                                                                  index]
                                                              ['stock_status'],
                                                          tax: Provider11
                                                                      .beverage![
                                                                  index]
                                                              ['tax_status'], id: Provider11
                                                                  .beverage![
                                                                      index]
                                                                      ['id'],
                                                        )));
                                            await EasyLoading.showSuccess(
                                                "Enjoy");
                                          } else {
                                            //  for (var i = 0; i < Provider11.options.length; i++) {
                                            //    Provider11.p.add("${Provider11.options[i]} ${Provider11.prices1[i]}");
                                            //  }
                                            //   print("done2");
                                            //  await Future.delayed(Duration(seconds:1));
                                            await EasyLoading.show(
                                                status: 'wait...');
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
                                                Provider11.options.isEmpty ==
                                                    false) {
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                      pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) =>
                                                          DisplayProduct2(
                                                            imgAddress: Provider11
                                                                    .beverage![
                                                                        index][
                                                                        'images']
                                                                    .isEmpty
                                                                ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                                : Provider11.beverage![
                                                                            index]
                                                                        [
                                                                        'images']
                                                                    [0]['src'],
                                                            title: Provider11
                                                                    .beverage![
                                                                index]['name'],
                                                            price: Provider11
                                                                    .beverage![
                                                                index]['price'],
                                                            stock: Provider11
                                                                        .beverage![
                                                                    index][
                                                                'stock_status'],
                                                            tax: Provider11
                                                                        .beverage![
                                                                    index]
                                                                ['tax_status'], id:  Provider11
                                                                    .beverage![
                                                                        index][
                                                                        'id'],
                                                          )));
                                                          await EasyLoading.showSuccess(
                                                "Enjoy");
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
                                          child: Special(
                                            imgAddress: Provider11
                                                    .beverage![index]['images']
                                                    .isEmpty
                                                ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                : Provider11.beverage![index]
                                                    ['images'][0]['src'],
                                            price: Provider11.beverage![index]
                                                    ['price']
                                                .toString(),
                                            title: Provider11.beverage![index]
                                                    ['name']
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    });
                              }),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              FutureBuilder(builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text("Error"),
                                  );
                                }

                                return GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 210.h,
                                      crossAxisCount: 2,
                                    ),
                                    physics: BouncingScrollPhysics(),
                                    itemCount: Provider11.roll!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      print(index);
                                      fn() {
                                        for (var i = 0;
                                            i <
                                                Provider11
                                                    .roll![index]['variations']
                                                    .length;
                                            i++) {
                                          Provider11.getData(Provider11
                                              .roll![index]['variations'][i]
                                              .toString());
                                          //  Provider11.options.add(Provider11.today![index]['attributes'][0]['options'][i]);
                                        }
                                      }

                                      print(index);
                                      return GestureDetector(
                                        onTap: () async {
                                          if (Provider11
                                                  .roll![index]['variations']
                                                  .isEmpty ==
                                              true) {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        DisplayProduct3(
                                                          imgAddress: Provider11
                                                                  .roll![index]
                                                                      ['images']
                                                                  .isEmpty
                                                              ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                              : Provider11.roll![
                                                                          index]
                                                                      ['images']
                                                                  [0]['src'],
                                                          title: Provider11
                                                                  .roll![index]
                                                              ['name'],
                                                          price: Provider11
                                                                  .roll![index]
                                                              ['price'],
                                                          stock: Provider11
                                                                  .roll![index]
                                                              ['stock_status'],
                                                          tax: Provider11
                                                                  .roll![index]
                                                              ['tax_status'], id: Provider11
                                                                  .roll![index]
                                                                      ['id'],
                                                        )));
                                            await EasyLoading.showSuccess(
                                                "Enjoy");
                                          } else {
                                            //  for (var i = 0; i < Provider11.options.length; i++) {
                                            //    Provider11.p.add("${Provider11.options[i]} ${Provider11.prices1[i]}");
                                            //  }
                                            //   print("done2");
                                            //  await Future.delayed(Duration(seconds:1));
                                            await EasyLoading.show(
                                                status: 'wait...');
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
                                                        .roll![index]
                                                            ['variations']
                                                        .isEmpty ==
                                                    false &&
                                                Provider11.options.isEmpty ==
                                                    false) {
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                      pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) =>
                                                          DisplayProduct2(
                                                            imgAddress: Provider11
                                                                    .roll![
                                                                        index][
                                                                        'images']
                                                                    .isEmpty
                                                                ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                                : Provider11.roll![
                                                                            index]
                                                                        [
                                                                        'images']
                                                                    [0]['src'],
                                                            title: Provider11
                                                                    .roll![
                                                                index]['name'],
                                                            price: Provider11
                                                                    .roll![
                                                                index]['price'],
                                                            stock: Provider11
                                                                        .roll![
                                                                    index][
                                                                'stock_status'],
                                                            tax: Provider11
                                                                        .roll![
                                                                    index]
                                                                ['tax_status'], id: Provider11
                                                                    .roll![
                                                                        index][
                                                                        'id'],
                                                          )));
                                                          await EasyLoading.showSuccess(
                                                "Enjoy");
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
                                          child: Special(
                                            imgAddress: Provider11
                                                    .roll![index]['images']
                                                    .isEmpty
                                                ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                : Provider11.roll![index]
                                                    ['images'][0]['src'],
                                            price: Provider11.roll![index]
                                                    ['price']
                                                .toString(),
                                            title: Provider11.roll![index]
                                                    ['name']
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    });
                              }),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              FutureBuilder(builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text("Error"),
                                  );
                                }

                                return GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 210.h,
                                      crossAxisCount: 2,
                                    ),
                                    physics: BouncingScrollPhysics(),
                                    itemCount: Provider11.addon!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      print(index);
                                      fn() {
                                        for (var i = 0;
                                            i <
                                                Provider11
                                                    .addon![index]['variations']
                                                    .length;
                                            i++) {
                                          Provider11.getData(Provider11
                                              .addon![index]['variations'][i]
                                              .toString());
                                          //  Provider11.options.add(Provider11.today![index]['attributes'][0]['options'][i]);
                                        }
                                      }

                                      print(index);
                                      return GestureDetector(
                                        onTap: () async {
                                          if (Provider11
                                                  .addon![index]['variations']
                                                  .isEmpty ==
                                              true) {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        DisplayProduct3(
                                                          imgAddress: Provider11
                                                                  .addon![index]
                                                                      ['images']
                                                                  .isEmpty
                                                              ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                              : Provider11.addon![
                                                                          index]
                                                                      ['images']
                                                                  [0]['src'],
                                                          title: Provider11
                                                                  .addon![index]
                                                              ['name'],
                                                          price: Provider11
                                                                  .addon![index]
                                                              ['price'],
                                                          stock: Provider11
                                                                  .addon![index]
                                                              ['stock_status'],
                                                          tax: Provider11
                                                                  .addon![index]
                                                              ['tax_status'], id:  Provider11
                                                                  .addon![index]
                                                                      ['id'],
                                                        )));
                                            await EasyLoading.showSuccess(
                                                "Enjoy");
                                          } else {
                                            //  for (var i = 0; i < Provider11.options.length; i++) {
                                            //    Provider11.p.add("${Provider11.options[i]} ${Provider11.prices1[i]}");
                                            //  }
                                            //   print("done2");
                                            //  await Future.delayed(Duration(seconds:1));
                                            await EasyLoading.show(
                                                status: 'wait...');
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
                                                        .addon![index]
                                                            ['variations']
                                                        .isEmpty ==
                                                    false &&
                                                Provider11.options.isEmpty ==
                                                    false) {
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                      pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) =>
                                                          DisplayProduct2(
                                                            imgAddress: Provider11
                                                                    .addon![
                                                                        index][
                                                                        'images']
                                                                    .isEmpty
                                                                ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                                : Provider11.addon![
                                                                            index]
                                                                        [
                                                                        'images']
                                                                    [0]['src'],
                                                            title: Provider11
                                                                    .addon![
                                                                index]['name'],
                                                            price: Provider11
                                                                    .addon![
                                                                index]['price'],
                                                            stock: Provider11
                                                                        .addon![
                                                                    index][
                                                                'stock_status'],
                                                            tax: Provider11
                                                                        .addon![
                                                                    index]
                                                                ['tax_status'], id:  Provider11
                                                                    .addon![
                                                                        index][
                                                                        'id'],
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
                                          child: Special(
                                            imgAddress: Provider11
                                                    .addon![index]['images']
                                                    .isEmpty
                                                ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                : Provider11.addon![index]
                                                    ['images'][0]['src'],
                                            price: Provider11.addon![index]
                                                    ['price']
                                                .toString(),
                                            title: Provider11.addon![index]
                                                    ['name']
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    });
                              }),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              FutureBuilder(builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text("Error"),
                                  );
                                }

                                return GridView.builder(
                                    shrinkWrap: true,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      mainAxisExtent: 210.h,
                                      crossAxisCount: 2,
                                    ),
                                    physics: BouncingScrollPhysics(),
                                    itemCount: Provider11.starter!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      print(index);
                                      fn() {
                                        for (var i = 0;
                                            i <
                                                Provider11
                                                    .starter![index]
                                                        ['variations']
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
                                          if (Provider11
                                                  .starter![index]['variations']
                                                  .isEmpty ==
                                              true) {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        DisplayProduct3(
                                                          imgAddress: Provider11
                                                                  .starter![
                                                                      index]
                                                                      ['images']
                                                                  .isEmpty
                                                              ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                              : Provider11.starter![
                                                                          index]
                                                                      ['images']
                                                                  [0]['src'],
                                                          title: Provider11
                                                                  .starter![
                                                              index]['name'],
                                                          price: Provider11
                                                                  .starter![
                                                              index]['price'],
                                                          stock: Provider11
                                                                      .starter![
                                                                  index]
                                                              ['stock_status'],
                                                          tax: Provider11
                                                                      .starter![
                                                                  index]
                                                              ['tax_status'], id: Provider11
                                                                  .starter![
                                                                      index]
                                                                      ['id'],
                                                        )));
                                          } else {
                                            //  for (var i = 0; i < Provider11.options.length; i++) {
                                            //    Provider11.p.add("${Provider11.options[i]} ${Provider11.prices1[i]}");
                                            //  }
                                            //   print("done2");
                                            //  await Future.delayed(Duration(seconds:1));
                                            await EasyLoading.show(
                                                status: 'wait...');
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
                                                        .starter![index]
                                                            ['variations']
                                                        .isEmpty ==
                                                    false &&
                                                Provider11.options.isEmpty ==
                                                    false) {
                                              Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                      pageBuilder: (context,
                                                              animation,
                                                              secondaryAnimation) =>
                                                          DisplayProduct2(
                                                            imgAddress: Provider11
                                                                    .starter![
                                                                        index][
                                                                        'images']
                                                                    .isEmpty
                                                                ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                                : Provider11.starter![
                                                                            index]
                                                                        [
                                                                        'images']
                                                                    [0]['src'],
                                                            title: Provider11
                                                                    .starter![
                                                                index]['name'],
                                                            price: Provider11
                                                                    .starter![
                                                                index]['price'],
                                                            stock: Provider11
                                                                        .starter![
                                                                    index][
                                                                'stock_status'],
                                                            tax: Provider11
                                                                        .starter![
                                                                    index]
                                                                ['tax_status'], id: Provider11
                                                                    .starter![
                                                                        index][
                                                                        'id'],
                                                          )));
                                              await EasyLoading.showSuccess(
                                                  "Enjoy");
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
                                          child: Special(
                                            imgAddress: Provider11
                                                    .starter![index]['images']
                                                    .isEmpty
                                                ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                : Provider11.starter![index]
                                                    ['images'][0]['src'],
                                            price: Provider11.starter![index]
                                                    ['price']
                                                .toString(),
                                            title: Provider11.starter![index]
                                                    ['name']
                                                .toString(),
                                          ),
                                        ),
                                      );
                                    });
                              }),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              FutureBuilder(
                                  // future: Beef(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text("Error"),
                                  );
                                }

                                return GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: Provider11.ck!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    print(index);
                                    fn() {
                                      for (var i = 0;
                                          i <
                                              Provider11
                                                  .ck![index]['variations']
                                                  .length;
                                          i++) {
                                        Provider11.getData(Provider11
                                            .ck![index]['variations'][i]
                                            .toString());
                                        //  Provider11.options.add(Provider11.today![index]['attributes'][0]['options'][i]);
                                      }
                                    }

                                    return GestureDetector(
                                      onTap: () async {
                                        if (Provider11
                                                .ck![index]['variations']
                                                .isEmpty ==
                                            true) {
                                          await Future.delayed(
                                              Duration(seconds: 1));
                                          await Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      DisplayProduct3(
                                                        imgAddress: Provider11
                                                                .ck![index]
                                                                    ['images']
                                                                .isEmpty
                                                            ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                            : Provider11.ck![
                                                                        index]
                                                                    ['images']
                                                                [0]['src'],
                                                        title: Provider11
                                                                .ck![index]
                                                            ['name'],
                                                        price: Provider11
                                                                .ck![index]
                                                            ['price'],
                                                        stock: Provider11
                                                                .ck![index]
                                                            ['stock_status'],
                                                        tax: Provider11
                                                                .ck![index]
                                                            ['tax_status'], id:  Provider11
                                                                .ck![index]
                                                                    ['id'],
                                                      )));
                                        } else {
                                          await EasyLoading.show(
                                              status: 'wait...');
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
                                                      .ck![index]
                                                          ['variations']
                                                      .isEmpty ==
                                                  false &&
                                              Provider11.options.isEmpty ==
                                                  false) {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        DisplayProduct2(
                                                          imgAddress: Provider11
                                                                  .ck![index]
                                                                      ['images']
                                                                  .isEmpty
                                                              ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                              : Provider11.ck![
                                                                          index]
                                                                      ['images']
                                                                  [0]['src'],
                                                          title: Provider11
                                                                  .ck![index]
                                                              ['name'],
                                                          price: Provider11
                                                                  .ck![index]
                                                              ['price'],
                                                          stock: Provider11
                                                                  .ck![index]
                                                              ['stock_status'],
                                                          tax: Provider11
                                                                  .ck![index]
                                                              ['tax_status'], id: Provider11
                                                                  .ck![index]
                                                                      ['id'],
                                                        )));
                                            await EasyLoading.showSuccess(
                                                "Enjoy");
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
                                        child: Special(
                                          imgAddress: Provider11
                                                  .mk![index]['images']
                                                  .isEmpty
                                              ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                              : Provider11.ck![index]
                                                  ['images'][0]['src'],
                                          price: Provider11.ck![index]
                                                  ['price']
                                              .toString(),
                                          title: Provider11.ck![index]
                                                  ['name']
                                              .toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 210.h,
                                    crossAxisCount: 2,
                                  ),
                                  physics: BouncingScrollPhysics(),
                                );
                              }),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                             FutureBuilder(
                                  // future: Beef(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text("Error"),
                                  );
                                }

                                return GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: Provider11.ct!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    print(index);
                                    fn() {
                                      for (var i = 0;
                                          i <
                                              Provider11
                                                  .ct![index]['variations']
                                                  .length;
                                          i++) {
                                        Provider11.getData(Provider11
                                            .ct![index]['variations'][i]
                                            .toString());
                                        //  Provider11.options.add(Provider11.today![index]['attributes'][0]['options'][i]);
                                      }
                                    }

                                    return GestureDetector(
                                      onTap: () async {
                                        if (Provider11
                                                .ct![index]['variations']
                                                .isEmpty ==
                                            true) {
                                          await Future.delayed(
                                              Duration(seconds: 1));
                                          await Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      DisplayProduct3(
                                                        imgAddress: Provider11
                                                                .ct![index]
                                                                    ['images']
                                                                .isEmpty
                                                            ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                            : Provider11.ct![
                                                                        index]
                                                                    ['images']
                                                                [0]['src'],
                                                        title: Provider11
                                                                .ct![index]
                                                            ['name'],
                                                        price: Provider11
                                                                .ct![index]
                                                            ['price'],
                                                        stock: Provider11
                                                                .ct![index]
                                                            ['stock_status'],
                                                        tax: Provider11
                                                                .ct![index]
                                                            ['tax_status'], id: Provider11
                                                                .ct![index]
                                                                    ['id'],
                                                      )));
                                        } else {
                                          await EasyLoading.show(
                                              status: 'wait...');
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
                                                      .ct![index]
                                                          ['variations']
                                                      .isEmpty ==
                                                  false &&
                                              Provider11.options.isEmpty ==
                                                  false) {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        DisplayProduct2(
                                                          imgAddress: Provider11
                                                                  .ct![index]
                                                                      ['images']
                                                                  .isEmpty
                                                              ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                              : Provider11.ct![
                                                                          index]
                                                                      ['images']
                                                                  [0]['src'],
                                                          title: Provider11
                                                                  .ct![index]
                                                              ['name'],
                                                          price: Provider11
                                                                  .ct![index]
                                                              ['price'],
                                                          stock: Provider11
                                                                  .ct![index]
                                                              ['stock_status'],
                                                          tax: Provider11
                                                                  .ct![index]
                                                              ['tax_status'], id:  Provider11
                                                                  .ct![index]
                                                                      ['id'],
                                                        )));
                                            await EasyLoading.showSuccess(
                                                "Enjoy");
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
                                        child: Special(
                                          imgAddress: Provider11
                                                  .ct![index]['images']
                                                  .isEmpty
                                              ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                              : Provider11.ct![index]
                                                  ['images'][0]['src'],
                                          price: Provider11.ct![index]
                                                  ['price']
                                              .toString(),
                                          title: Provider11.ct![index]
                                                  ['name']
                                              .toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 210.h,
                                    crossAxisCount: 2,
                                  ),
                                  physics: BouncingScrollPhysics(),
                                );
                              }),
                              SizedBox(
                                height: 10.h,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 15.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                              FutureBuilder(
                                  // future: Beef(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                if (snapshot.hasError) {
                                  return Center(
                                    child: Text("Error"),
                                  );
                                }

                                return GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: Provider11.mk!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    print(index);
                                    fn() {
                                      for (var i = 0;
                                          i <
                                              Provider11
                                                  .mk![index]['variations']
                                                  .length;
                                          i++) {
                                        Provider11.getData(Provider11
                                            .mk![index]['variations'][i]
                                            .toString());
                                        //  Provider11.options.add(Provider11.today![index]['attributes'][0]['options'][i]);
                                      }
                                    }

                                    return GestureDetector(
                                      onTap: () async {
                                        if (Provider11
                                                .mk![index]['variations']
                                                .isEmpty ==
                                            true) {
                                          await Future.delayed(
                                              Duration(seconds: 1));
                                          await Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                  pageBuilder: (context,
                                                          animation,
                                                          secondaryAnimation) =>
                                                      DisplayProduct3(
                                                        imgAddress: Provider11
                                                                .mk![index]
                                                                    ['images']
                                                                .isEmpty
                                                            ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                            : Provider11.mk![
                                                                        index]
                                                                    ['images']
                                                                [0]['src'],
                                                        title: Provider11
                                                                .mk![index]
                                                            ['name'],
                                                        price: Provider11
                                                                .mk![index]
                                                            ['price'],
                                                        stock: Provider11
                                                                .mk![index]
                                                            ['stock_status'],
                                                        tax: Provider11
                                                                .mk![index]
                                                            ['tax_status'], id: Provider11
                                                                .mk![index]
                                                                    ['id'],
                                                      )));
                                        } else {
                                          await EasyLoading.show(
                                              status: 'wait...');
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
                                                      .mk![index]
                                                          ['variations']
                                                      .isEmpty ==
                                                  false &&
                                              Provider11.options.isEmpty ==
                                                  false) {
                                            Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                    pageBuilder: (context,
                                                            animation,
                                                            secondaryAnimation) =>
                                                        DisplayProduct2(
                                                          imgAddress: Provider11
                                                                  .mk![index]
                                                                      ['images']
                                                                  .isEmpty
                                                              ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                                              : Provider11.mk![
                                                                          index]
                                                                      ['images']
                                                                  [0]['src'],
                                                          title: Provider11
                                                                  .mk![index]
                                                              ['name'],
                                                          price: Provider11
                                                                  .mk![index]
                                                              ['price'],
                                                          stock: Provider11
                                                                  .mk![index]
                                                              ['stock_status'],
                                                          tax: Provider11
                                                                  .mk![index]
                                                              ['tax_status'], id:  Provider11
                                                                  .mk![index]
                                                                      ['id'],
                                                        )));
                                            await EasyLoading.showSuccess(
                                                "Enjoy");
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
                                        child: Special(
                                          imgAddress: Provider11
                                                  .mk![index]['images']
                                                  .isEmpty
                                              ? "https://cdn.pixabay.com/photo/2017/01/11/11/33/cake-1971552_960_720.jpg"
                                              : Provider11.mk![index]
                                                  ['images'][0]['src'],
                                          price: Provider11.mk![index]
                                                  ['price']
                                              .toString(),
                                          title: Provider11.mk![index]
                                                  ['name']
                                              .toString(),
                                        ),
                                      ),
                                    );
                                  },
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    mainAxisExtent: 210.h,
                                    crossAxisCount: 2,
                                  ),
                                  physics: BouncingScrollPhysics(),
                                );
                              }),
                            ]),
                          )
                  ],
                ),
                Container(
                  height: 200.h,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.black,
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
                                        height: 25.h,
                                      ),
                                      radius: 20.r,
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
                                    height: 25.h,
                                  ),
                                  radius: 20.r,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.black,
                        height: 120.h,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
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
                                title: 'Mutton Koyla Karahi',
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
