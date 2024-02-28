import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';

class AdminTopSoldItemsClothesWidget extends StatefulWidget {
  final String title;
  const AdminTopSoldItemsClothesWidget({super.key, required this.title});

  @override
  State<AdminTopSoldItemsClothesWidget> createState() =>
      _AdminTopSoldItemsClothesWidgetState();
}

class _AdminTopSoldItemsClothesWidgetState
    extends State<AdminTopSoldItemsClothesWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: BasicContainer(
          child: Row(
        children: [
          BasicText(
            title: widget.title,
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      //router.go(Pages.adminWeeklyActivityDetails.screenPath);
                    },
                    icon: const Icon(
                      Icons.chevron_right,
                      size: 35,
                    )),
              )
            ],
          )
        ],
      )),
    ));
  }
}
