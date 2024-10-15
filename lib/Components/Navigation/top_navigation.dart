import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wealthwise/Theme/theme_provider.dart';

class TopNavigation extends StatefulWidget {
  const TopNavigation({super.key});

  @override
  State<TopNavigation> createState() => _TopNavigationState();
}

class _TopNavigationState extends State<TopNavigation> {
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    final themeProvider = Provider.of<ThemeProvider>(context);
    ThemeMode themeMode = themeProvider.themeMode;

    return SafeArea(
        child:Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: SizedBox(
            width: deviceWidth * 0.9,
            height: 50,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const IconButton(onPressed: null,
                        icon: Icon(Icons.settings,color: Colors.white,)
                    ),
                    const Row(
                      children: [
                        Image(image: AssetImage('Assets/Images/TransParentIcon.png'),width: 45,
                        ),
                        Text('WealthWise',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w200, decoration: TextDecoration.none),),
                      ],
                    ),
                    IconButton(onPressed: () {
                      themeProvider.toggleTheme();
                    },
                        icon: Icon(
                          themeMode == ThemeMode.dark
                              ? Icons.brightness_3_sharp
                              : Icons.wb_sunny,
                          color: Colors.white,
                        )
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }
}
