import 'package:flutter/material.dart';

class CardMonthly extends StatefulWidget {
  final double width;
  final double height;
  final String imagePath;
  final String paymentAmount;
  final String paymentDate;
  const CardMonthly({
    super.key,
    required this.width,
    required this.height,
    required this.imagePath,
    required this.paymentAmount,
    required this.paymentDate,
  });

  @override
  State<CardMonthly> createState() => _CardMonthlyState();
}

class _CardMonthlyState extends State<CardMonthly> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration:BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(15)),
          border: Border.all(
            color: Theme.of(context).dividerColor,
            width: 1,
          )
      ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                  width: widget.width * 0.5,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(widget.imagePath),
                      fit: BoxFit.contain,
                    )
                  )
                ),
              ),
            ),
            SizedBox(
              width: widget.width * 0.9,
              height: 20,
              child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      widget.paymentAmount,style: TextStyle(fontSize: 12,decoration: TextDecoration.none,color: Theme.of(context).textTheme.bodyLarge?.color,fontWeight: FontWeight.normal),
                    ),
                  ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: Text(widget.paymentDate,style: TextStyle(fontSize: 8,decoration: TextDecoration.none,color: Theme.of(context).textTheme.bodyLarge?.color,fontWeight: FontWeight.normal),),
            )
          ],
        ),
    );
  }
}
