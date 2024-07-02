import 'package:flutter/material.dart';
import 'package:wealthwise/Pages/login_page.dart';
import '../Components/Navigation/bottom_navigation.dart';
import '../Components/Navigation/top_navigation.dart';
import '../Components/Profile/profile_card.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    final double bodyWidth = width * 0.9;
    return SafeArea(child:
    Container(
      width: width,
      height: height,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        children: [
          const TopNavigation(),
      SizedBox(
              width: width * 0.8,
              height: height * 0.15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CircleAvatar(
                    radius: 35,
                    child: Icon(Icons.person),
                  ),
                  SizedBox(
                    width: width * 0.5,
                      height: height * 0.08,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('Minaga Methyuga',style: TextStyle(
                          fontSize: 18,
                          decoration: TextDecoration.none,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                        ),
                        Text('minaga@gmail.com',style: TextStyle(
                          fontSize: 14,
                          decoration: TextDecoration.none,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),)
                      ],
                    ),
                  )
                ],
              ),
            ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: width,
                height: height * 0.76,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: const BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50))
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    width: double.maxFinite,
                    height: height * 0.69,
                    child: Column(
                      children: [
                        SizedBox(
                          width: bodyWidth,
                          height: height * 0.5,
                          child: Column(
                            children: [
                              ProfileCard(
                                height: height * 0.06,
                                icon: Icons.person_pin,
                                settingName:'Edit Profile',
                                action: (){},
                              ),
                              ProfileCard(
                                height: height * 0.06,
                                icon: Icons.notifications_active,
                                settingName:'Notifications',
                                action: (){},
                              ),
                              ProfileCard(
                                height: height * 0.06,
                                icon: Icons.headset_mic_sharp,
                                settingName:'Support',
                                action: (){},
                              ),
                              ProfileCard(
                                height: height * 0.06,
                                icon: Icons.logout,
                                settingName:'Logout',
                                action: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage(),));
                                },
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: BottomNavigation(
                                height: height * 0.06,
                                width: bodyWidth,
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
        ],
      ),
    )
    );
  }
}
