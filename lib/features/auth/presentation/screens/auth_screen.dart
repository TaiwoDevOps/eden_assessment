import 'package:eden_app/features/auth/presentation/vm/auth_vm.dart';
import 'package:eden_app/features/auth/presentation/widget/auth_button.dart';
import 'package:eden_app/features/dashboard/presentation/screens/order_screen.dart';
import 'package:eden_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late AuthProvider authProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      authProvider.init();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    authProvider = context.watch<AuthProvider>();

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
                  loading: authProvider.loading,
                  onPressed: () async {
                    await authProvider.signInWithGoogle();
                    if (authProvider.userData != null) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const OrderScreen()),
                          (Route<dynamic> route) => false);
                    }
                  },
                ),
                const SizedBox(height: 20),
                SocialButton(
                  title: 'GitHub',
                  asset: 'assets/png/git-logo.png',
                  loading: authProvider.gLoading,
                  onPressed: () async {
                    await authProvider.signInWithGitHub(context);
                    if (authProvider.userData != null) {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                              builder: (context) => const OrderScreen()),
                          (Route<dynamic> route) => false);
                    }
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
