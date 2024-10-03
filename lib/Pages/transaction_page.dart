import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wealthwise/Pages/BudgetPage.dart';
import 'package:wealthwise/Pages/home.dart';
import '../Components/Navigation/bottom_navigation.dart';
import '../Components/Navigation/top_navigation.dart';
import '../Components/Transaction Log/transaction_log_history_card.dart';
import '../Components/Transaction Log/transaction_log_monthly_card.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    double mainWhiteDive = deviceHeight * 0.85;
    double monthlyCardSec = mainWhiteDive * 0.21;

    return SafeArea(
        child: Container(
          width: double.maxFinite,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: Column(
            children: [
              const TopNavigation(),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.maxFinite,
                    height: mainWhiteDive,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: const BorderRadius.only(topLeft: Radius.circular(50),topRight: Radius.circular(50))
                    ),
                    child: Stack(
                      children: [
                        Align(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: SizedBox(
                            width: deviceWidth * 0.9,
                            height: mainWhiteDive * 0.92,
                            child: Column(
                                children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: SizedBox(
                                  width: deviceWidth * 0.9,
                                  height: mainWhiteDive * 0.18,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Your Monthly Payments',style: TextStyle(fontSize: 16,color: Theme.of(context).textTheme.bodyLarge?.color,decoration: TextDecoration.none),),
                                      Expanded(
                                        child: Align(
                                          alignment: Alignment.bottomCenter,
                                          child: SizedBox(
                                            width:  deviceWidth * 0.9,
                                            height: monthlyCardSec,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Align(
                                                  child: TransactionMonthlyCard(
                                                    monthlyCardSec: monthlyCardSec * 0.6,
                                                    cardImg: 'Assets/Images/IconPack/house.png',
                                                  ),
                                                ),
                                                TransactionMonthlyCard(
                                                  monthlyCardSec: monthlyCardSec * 0.6,
                                                  cardImg: 'Assets/Images/IconPack/Light-bill.png',
                                                ),
                                                TransactionMonthlyCard(
                                                  monthlyCardSec: monthlyCardSec * 0.6,
                                                  cardImg: 'Assets/Images/IconPack/Lifestyle.png',
                                                ),
                                                IconButton(
                                                    onPressed: null,
                                                    icon: Icon(CupertinoIcons.plus_circle_fill,color: Theme.of(context).canvasColor,size: 40,))
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: SizedBox(
                                  width: double.maxFinite,
                                  height: mainWhiteDive * 0.57,
                                  child: ClipRect(
                                    child: SingleChildScrollView(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text('Your Transactions',style: TextStyle(fontSize: 16,color: Theme.of(context).textTheme.bodyLarge?.color,decoration: TextDecoration.none),),
                                          TransactionHistory(
                                            height: mainWhiteDive * 0.1,
                                            image: 'Assets/Images/IconPack/grocery.png',
                                            transactionName: 'Grocery Shopping',
                                            transactionType: 'Cash',
                                          ),
                                          TransactionHistory(
                                            height: mainWhiteDive * 0.1,
                                            image: 'Assets/Images/IconPack/petrol.png',
                                            transactionType: 'Card',
                                            transactionName: 'Fuel',
                                          ),
                                          TransactionHistory(
                                            height: mainWhiteDive * 0.1,
                                            image: 'Assets/Images/IconPack/Shopping.png',
                                            transactionName: 'Shopping',
                                            transactionType: 'Card',
                                          ),
                                          TransactionHistory(
                                            height: mainWhiteDive * 0.1,
                                            image: 'Assets/Images/IconPack/transportation.png',
                                            transactionType: 'Transport',
                                            transactionName: 'Cash',
                                          ),
                                          TransactionHistory(
                                            height: mainWhiteDive * 0.1,
                                            image: 'Assets/Images/IconPack/Medical-bills.png',
                                            transactionName: 'Medical Bill',
                                            transactionType: 'Card',
                                          ),
                                          TransactionHistory(
                                            height: mainWhiteDive * 0.1,
                                            image: 'Assets/Images/IconPack/Entertainment.png',
                                            transactionType: 'Entertainment',
                                            transactionName: 'Cash',
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 8.0),
                                    child: TextButton(
                                        onPressed: null,
                                      style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue),padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 0,horizontal: 20))),
                                        child: Text('Add Transactions',style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),),
                                    ),
                                  ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: TextButton(
                                          onPressed:() {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => const BudgetPage()),
                                            );
                                          },
                                          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Colors.blue),padding: MaterialStatePropertyAll(EdgeInsets.symmetric(vertical: 0,horizontal: 40))),
                                          child: Text('Add Budget',style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),),
                                        ),
                                      ),
                                ],
                              ),
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  child: BottomNavigation(
                                    height: mainWhiteDive * 0.06,
                                    width: double.maxFinite,
                                  ),
                                ),
                              )
                            ]),
                          ),
                        ),
                      ),]
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }
}
