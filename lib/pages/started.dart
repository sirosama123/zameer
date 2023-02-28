import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';
import 'package:zameer/pages/landingPage.dart';
import 'package:http/http.dart' as http;
import 'package:zameer/pages/mainLanding.dart';
import '../provider/provider1.dart';

class Startded extends StatelessWidget {
  const Startded({super.key});

  @override
  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context);
    Future<void> getData() async {
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products?consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      Provider11.today = json.decode(response.body);
    }

    Future<void> Addons() async {
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products?category=64&page=1&per_page=100&consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      Provider11.addon = json.decode(response.body) ;
    }

    Future<void> Beef() async {
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products?category=59&page=1&per_page=100&consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      Provider11.beef = json.decode(response.body);
    }

    Future<void> Beverages() async {
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products?category=63&page=1&per_page=100&consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      Provider11.beverage = json.decode(response.body);
    }

    Future<void> Chicken() async {
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products?category=61&page=1&per_page=100&consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      Provider11.chicken = json.decode(response.body);
    }

    Future<void> Ck() async {
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products?category=56&page=1&per_page=100&consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      Provider11.ck = json.decode(response.body) ;
    }

    Future<void> Ct() async {
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products?category=58&page=1&per_page=100&consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      Provider11.ct = json.decode(response.body) ;
    }

    Future<void> Mutton() async {
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products?category=60&page=1&per_page=100&consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      Provider11.mutton = json.decode(response.body);
    }

    Future<void> Mk() async {
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products?category=57&page=1&per_page=100&consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      Provider11.mk = json.decode(response.body) ;
    }

    Future<void> Roll() async {
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products?category=65&page=1&per_page=100&consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      Provider11.roll = json.decode(response.body);
    }

    Future<void> Starter() async {
      final response = await http.get(Uri.parse(
          'https://zameeransari.com.pk/wp-json/wc/v3/products?category=74&page=1&per_page=100&consumer_key=ck_b8a58a9620e9f44935ece14278bc9df3ead71632&consumer_secret=cs_899ec45e45abdbf9634c1fcba08442d8ba2bfc39'));
      Provider11.starter = json.decode(response.body) ;
    }

    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () async {
              await getData();
              await Addons();
              await Beef();
               Beverages();
               Chicken();
               Ck();
               Ct();
               Mutton();
               Mk();
               Roll();
               Starter();
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LandingPage()));
            },
            child: Text("Let's Start")),
      ),
    );
  }
}
