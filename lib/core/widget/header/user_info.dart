import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/responsive.dart';

class UserInfo extends StatefulWidget {
  final String username;
  const UserInfo({super.key, required this.username});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override

  /// Builds the UserInfo widget based on the device type.
  ///
  /// If the device is a desktop, it displays the username along with an
  /// account icon and a dropdown menu icon. If the device is mobile,
  /// it only displays the account icon.
  Widget build(BuildContext context) {
    // Check if the device is a desktop
    if (Responsive.isDesktop(context)) {
      // Return a container widget with a rounded border and a background color
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.darkBrown),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              // Add an account icon
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.account_circle,
                  color: AppColors.white,
                  size: 40,
                ),
              ),
              // Add the username as a text widget
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.username, // Pass widget string here
                  style: GoogleFonts.hammersmithOne(
                      textStyle:
                          TextStyle(color: AppColors.white, fontSize: 20)),
                ),
              ),
              // Add a dropdown menu icon
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.expand_more,
                    size: 40,
                  ),
                  color: AppColors.white,
                  iconSize: 30,
                  onPressed: () {},
                ),
              )
            ],
          ),
        ),
      );
    } else {
      // Return a container widget with a rounded border and a background color
      // containing only an account icon
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColors.darkBrown),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.account_circle,
                    size: 40,
                  ),
                  color: AppColors.white,
                  iconSize: 30,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
