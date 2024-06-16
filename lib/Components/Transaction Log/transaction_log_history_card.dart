import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionHistory extends StatefulWidget {
  final double height;
  final String image;
  final String transactionName;
  final String transactionType;
  const TransactionHistory({
    super.key,
    required this.height,
    required this.image,
    required this.transactionName,
    required this.transactionType,
  });

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: widget.height * 0.8,
              child: AspectRatio(
                  aspectRatio: 1,
                child: Image(image: AssetImage(widget.image),
                fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(
              height: widget.height * 0.6,
              child: AspectRatio(
                  aspectRatio: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(widget.transactionName,style: TextStyle(fontSize: 14,decoration: TextDecoration.none,color: Theme.of(context).textTheme.bodyLarge?.color),),
                    Text(widget.transactionType,style: TextStyle(fontSize: 12,decoration: TextDecoration.none,color: Theme.of(context).textTheme.bodyLarge?.color,fontWeight: FontWeight.normal),)
                  ],
                ),
              ),
            ),
            IconButton(
                onPressed: null,
                icon: Icon(CupertinoIcons.chevron_right_circle_fill,color: Theme.of(context).canvasColor,),iconSize: 40,)
          ],
        ),
      ),
    );
  }
}
