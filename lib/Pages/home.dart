import 'package:flutter/material.dart';
import '../Components/Home/monthly_payment_card.dart';
import '../Components/Home/transaction_card.dart';
import '../Components/Navigation/bottom_navigation.dart';
import '../Components/Navigation/top_navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String accountName = '';
  String accountBalance = '';
  String accountincome = '';
  String accountexpense = '';

  @override
  void initState() {
    super.initState();
    upDateCard();
  }

  //card refreshing
  Future<void> upDateCard() async {
    try{
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      var userId = prefs.get('userId').toString();

      var url = Uri.parse('http://192.168.48.244:8000/api/homeCard?user_id=$userId');
      var response = await http.get(url);

      if(response.statusCode == 200){
        var data = json.decode(response.body);
        var fetchedAccountName = data['payload']['account_name'];
        var fetchedAccountBalance = data['payload']['account_balance'];
        var fetchedicome = data['payload']['monthly_income'];
        var fetchedExpense = data['payload']['total_expenses'];

        print('account Name:$fetchedAccountName');
        print('account balance:$fetchedAccountBalance');
        print('income:$fetchedicome');
        print('expense:$fetchedExpense');

        setState(() {
          accountName =fetchedAccountName;
          accountBalance =fetchedAccountBalance.toString();
          accountincome = fetchedicome.toString();
          accountexpense = fetchedExpense.toString();
        });
      }else{
        print('Oops something is not right');
      }
      }
    catch (e){
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    //Sizing variables
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double whiteSlider = deviceHeight * 0.75;
    double mainDiv = whiteSlider * 0.85;
    double subDiv1 = mainDiv * 0.95;
    double subDiv2 = subDiv1 * 0.3;
    double subDiv3 = subDiv2 * 0.7;
    //Card Sizing
    double cardWidth = deviceWidth * 0.8;
    double cardHeight = deviceHeight * 0.23;

    return SafeArea(
      child: Container(
        width: double.maxFinite,
        height: deviceHeight,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
            children: [
              const TopNavigation(),
              Expanded(
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      width: double.maxFinite,
                      height: whiteSlider,
                      decoration: BoxDecoration(borderRadius: const BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50)),
                      color: Theme.of(context).primaryColor,
                      ),

                      //top part of the Main Div
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          height: mainDiv,
                          width: double.maxFinite,
                          child: Center(
                            child: SizedBox(
                              height: subDiv1,
                              width: deviceWidth * 0.9,
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: subDiv2,
                                      width: double.maxFinite,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text('Monthly Payments',style: TextStyle(fontSize: 16,color: Theme.of(context).textTheme.bodyLarge?.color,decoration: TextDecoration.none,fontWeight: FontWeight.normal),
                                              ),
                                              const Text('View All >',style: TextStyle(fontSize: 12,color: Colors.blue,decoration: TextDecoration.none),)
                                            ],
                                          ),
                                          Expanded(
                                            child: Align(
                                              alignment: Alignment.bottomCenter,
                                              child: SizedBox(
                                                width: double.maxFinite,
                                                height: subDiv2 * 0.75,
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    //The Monthly Payment cards
                                                    CardMonthly(
                                                      width: subDiv3 * 0.9,
                                                      height: double.maxFinite,
                                                      imagePath: 'Assets/Images/IconPack/adobe.png',
                                                      paymentAmount: 'LKR 2750',
                                                      paymentDate: 'April 3rd',
                                                    ),
                                                    CardMonthly(
                                                      width: subDiv3 * 0.9,
                                                      height: double.maxFinite,
                                                      imagePath: 'Assets/Images/IconPack/spotify.png',
                                                      paymentAmount: 'LKR 3500',
                                                      paymentDate: 'May 5th',
                                                    ),
                                                    CardMonthly(
                                                      width: subDiv3 * 0.9,
                                                      height: double.maxFinite,
                                                      imagePath: 'Assets/Images/IconPack/netflix.png',
                                                      paymentAmount: 'LKR 1780',
                                                      paymentDate: 'Aug 15th',
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),


                                    //Bottom section of the main div
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.bottomCenter,
                                        child: SizedBox(
                                          width: double.maxFinite,
                                          height: subDiv1 * 0.68,
                                          child:Column(
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  Text('Recent Transactions',style: TextStyle(fontSize: 16,color: Theme.of(context).textTheme.bodyLarge?.color,decoration: TextDecoration.none,fontWeight: FontWeight.normal)),
                                                  const Text('View All >',style: TextStyle(fontSize: 12,color: Colors.blue,decoration: TextDecoration.none),)
                                                ],
                                              ),
                                              Expanded(
                                                child: Align(
                                                  alignment: Alignment.bottomCenter,
                                                  child: SizedBox(
                                                    width: double.maxFinite,
                                                    height: subDiv1 * 0.62,
                                                    child: Column(
                                                      children: [
                                                        //Transaction Card div
                                                        SizedBox(
                                                          width: double.maxFinite,
                                                          height: subDiv1 * 0.52,
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [

                                                                      //Transaction Card Div
                                                              TransactionCard(
                                                                width: double.maxFinite,
                                                                height: subDiv1 * 0.13,
                                                                productImage: 'Assets/Images/IconPack/Food-Beverage.png',
                                                                transactionName: 'Food And Beverages',
                                                                paymentMethod: 'Card Payment(Minaga)',
                                                                amountPaid: 'LKR 3500',
                                                              ),
                                                              TransactionCard(
                                                                width: double.maxFinite,
                                                                height: subDiv1 * 0.13,
                                                                productImage: 'Assets/Images/IconPack/Light-bill.png',
                                                                transactionName: 'Electricity Bill',
                                                                paymentMethod: 'Card Payment(Minaga)',
                                                                amountPaid: 'LKR 9500',
                                                              ),
                                                              TransactionCard(
                                                                width: double.maxFinite,
                                                                height: subDiv1 * 0.13,
                                                                productImage: 'Assets/Images/IconPack/petrol.png',
                                                                transactionName: 'Fuel',
                                                                paymentMethod: 'Cash Payment',
                                                                amountPaid: 'LKR 5000',
                                                              ),
                                                              TransactionCard(
                                                                width: double.maxFinite,
                                                                height: subDiv1 * 0.13,
                                                                productImage: 'Assets/Images/IconPack/Phone-Bill.png',
                                                                transactionName: 'Phone Bill',
                                                                paymentMethod: 'Card Payment(Minaga)',
                                                                amountPaid: 'LKR 2000',
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Align(
                                                            alignment: Alignment.bottomCenter,
                                                            child: BottomNavigation(
                                                              width: double.maxFinite,
                                                              height: subDiv1 * 0.08,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    //Card Division
                    Positioned(
                      top: deviceHeight * 0.01,
                      left: deviceWidth * 0.1,
                        child: Container(
                          width: cardWidth,
                          height: cardHeight,
                          decoration: BoxDecoration(
                            color: Theme.of(context).canvasColor,
                            borderRadius: const BorderRadius.all(Radius.circular(10))
                          ),
                          child: Align(
                            child: SizedBox(
                              width: cardWidth * 0.95,
                              height: cardHeight * 0.9,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Container(
                                        height: cardHeight * 0.15,
                                        decoration: const BoxDecoration(
                                          color: Colors.grey,
                                          borderRadius: BorderRadius.all(Radius.circular(10))
                                        ),
                                        child:
                                        AspectRatio(
                                          aspectRatio: 3.5,
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text('June',style: TextStyle(fontSize: 12,color: Theme.of(context).textTheme.bodyLarge?.color,decoration: TextDecoration.none),),
                                          ],
                                        ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Text(
                                      accountName.isEmpty ? 'Loading..' : accountName.toUpperCase(),
                                      style: TextStyle(decoration: TextDecoration.none,color: Theme.of(context).textTheme.bodyLarge?.color,fontSize: 12,fontWeight: FontWeight.bold),),
                                  ),
                                  Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(top: 10.0),
                                        child: Text(
                                            accountBalance.isEmpty ? 'Balance LKR Loading..' : 'Balance LKR $accountBalance',
                                            style: TextStyle(decoration: TextDecoration.none,fontSize: 18,color: Theme.of(context).textTheme.bodyLarge?.color),),
                                      )
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        width: cardWidth * 0.8,
                                        height: cardHeight * 0.3,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context).primaryColor,
                                          borderRadius: const BorderRadius.all(Radius.circular(10))
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                          SizedBox(
                                            height: cardHeight * 0.2,
                                            child: AspectRatio(
                                                aspectRatio: 3,
                                                    child: Column(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        Text('Income',style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color,fontSize: 10,decoration: TextDecoration.none,fontWeight:FontWeight.normal),),
                                                        Text(accountincome.isEmpty ? 'LKR Loading..' : 'LKR $accountincome',
                                                          style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color,fontSize: 12,decoration: TextDecoration.none,fontWeight:FontWeight.w900),),
                                                      ],
                                                    ),
                                            ),
                                          ),
                                            Container(
                                              width: 1,
                                              height: cardHeight * 0.2,
                                              color: Colors.grey,
                                            ),
                                            SizedBox(
                                              height: cardHeight * 0.2,
                                              child: AspectRatio(
                                                  aspectRatio: 3,
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Text('Target Expense',style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color,fontSize: 10,decoration: TextDecoration.none,fontWeight:FontWeight.normal),),
                                                    Text(accountexpense.isEmpty ? 'LKR Loading..' : 'LKR $accountexpense',
                                                      style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color,fontSize: 12,decoration: TextDecoration.none,fontWeight:FontWeight.w900),),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                    ),
                  ],
                ),
              ),
            ],
        ),
      )
    );
  }
}
