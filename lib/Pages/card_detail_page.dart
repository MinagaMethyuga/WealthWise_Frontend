import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wealthwise/Pages/home.dart';

class CardDetails extends StatefulWidget {
  const CardDetails({super.key});

  @override
  State<CardDetails> createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> with SingleTickerProviderStateMixin {
  bool _expanded = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  final TextEditingController accName = TextEditingController();
  final TextEditingController accBalance = TextEditingController();
  String _accountName = '';
  String accountBalanceValue = '';
  String accountBalance = 'LKR 0.00';

  //slider animation
  @override
  void initState() {
    super.initState();
    // Initialize the animation controller and the fade animation
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    //Trigger the animation after the first frame is rendered
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _expanded = true;
        });
      });
      Future.delayed(const Duration(seconds: 3), () {
        _controller.forward();
      });
    });
  }

  @override
  void dispose() {
    accName.dispose();
    accBalance.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> addUserDetails(String accountName, String accountBalance) async {
    try{
      if (accountName.isNotEmpty && accountBalance.isNotEmpty) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();

        var userId = prefs.get('userId').toString();
        var url = Uri.parse('http://192.168.48.244:8000/api/details');
        var response = await http.post(url, body: {
          'user_id': userId,
          'account_name': accountName,
          'account_balance': accountBalance,
        });
        if (response.statusCode ==200){
          Navigator.push(context, PageTransition(
              type: PageTransitionType.fade,
              duration: const Duration(milliseconds: 400),
              child: const Home()
          ));
        }else{
          print('Oops something went Wrong22');
        }

      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: const Text('Please fill all the fields!'),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              duration: const Duration(seconds: 3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )
          ),
        );
      }
    }
    catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {

    //sizing variables
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height,
                color: Colors.white,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 340.0),
                      child: Center(
                          child: Text('Welcome to WealthWise',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.black),)
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.4),
                      child: TextButton(
                          onPressed: () async {
                            final SharedPreferences prefs = await SharedPreferences.getInstance();

                            var userId = prefs.get('userId').toString();
                            print(userId);
                            addUserDetails(_accountName, accountBalanceValue);
                          },
                        style: const ButtonStyle(backgroundColor:MaterialStatePropertyAll(Colors.lightBlue),padding: MaterialStatePropertyAll(EdgeInsets.only(top: 15,bottom: 15,left: 40,right: 40))),
                          child:
                          const Text('Add Card Details',style: TextStyle(color: Colors.white),),
                      ),
                    ),
                  ],
                ),
              ),
              AnimatedContainer(
                width: double.maxFinite,
                height: _expanded ? height * 0.8 : 0,
                duration: const Duration(seconds: 1),
                curve: Curves.easeInOut,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF74EBD5), Color(0xFFACB6E5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(40),
                    bottomLeft: Radius.circular(40),
                  ),
                ),
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(top: 25.0),
                        child: Text(
                          'Give us a little about\nyou',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Container(
                              width: 300,
                              height: 200,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage('Assets/Images/Credit_card.png'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 85,
                            left: 85,
                            child: Text(
                              accountBalance.isEmpty ? 'LKR 0.00' : accountBalance,
                              style: const TextStyle(fontSize: 26, color: Colors.white),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            left: 30,
                            child: Text(
                              _accountName.isEmpty ? 'John Doe' : _accountName,
                              style: const TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 300,
                        height: 265,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text(
                                'Your Account Name',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextFormField(
                              controller: accName,
                              onChanged: (value) {
                                setState(() {
                                  _accountName = value;
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: 'John Doe',
                                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 15.0),
                              child: Text(
                                'Your Nick Name',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Jonny',
                                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1),
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.only(top: 15.0),
                              child: Text(
                                'Your Account Balance',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            TextFormField(
                              controller: accBalance,
                              onChanged: (value) {
                                setState(() {
                                  accountBalanceValue = value;
                                  accountBalance = 'LKR $accountBalanceValue';
                                });
                              },
                              decoration: const InputDecoration(
                                hintText: 'Your Account Balance',
                                contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
