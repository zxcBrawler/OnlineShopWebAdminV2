import 'package:flutter/material.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';

class AdminTotalItems extends StatefulWidget {
  const AdminTotalItems({super.key});

  @override
  State<AdminTotalItems> createState() => _AdminTotalItemsState();
}

class _AdminTotalItemsState extends State<AdminTotalItems> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 2,
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 8, top: 20, left: 8, right: 8),
              child: BasicContainer(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const BasicText(title: "total items: "),
                      const BasicText(title: "999"),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {
                                  // router.go(Pages
                                  //     .adminWeeklyActivityDetails.screenPath);
                                },
                                icon: const Icon(
                                  Icons.chevron_right,
                                  size: 35,
                                )),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
