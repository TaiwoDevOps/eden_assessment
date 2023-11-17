import 'package:eden_app/features/dashboard/presentation/widget/order_detail_widget.dart';
import 'package:eden_app/features/dashboard/presentation/widget/user_profile.dart';
import 'package:eden_app/utils/date_util.dart';
import 'package:eden_app/utils/theme.dart';
import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.only(bottom: 10, top: 6),
          decoration: BoxDecoration(
            color: appColors.white,
            boxShadow: [
              BoxShadow(
                color: appColors.black.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          greet,
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color: appColors.black,
                              ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'What would you like to order?',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: appColors.black),
                      ),
                    ],
                  ),
                ),
                CustomCircularAvatar()
              ],
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: OrderDetailWidget(),
      ),
    );
  }
}
