import 'package:eden_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:eden_app/features/auth/presentation/vm/auth_vm.dart';
import 'package:eden_app/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomCircularAvatar extends StatefulWidget {
  const CustomCircularAvatar({
    Key? key,
  }) : super(key: key);
  @override
  _CustomCircularAvatarState createState() => _CustomCircularAvatarState();
}

class _CustomCircularAvatarState extends State<CustomCircularAvatar>
    with SingleTickerProviderStateMixin {
  late GlobalKey _key;
  bool isMenuOpen = false;
  Size? buttonSize;
  OverlayEntry? _overlayEntry;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
    _key = LabeledGlobalKey("button_option");
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void closeUserInfo() {
    _overlayEntry?.remove();
    _animationController.reverse();
    isMenuOpen = !isMenuOpen;
  }

  void openUserInfo() {
    RenderBox renderBox = _key.currentContext!.findRenderObject()! as RenderBox;
    buttonSize = renderBox.size;
    _animationController.forward();
    _overlayEntry = _overlayEntryBuilder();
    Overlay.of(context).insert(_overlayEntry!);
    isMenuOpen = !isMenuOpen;
  }

  @override
  Widget build(BuildContext context) {
    final userModel = context.watch<AuthProvider>().userData;
    return Container(
      key: _key,
      child: GestureDetector(
        onTap: () {
          if (isMenuOpen) {
            closeUserInfo();
          } else {
            openUserInfo();
          }
        },
        child: CircleAvatar(
          maxRadius: 40,
          backgroundColor: appColors.white,
          backgroundImage: userModel.photoURL.isEmpty
              ? null
              : NetworkImage(
                  userModel.photoURL,
                  scale: 1.4,
                ),
          child: userModel.photoURL.isEmpty
              ? Icon(
                  Icons.person,
                  color: appColors.black,
                )
              : null,
        ),
      ),
    );
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        final userModel = context.watch<AuthProvider>();

        return Positioned.fill(
          top: MediaQuery.of(context).size.height /
              10, // app bar is using a preferred size of 80, adding extra gives the overlay a bit of space
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 15),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 3,
                      right: 14,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: appColors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: appColors.black.withOpacity(0.6),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(Icons.email, color: appColors.black),
                            const SizedBox(width: 8),
                            Text(
                              userModel.userData.email,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Icon(Icons.person, color: appColors.black),
                            const SizedBox(width: 8),
                            Text(
                              userModel.userData.displayName,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 4,
                            shadowColor: appColors.black.withOpacity(0.5),
                            backgroundColor: appColors.primaryGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onPressed: () {
                            closeUserInfo();
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) => const AuthScreen()),
                                (route) => false);
                            userModel.handleSignOut();
                          },
                          child: Text(
                            'LogOut',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
