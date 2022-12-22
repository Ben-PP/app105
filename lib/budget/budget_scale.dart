import 'package:flutter/material.dart';

class BudgetScale extends StatelessWidget {
  const BudgetScale({
    required this.total,
    required this.income,
    this.title,
    this.height,
    this.width,
    super.key,
  });
  final double? height;
  final double? width;
  final String? title;
  final double total;
  final double income;

  @override
  Widget build(BuildContext context) {
    late double balance;
    double range;
    double scaleMultiplier;
    final double heightDefault = MediaQuery.of(context).size.height * 0.04;
    final double widthDefault = MediaQuery.of(context).size.width;
    balance = income + total;
    if (balance < 0) balance = 0;
    range = income * 2;
    if (income == 0) {
      range = 2;
      balance = 1;
    }
    scaleMultiplier = balance / range;
    return Column(children: [
      if (title != null)
        Text(
          title!,
          textAlign: TextAlign.left,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      Container(
        width: width ?? widthDefault,
        height: height ?? heightDefault,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: Colors.grey,
        ),
        clipBehavior: Clip.hardEdge,
        // TODO Implement the balance bar
        // TODO Add saving target
        child: Stack(
          children: [
            Container(
              width: (width ?? widthDefault) * scaleMultiplier,
              height: double.infinity,
              color: scaleMultiplier >= 0.65
                  ? Colors.green
                  : scaleMultiplier > 0.5
                      ? Colors.amber
                      : Colors.red,
            )
          ],
        ),
      ),
      Container(
        color: Colors.black,
        height: 10,
        width: 2,
      ),
      SizedBox(
        width: width ?? widthDefault,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '-$income€',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              '$total€',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text(
              '$income€',
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ],
        ),
      )
    ]);
  }
}
