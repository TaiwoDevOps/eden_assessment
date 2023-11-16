import 'package:eden_app/features/auth/presentation/widget/auth_button.dart';
import 'package:eden_app/features/dashboard/presentation/screens/order_screen.dart';
import 'package:eden_app/utils/theme.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              color: appColors.deepGreen,
              image: DecorationImage(
                alignment: Alignment.bottomCenter,
                image: AssetImage("assets/gif/eden_gif.gif"),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  'look good. feel \ngood. \nlive better.',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: appColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      height: 1.5),
                ),
                const SizedBox(height: 40),
                SocialButton(
                  title: 'Google',
                  asset: 'assets/png/g-logo.png',
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const OrderScreen()),
                        (Route<dynamic> route) => false);
                  },
                ),
                const SizedBox(height: 20),
                SocialButton(
                  title: 'GitHub',
                  asset: 'assets/png/git-logo.png',
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const OrderScreen()),
                        (Route<dynamic> route) => false);
                  },
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
          IgnorePointer(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  'flourish,\nevery \nday.',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: appColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      height: 1.2),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
