import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wealthwise/Pages/home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:wealthwise/Pages/profile_page.dart';
import 'package:wealthwise/Pages/transaction_page.dart';

class BottomNavigation extends StatelessWidget {
  final double width;
  final double height;
  const BottomNavigation({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
            color: Theme.of(context).dividerColor,
            width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              Navigator.push(context, PageTransition(
                  child: const Home(),
                  type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 300)
              ));
            },
            icon: Icon(Icons.home, color: Theme.of(context).iconTheme.color),
          ),
          IconButton(
            onPressed: null,
            icon: Icon(Icons.credit_card, color: Theme.of(context).iconTheme.color),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, PageTransition(
                type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 300),
                child: const TransactionPage(),
              ));
            },
            icon: Icon(CupertinoIcons.plus_app, color: Theme.of(context).iconTheme.color),
          ),
          IconButton(
            onPressed: null,
            icon: Icon(CupertinoIcons.chart_pie, color: Theme.of(context).iconTheme.color),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(context, PageTransition(
                  child: const ProfilePage(),
                  type: PageTransitionType.fade,
                duration: const Duration(milliseconds: 200)
              ));
            },
            icon: Icon(CupertinoIcons.profile_circled, color: Theme.of(context).iconTheme.color),
          ),
        ],
      ),
    );
  }
}
