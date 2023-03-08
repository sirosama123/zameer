import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sliding_switch/sliding_switch.dart';
import 'package:zameer/provider/provider1.dart';
import 'package:zameer/utils/multiText.dart';

class LogSign extends StatefulWidget {
  @override
  State<LogSign> createState() => _LogSignState();
}

class _LogSignState extends State<LogSign> {
  bool pg = false;
  String pgn = "Log in";
  int hei = 380;
  bool load=  false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
   
      body: Container(
        height: double.infinity,
        width: double.infinity,

        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/bg1.png"),
            fit: BoxFit.cover
            )
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:  EdgeInsets.only(top: 20.h),
                  child: Image.asset("assets/logo.png",height: 130.h,width: 130.w,),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     SlidingSwitch(
                          value: false,
                          width: 300.w,
                          onChanged: (bool value) {
                            if (pg == true) {
                              setState(() {
                                pg = false;
                                hei = 380;
                                pgn = "Log in";
                              });
                            } else {
                              setState(() {
                                pg = true;
                                pgn = "Sign up";
                                hei = 500;
                              });
                            }
                          },
                          height: 30.h,
                          animationDuration: const Duration(milliseconds: 400),
                          onTap: () {},
                          onDoubleTap: () {},
                          onSwipe: () {},
                          textOff: "Login ",
                          textOn: "Sign up",
                          contentSize: 17,
                          colorOn: Colors.white,
                          colorOff: Colors.white,
                          background: Color(0xffCC0006),
                          buttonColor: Color.fromARGB(255, 31, 30, 30),
                          inactiveColor: Colors.white,
                        ),
                        SizedBox(height: 15.h,),
                    Container( 
                      // height: hei.h,
                      width: 300.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.r),
                          bottomLeft: Radius.circular(10.r),
                        ),
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
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                        child: Column(
                          children: [
                            pg == false ? Login() : Signup()
                          ],
                        ),
                      ),
                    ),
                   
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

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

   
  late bool _passwordVisible;
  void initState() {
    _passwordVisible = false;
  }
  bool load = false;
  bool _showPassword = false;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context);
    return Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              height: 50.h,
                width: 230.w,
              padding: EdgeInsets.fromLTRB(20, 2, 10, 2),
              decoration: BoxDecoration(
                  color: Colors.transparent,
             
                  border: Border(bottom: BorderSide(color: Colors.white))
                  ),
              child: TextFormField(
                controller: email,
                style: TextStyle(color: Colors.white,fontSize: 14),
                decoration: InputDecoration(
                    focusColor: Color(0xff164584),
                    border: InputBorder.none,
                    labelText: "Email",
                    hintStyle: TextStyle(color: Colors.white,fontSize: 12),
                    hintText: "abc@xyz.com",
                    labelStyle: TextStyle(color: Colors.white,fontSize: 12)),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Field is empty';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 50.h,
                width: 230.w,
                padding: EdgeInsets.fromLTRB(20, 2, 10, 2),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border(bottom: BorderSide(color: Colors.white))
                   ),
                child: TextFormField(
                  controller: password,
                  style: TextStyle(color: Colors.white,fontSize: 14),
                  obscureText: !this._showPassword,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.white,fontSize: 12),
                    hintStyle: const TextStyle(color: Colors.white,fontSize: 12),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: this._showPassword ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() => this._showPassword = !this._showPassword);
                      },
                    ),
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Field is empty';
                    }
                    return null;
                  },
                )),
            SizedBox(
              height: 10.h,
            ),
            Provider11.loader==false?Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(10.r)),
                height: 50.h,
                width: 230.w,
                child: ElevatedButton(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Multi(
                            color: Colors.white,
                            subtitle: "Log In",
                            weight: FontWeight.w600,
                            size: 18), // <-- Text
                        Icon(
                          // <-- Icon
                          Icons.arrow_forward,
                          size: 24.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      // <-- Radius
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                    setState(() {
                      load=true;
                    });
                    await Provider11.LoginEmail(context, email.text, password.text);
                   email.clear();
                   password.clear();
                   setState(() {
                      load=false;
                    });
                }
                  
                  },
                )):Container(
                  child: Center(
                    child:CircularProgressIndicator(color: Colors.white,)
                  ),
                ),
          ],
        ));
  }
}

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool load = false;
  late bool _passwordVisible;
  void initState() {
    _passwordVisible = false;
  }
  bool _showPassword = false;
  TextEditingController number = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Provider11 = Provider.of<Provider1>(context);
    final _formKey = GlobalKey<FormState>();
    return Form(
      key: _formKey,
        child: Column(
          children: [
             Container(
              width: 230.w,
              height: 50.h,
              padding: EdgeInsets.fromLTRB(20, 2, 10, 2),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(bottom: BorderSide(color: Colors.white))),
              child: TextFormField(
                controller: name,
                style: TextStyle(color: Colors.white,fontSize: 14),
                decoration: InputDecoration(
                    focusColor: Color(0xff164584),
                    border: InputBorder.none,
                    labelText: "Name",
                    hintStyle: TextStyle(color: Colors.white,fontSize: 12),
                    hintText: "Enter your name",
                    labelStyle: TextStyle(color: Colors.white,fontSize: 12)),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Field is empty';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
               width: 230.w,
              height: 50.h,
              padding: EdgeInsets.fromLTRB(20, 2, 10, 2),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(bottom: BorderSide(color: Colors.white))),
              child: TextFormField(
                controller: email,
                style: TextStyle(color: Colors.white,fontSize: 14),
                decoration: InputDecoration(
                    focusColor: Color(0xff164584),
                    border: InputBorder.none,
                    labelText: "Email",
                    hintStyle: TextStyle(color: Colors.white,fontSize: 12),
                    hintText: "abc@xyz.com",
                    labelStyle: TextStyle(color: Colors.white,fontSize: 12)),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Field is empty';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
               width: 230.w,
              height: 50.h,
              padding: EdgeInsets.fromLTRB(20, 2, 10, 2),
              decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border(bottom: BorderSide(color: Colors.white))),
              child: TextFormField(
                controller: number,
                style: TextStyle(color: Colors.white,fontSize: 14),
                decoration: InputDecoration(
                    focusColor: Colors.black,
                    border: InputBorder.none,
                    labelText: "Phone Number",
                    hintText: "xxxxxxxxxxx",
                    hintStyle: TextStyle(color: Colors.white,fontSize: 12),
                    labelStyle: TextStyle(color: Colors.white,fontSize: 12)),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Field is empty';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
               width: 230.w,
              height: 50.h,
                padding: EdgeInsets.fromLTRB(20, 2, 10, 2),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                     border: Border(bottom: BorderSide(color: Colors.white))),
                child: TextFormField(
                  controller: password,
                  style: TextStyle(color: Colors.white,fontSize: 14),
                  obscureText: !this._showPassword,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.white,fontSize: 12),
                    hintStyle: const TextStyle(color: Colors.white,fontSize: 12),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: this._showPassword ? Colors.red : Colors.grey,
                      ),
                      onPressed: () {
                        setState(() => this._showPassword = !this._showPassword);
                      },
                    ),
                  ),
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Field is empty';
                    }
                    return null;
                  },
                )),
            SizedBox(
              height: 10.h,
            ),
          Provider11.loader==false? Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 2),
                    borderRadius: BorderRadius.circular(10.r)),
                height: 50.h,
                width: 230.w,
               
                child: ElevatedButton(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(),
                        Multi(
                            color: Colors.white,
                            subtitle: "Sign up",
                            weight: FontWeight.w600,
                            size: 18), // <-- Text
                        Icon(
                          // <-- Icon
                          Icons.arrow_forward,
                          size: 24.0,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      // <-- Radius
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                        setState(() {
                      load=true;
                    });
                       await Provider11.emailSignin(context,email.text, password.text, number.text, name.text);
                   email.clear();
                   password.clear();
                   number.clear();
                   name.clear();
                     setState(() {
                      load=false;
                    });
                    }
                  
                  },
                )):Container(
                  child: Center(
                    child:CircularProgressIndicator(color: Colors.white,)
                  ),
                ),
          ],
        ));
  }
}
