import 'package:eden_app/features/dashboard/presentation/screens/order_status_screen.dart';
import 'package:eden_app/utils/date_util.dart';
import 'package:eden_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OrderDetailWidget extends StatefulWidget {
  const OrderDetailWidget({super.key});

  @override
  State<OrderDetailWidget> createState() => _OrderDetailWidgetState();
}

class _OrderDetailWidgetState extends State<OrderDetailWidget>
    with SingleTickerProviderStateMixin {
  //Note: pass these as properties of this class for multiple order
  double startPos = -1.0;
  double endPos = 0.0;
  Curve curve = Curves.elasticOut;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        FractionallySizedBox(
          heightFactor: 0.3,
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: appColors.primaryGreen,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.shopping_cart_checkout_rounded,
                      size: 70,
                      color: appColors.white,
                    ),
                    Text(
                      "Your order has been placed.",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 24,
                            color: appColors.white,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      "Your order status will be updated soon.",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontSize: 16,
                            color: appColors.white,
                            fontWeight: FontWeight.w300,
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                    const SizedBox(height: 16),
                    Divider(
                      color: appColors.white,
                      thickness: 1.5,
                    ),
                    const SizedBox(height: 16),
                    GestureDetector(
                      onTap: () async => await orderDetailRevealer(true),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Track your order details",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  fontSize: 18,
                                  color: appColors.white,
                                ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            endPos != 0.0
                                ? PhosphorIcons.caretRight(
                                    PhosphorIconsStyle.bold,
                                  )
                                : PhosphorIcons.caretDown(
                                    PhosphorIconsStyle.bold,
                                  ),
                            color: appColors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        FractionallySizedBox(
          heightFactor: 0.7,
          alignment: Alignment.bottomCenter,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            curve: curve,
            height: MediaQuery.of(context).size.height / 4,
            child: TweenAnimationBuilder(
              tween: Tween<Offset>(
                begin: Offset(0, startPos),
                end: Offset(0, endPos),
              ),
              duration: Duration(milliseconds: 300),
              curve: curve,
              builder: (context, offset, child) {
                return FractionalTranslation(
                  translation: offset,
                  child: child,
                );
              },
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: appColors.white,
                      border: Border.all(
                        color: appColors.black,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              "Order name here.",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    fontSize: 24,
                                  ),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () async {
                                await orderDetailRevealer(true);
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(32),
                                      topRight: Radius.circular(32),
                                    ),
                                  ),
                                  builder: (_) {
                                    return OrderStatusScreen(id: '#123456789');
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 4,
                                shadowColor: appColors.black.withOpacity(0.5),
                                backgroundColor: appColors.primaryGreen,
                              ),
                              child: Text(
                                'Status',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .copyWith(
                                      color: appColors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            )
                          ],
                        ),
                        Divider(
                          color: appColors.warning,
                          thickness: 1,
                        ),
                        const SizedBox(height: 16),
                        descriptionWidget(context, "Order ID", '#123456789'),
                        const SizedBox(height: 16),
                        descriptionWidget(
                          context,
                          "Order Date",
                          DateFormatUtil.formatDate(
                            dateTimeFormat,
                            DateTime.now().toIso8601String(),
                          ),
                        ),
                        const SizedBox(height: 16),
                        descriptionWidget(context, "Order Type", 'Instant'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Your order.",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 24,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: appColors.white,
                    ),
                    child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: appColors.primaryGreen,
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Image.asset(
                            'assets/png/food1.png',
                            fit: BoxFit.cover,
                            width: 90,
                            height: 80,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sweet chilli chicken",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 14,
                                    color: appColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Wrap x1, 1kg",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 14,
                                    color: appColors.black,
                                  ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Add-On: French fries x1",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontSize: 14,
                                    color: appColors.black,
                                  ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> orderDetailRevealer(bool isStart) async {
    await Future.delayed(
      Duration(milliseconds: 300),
      () {
        setState(() {
          if (startPos == -1 && isStart) {
            curve = curve == Curves.elasticOut
                ? Curves.elasticIn
                : Curves.elasticOut;
            startPos = 0.0;
            endPos = 1.0;
          } else {
            curve = curve == Curves.elasticOut
                ? Curves.elasticOut
                : Curves.elasticIn;
            startPos = -1.0;
            endPos = 0.0;
          }
        });
      },
    );
  }

  Row descriptionWidget(
      BuildContext context, String title, String description) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
        ),
        Text(
          description,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }
}
