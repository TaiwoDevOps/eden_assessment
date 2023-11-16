import 'package:eden_app/features/auth/presentation/screens/auth_screen.dart';
import 'package:eden_app/utils/theme.dart';
import 'package:flutter/material.dart';

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
    _key = LabeledGlobalKey("button_icon");
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
          backgroundColor: appColors.deepGreen,
          backgroundImage: NetworkImage(
            'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
            scale: 1.4,
          ),
        ),
      ),
    );
  }

  OverlayEntry _overlayEntryBuilder() {
    return OverlayEntry(
      builder: (context) {
        return Positioned.fill(
          top:
              110, // app bar is using a preferred size of 80, adding extra gives the overlay a bit of space
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
                              'User@email.com',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
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
                              'User Name',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
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
