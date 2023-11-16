import 'package:eden_app/features/dashboard/presentation/widget/order_status_widget.dart';
import 'package:flutter/material.dart';

class OrderStatusScreen extends StatefulWidget {
  const OrderStatusScreen({
    super.key,
    required this.id,
  });
  final String id;

  @override
  State<OrderStatusScreen> createState() => _OrderStatusScreenState();
}

class _OrderStatusScreenState extends State<OrderStatusScreen> {
  final _sheet = GlobalKey();
  final _controller = DraggableScrollableController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onChanged);
  }

  void _onChanged() {
    setState(() {
      final currentSize = _controller.size;

      if (currentSize <= 0.15) _collapse();
    });
  }

  void _collapse() => _animateSheet(0);

  void _animateSheet(double? size) {
    _controller.animateTo(
      size ?? 0.0,
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  DraggableScrollableSheet get sheet =>
      (_sheet.currentWidget as DraggableScrollableSheet);
  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      key: _sheet,
      initialChildSize: 0.5,
      maxChildSize: 0.95,
      expand: false,
      minChildSize: 0,
      controller: _controller,
      builder: (context, controller) => ListView(
        padding: EdgeInsets.only(bottom: 50),
        children: [
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                      text: "Order ",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontSize: 18,
                          )),
                  TextSpan(
                    text: widget.id,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextSpan(
                    text: " Status",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontSize: 18,
                        ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              controller: controller,
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  // Show if status is in progress
                  ...List.generate(
                    12,
                    (index) => Column(
                      children: [
                        OrderStatusWidget(),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ).toList(),
                  const SizedBox(height: 200),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
