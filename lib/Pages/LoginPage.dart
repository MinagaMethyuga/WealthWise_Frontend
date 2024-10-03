import 'package:flutter/material.dart';
import 'package:wealthwise/Pages/RegisterPage.dart';
import 'package:http/http.dart' as http;
import 'package:wealthwise/Pages/home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lottie/lottie.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscureText = true;
  bool _showCheckAnimation = false;
  bool _showErrorAnimation = false;

  void _togglePasswordicon(){
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  Future<void> LoginUser(String email, String password) async {
    try {
      var url = Uri.parse('http://192.168.48.244:8000/api/login');
      var response = await http.post(url, body: {
        'email': email,
        'password': password,
      });

      if (response.statusCode == 200) {
        // Decode the JSON response
        var responseBody = jsonDecode(response.body);

        // Extract user ID from the response
        int userId = responseBody['user']['id'];

        // Save user ID to local storage
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setInt('userId', userId);

        setState(() {
          _showCheckAnimation = !_showCheckAnimation;
        });

        Future.delayed(const Duration(seconds: 1), () {
          Navigator.push(context, PageTransition(
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 400),
              child: const Home()));
          setState(() {
            _showCheckAnimation = false;
          });
        });
      } else {
        setState(() {
          _showErrorAnimation = !_showErrorAnimation;
        });

        Future.delayed(const Duration(seconds: 2), () {
          setState(() {
            _showErrorAnimation = false;
          });
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: const Text('Wrong User Credentials'),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
    return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: Container(
              color: Colors.white,
              child: Stack(
                children: [
                  SingleChildScrollView(
                  child: Form(
                    key: _loginFormKey,
                    child: Column(
                      children: [Container(
                        width: double.maxFinite,
                        height: 360,
                        decoration: const BoxDecoration(image: DecorationImage(image: AssetImage('Assets/Images/LoginBackground.jpg'),
                          fit: BoxFit.cover,
                        ),
                        ),
                      ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: SizedBox(
                            width: 300,
                            height: 390,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Welcome,',style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: Colors.black),),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 5.0),
                                    child: Text('To Your Trusted Financial Companion.',style: TextStyle(fontSize: 14,color:Colors.blue),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 30),
                                    child: TextFormField(
                                      controller: _emailController,
                                      decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide(width: 1)
                                        ),
                                        hintText: "Email",
                                        hintStyle: TextStyle(fontSize: 12),
                                        prefixIcon: Icon(Icons.email_outlined),
                                      ),
                                      validator: (email) => email!.isEmpty? "Please Enter your Email" :null,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: TextFormField(
                                      obscureText: _obscureText,
                                      controller: _passwordController,
                                      decoration: InputDecoration(
                                          contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                          border: const OutlineInputBorder(
                                              borderSide: BorderSide(width: 1)
                                          ),
                                          hintText: "Password",
                                          hintStyle: const TextStyle(fontSize: 12),
                                          prefixIcon: const Icon(Icons.password),
                                          suffixIcon: IconButton(onPressed: _togglePasswordicon,
                                              icon: Icon(
                                                _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                                              )
                                          ),
                                      ),
                                      validator: (password) => password!.isEmpty? "Please Enter your Password" :null,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const TextButton(onPressed: null, child: Text('Forgot Password ?',style: TextStyle(fontSize: 12,color: Colors.blue),),),
                                      ElevatedButton(onPressed: () {
                                        if(_loginFormKey.currentState!.validate()){
                                          String email = _emailController.text;
                                          String password = _passwordController.text;

                                          LoginUser(email, password);
                                        }else{
                                          null;
                                        }
                                      },
                                        style: const ButtonStyle(
                                          backgroundColor: MaterialStatePropertyAll(Colors.blue),
                                        ), child: const Text('Login',style: TextStyle(fontSize: 10,color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 30),
                                    child: Divider(
                                      color: Colors.grey,
                                      height: 10,
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 8,left: 8),
                                    child: Text("Don't Have an Account?",style: TextStyle(fontSize: 10,color: Colors.grey),),
                                  ),
                                  TextButton(onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.fade,
                                        child: const RegisterPage(),
                                      ),
                                    );
                                    _emailController.clear();
                                    _passwordController.clear();
                                  },
                                      style: const ButtonStyle(
                                          backgroundColor: MaterialStatePropertyAll(Colors.blue),
                                          fixedSize: MaterialStatePropertyAll(Size(double.maxFinite, 10))
                                      ),
                                      child: const Text(
                                        'Register',
                                        style: TextStyle(color: Colors.white),
                                      )
                                  )
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                  Visibility(
                    visible: _showCheckAnimation,
                    child: Center(
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Lottie.asset('Assets/Images/Animations/Check-Animation.json',
                          fit: BoxFit.cover,
                          animate: true,
                          repeat: false,
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _showErrorAnimation,
                    child: Center(
                      child: SizedBox(
                        width: 200,
                        height: 200,
                        child: Lottie.asset('Assets/Images/Animations/Error.json',
                          fit: BoxFit.cover,
                          animate: true,
                          repeat: false,
                        ),
                      ),
                    ),
                  ),
              ]),
            ),
          ),
    );
  }
}
