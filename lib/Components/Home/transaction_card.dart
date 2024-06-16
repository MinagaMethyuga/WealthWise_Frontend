import 'package:flutter/material.dart';

class TransactionCard extends StatefulWidget {
  final double width;
  final double height;
  final String productImage;
  final String transactionName;
  final String paymentMethod;
  final String amountPaid;
  const TransactionCard({
    super.key,
    required this.width,
    required this.height,
    required this.productImage,
    required this.transactionName,
    required this.paymentMethod,
    required this.amountPaid,
  });

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height * 0.8,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(15)),
        border: Border.all(
          color: Theme.of(context).dividerColor,
          width: 1,
        )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //image Container
          SizedBox(
            height: widget.height * 0.85,
            child: AspectRatio(
              aspectRatio: 1,
              child: Image(image: AssetImage(widget.productImage),
                fit: BoxFit.contain,
              ),
            ),
          ),
          //Center Text Container
          SizedBox(
            height: widget.height * 0.7,
            child: AspectRatio(
                aspectRatio: 3.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.transactionName,style: TextStyle(fontSize: 14,color: Theme.of(context).textTheme.bodyLarge?.color,decoration: TextDecoration.none),
                  ),
                  Text(widget.paymentMethod,style: TextStyle(fontSize: 12,color: Theme.of(context).textTheme.bodyLarge?.color,decoration: TextDecoration.none,fontWeight: FontWeight.normal)
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: widget.height * 0.5,
            child: AspectRatio(
                aspectRatio: 2.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(widget.amountPaid,style: TextStyle(fontSize: 14,decoration: TextDecoration.none,color: Theme.of(context).textTheme.bodyLarge?.color),)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
