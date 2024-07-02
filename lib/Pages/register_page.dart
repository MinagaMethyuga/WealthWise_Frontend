import 'package:flutter/material.dart';
import 'package:wealthwise/Pages/login_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:lottie/lottie.dart';
import 'package:wealthwise/Pages/card_detail_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();

}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed.
    _emailController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }
  bool _obscureText = true;
  bool animationShower = false;

  void _togglePasswordIcon() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }
  //register function
  Future<void> registerUser(BuildContext context, String firstName,String lastName, String email, String password)async{
    //change the url to the hosting machine's ipv4 address when running on the physical device..
    var url = Uri.parse('http://10.0.2.2:8000/api/register');
    var response = await http.post(url, body: {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
    });
    if (response.statusCode ==200){

      var responseBody = json.decode(response.body);
      var payload = responseBody['payload'];
      var userId = payload['id'].toString();

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('user_id', userId);
      print('User ID: $userId');

      setState(() {
        animationShower = true;
      });
      Future.delayed(const Duration(seconds: 1),(){
        Navigator.push(context, MaterialPageRoute(builder: (context) => const CardDetails(),));
      });
    }else{
      var responseBody = jsonDecode(response.body);
        String errorMessage = responseBody['message'] ?? 'Registration failed';
      print(responseBody);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(errorMessage),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    final registerKey = GlobalKey<FormState>();

    //sizing variables
    double height = MediaQuery.of(context).size.height;

    return SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Container(
            color: Colors.white,
            child: Stack(
              children: [SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                    width: double.maxFinite,
                    height: height * 0.35,
                    decoration: const BoxDecoration(
                        image: DecorationImage(image: AssetImage('Assets/Images/Register.jpg'),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: SizedBox(
                        width: 300,
                        height: 610,
                          child: Form(
                            key: registerKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //image logo
                                const Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Center(child: Text('Welcome to WealthWise',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.black),)),
                                  ),
                                 Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: TextFormField(
                                    controller: firstNameController,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 1)
                                      ),
                                      hintText: "First Name",
                                      hintStyle: TextStyle(fontSize: 12),
                                        prefixIcon: Icon(Icons.person)
                                    ),
                                    validator: (firstName)=> firstName!.isEmpty? "Please Give us your First name": null,
                                  ),
                                ),
                                 Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: TextFormField(
                                    controller: lastNameController,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 1)
                                      ),
                                      hintText: "Last Name",
                                      hintStyle: TextStyle(fontSize: 12),
                                      prefixIcon: Icon(Icons.person)
                                    ),
                                    validator: (lastName)=> lastName!.isEmpty? "Please us your Last name": null,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: TextFormField(
                                    controller: _emailController,
                                    decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide(width: 1)
                                      ),
                                      hintText: "Email",
                                      hintStyle: TextStyle(fontSize: 12),
                                      prefixIcon: Icon(Icons.mail_outline)
                                    ),
                                    validator: (email)=> email!.isEmpty? "Please us your Email": null,
                                  ),
                                ),
                                 Padding(
                                  padding:const EdgeInsets.only(top: 10),
                                  child: TextFormField(
                                    controller: _passwordController,
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                      contentPadding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                                      border: const OutlineInputBorder(
                                          borderSide: BorderSide(width: 1)
                                      ),
                                      hintText: "Password",
                                      hintStyle: const TextStyle(fontSize: 12),
                                      prefixIcon: const Icon(Icons.password),
                                      suffixIcon: IconButton(onPressed: _togglePasswordIcon, icon: Icon(
                                        _obscureText ? Icons.visibility_off_outlined : Icons
                                            .visibility_outlined,
                                      ))
                                    ),
                                    validator: (password)=> password!.isEmpty? "Please us a Password": null,
                                  ),
                                ),
                                 Padding(
                                  padding:const EdgeInsets.only(top: 10),
                                  child: TextFormField(
                                    controller: confirmPasswordController,
                                    obscureText: _obscureText,
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                        border: const OutlineInputBorder(
                                            borderSide: BorderSide(width: 1)
                                        ),
                                        hintText: "Confirm Password",
                                        hintStyle: const TextStyle(fontSize: 12),
                                        prefixIcon: const Icon(Icons.password),
                                        suffixIcon: IconButton(onPressed: _togglePasswordIcon,
                                            icon: Icon(
                                              _obscureText ? Icons.visibility_off_outlined : Icons
                                                  .visibility_outlined,
                                            ))
                                    ),
                                    validator: (confirmPassword) =>
                                    confirmPassword!.isEmpty
                                        ? "Please have retype your password"
                                        : null,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const TextButton(
                                          onPressed: null,
                                          child:Text('Terms And Conditions',style: TextStyle(color: Colors.blue,fontSize: 12),)
                                      ),
                                      TextButton(onPressed: () {
                                        if( registerKey.currentState!.validate() ){
                                          String firstName = firstNameController.text;
                                          String lastName = lastNameController.text;
                                          String email = _emailController.text;
                                          String enteredPassword = _passwordController.text;
                                          String centeredPass = confirmPasswordController.text;

                                          if(enteredPassword == centeredPass){
                                            String password =centeredPass;
                                            print('First Name: $firstName');
                                            print('Last Name: $lastName');
                                            print('Email: $email');
                                            print('Password: $password');
                                            registerUser(context, firstName, lastName, email, password);

                                          }else{
                                            //make a notification that the passwords do not match
                                            ScaffoldMessenger.of(context).showSnackBar(
                                                const SnackBar(
                                                  content: Text('Passwords do not match'),
                                                  backgroundColor: Colors.redAccent,
                                                  behavior: SnackBarBehavior.floating,
                                                )
                                            );
                                          }
                                        }else{
                                          null;
                                        }
                                      },
                                          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue,),fixedSize: MaterialStatePropertyAll(Size(100, 10))),
                                          child: const Text('Register',style: TextStyle(color: Colors.white,fontSize: 12),))
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const LoginPage(),));
                                    },
                                    style: const ButtonStyle(
                                      fixedSize: MaterialStatePropertyAll(Size(double.maxFinite, 10)),
                                      side:MaterialStatePropertyAll(BorderSide(width: 1,color: Colors.grey)),
                                    ),
                                    child: const Text('Already Have a Wealthy Account ?',style: TextStyle(
                                      color: Colors.black,
                                    ),),
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
                Visibility(
                  visible: animationShower,
                  child: Center(
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Lottie.asset('Assets/Images/Animations/Check-Animation.json',
                      repeat: false,
                      ),
                    ),
                  ),
                )
            ]),
          ),
        )
    );
  }
}
