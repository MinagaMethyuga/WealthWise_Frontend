import 'package:flutter/material.dart';

class ProfileCard extends StatefulWidget {
  final double height;
  final IconData icon;
  final String settingName;
  final VoidCallback action;
  const ProfileCard({
    super.key,
    required this.height,
    required this.icon,
    required this.settingName,
    required this.action,
  });

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.action,
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0),
        child: Container(
          width: double.maxFinite,
          height: widget.height,
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              border: Border.all(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Icon(widget.icon,size: 30,color: Theme.of(context).iconTheme.color,),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text(widget.settingName,style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color,decoration: TextDecoration.none,fontSize: 14),),
              )
            ],
          ),
        ),
      ),
    );
  }
}