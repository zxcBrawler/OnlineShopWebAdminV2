import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/responsive.dart';

class UserInfo extends StatefulWidget {
  //add string for username
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    if (Responsive.isDesktop(context)) {
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
                child: Icon(
                  Icons.account_circle,
                  color: AppColors.white,
                  size: 40,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "username", // pass widget string here
                  style: GoogleFonts.hammersmithOne(
                      textStyle:
                          TextStyle(color: AppColors.white, fontSize: 20)),
                ),
              ),
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
    } else if (Responsive.isTablet(context)) {
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
                child: Icon(
                  Icons.account_circle,
                  color: AppColors.white,
                  size: 40,
                ),
              ),
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
