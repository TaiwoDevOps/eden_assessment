import 'package:eden_app/features/ui_widgets/dashed_lines.dart';
import 'package:eden_app/utils/date_util.dart';
import 'package:eden_app/utils/strings_util.dart';
import 'package:eden_app/utils/theme.dart';
import 'package:flutter/material.dart';

class OrderStatusWidget extends StatelessWidget {
  const OrderStatusWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 8,
      width: double.infinity,
      child: Row(
        children: [
          const SizedBox(width: 16),
          Column(
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: appColors.primaryGreen,
                  shape: BoxShape.circle,
                ),
              ),
              Expanded(
                child: DashedLine(
                  axis: Axis.vertical,
                  dashWidth: 3,
                  dashSpace: 2,
                  color: appColors.black,
                ),
              ),
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: appColors.primaryGreen,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  // show check icon if status is completed and successful, show cancel icon on failed, else, show empty
                  child: Icon(
                    Icons.check,
                    color: appColors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                border: Border.all(
                  color: appColors.black.withOpacity(0.4),
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Status title",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontSize: 16,
                            ),
                      ),
                      Text(
                        DateTime.now().timeAgo().capitalize(),
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontSize: 12,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Description",
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          fontSize: 12,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
        ],
      ),
    );
  }
}
