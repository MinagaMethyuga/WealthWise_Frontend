import 'package:flutter/material.dart';

class TransactionMonthlyCard extends StatefulWidget {
  final double monthlyCardSec;
  final String cardImg;
  const TransactionMonthlyCard({
    super.key,
    required this.monthlyCardSec,
    required this.cardImg
  });

  @override
  State<TransactionMonthlyCard> createState() => _TransactionMonthlyCardState();
}

class _TransactionMonthlyCardState extends State<TransactionMonthlyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.monthlyCardSec,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        image: DecorationImage(image: AssetImage(widget.cardImg),fit: BoxFit.contain)
      ),
      child: const AspectRatio(
        aspectRatio: 1,
      ),
    );
  }
}
