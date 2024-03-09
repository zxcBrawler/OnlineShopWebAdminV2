import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/methods.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/button/build_button.dart';
import 'package:xc_web_admin/core/widget/dropdown/basic_dropdown.dart';
import 'package:xc_web_admin/core/widget/header/basic_header_text.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/edit_status_dto.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/delivery_info.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/status_order_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/status/status_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/status/status_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/status/status_state.dart';

class AdminOrderDetails extends StatefulWidget {
  final DeliveryInfoEntity deliveryInfo;
  const AdminOrderDetails({super.key, required this.deliveryInfo});

  @override
  State<AdminOrderDetails> createState() => _AdminOrderDetailsState();
}

class _AdminOrderDetailsState extends State<AdminOrderDetails> {
  Map<String, TextEditingController> controllers = {
    "date order": TextEditingController(),
    "time order": TextEditingController(),
    "order number": TextEditingController(),
    "sum order": TextEditingController(),
    "shop address": TextEditingController(),
    "user address": TextEditingController(),
  };
  final StatusDTO updatedStatus = StatusDTO();
  late List<StatusOrderEntity> statuses;

  late int? selectedStatusIndex;
  @override
  void initState() {
    super.initState();
    controllers["date order"]!.text = widget.deliveryInfo.order!.dateOrder!;
    controllers["time order"]!.text = widget.deliveryInfo.order!.timeOrder!;
    controllers["order number"]!.text = widget.deliveryInfo.order!.numberOrder!;
    controllers["sum order"]!.text = widget.deliveryInfo.order!.sumOrder!;
    controllers["shop address"]!.text =
        widget.deliveryInfo.shopAddresses!.shopAddressDirection!;
    controllers["user address"]!.text =
        widget.deliveryInfo.addresses!.directionAddress!;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            router.pop(context);
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: AppColors.darkBrown,
                            size: 30,
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                child: HeaderText(
                                  textSize: isMobile ? 35 : 45,
                                  title: 'order details',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.assignment,
                            size: 500, color: AppColors.darkBrown),
                        Expanded(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                              // Text fields for user input
                              // If controller value for the field is not null and is not empty, display the text field
                              for (var field in controllers.keys)
                                BasicTextField(
                                  title: field,
                                  controller: Methods.getControllerForField(
                                      controllers, field),
                                  isEnabled: false,
                                ),

                              BlocProvider<RemoteStatusBloc>(
                                  create: (context) =>
                                      service<RemoteStatusBloc>()
                                        ..add(const GetStatuses()),
                                  child: BlocBuilder<RemoteStatusBloc,
                                      RemoteStatusState>(
                                    builder: (context, state) {
                                      if (state is RemoteStatusDone) {
                                        statuses = state.statuses!;
                                        selectedStatusIndex =
                                            statuses.indexWhere((status) =>
                                                status.idStatus ==
                                                widget.deliveryInfo.order!
                                                    .currentStatus!.idStatus);
                                        return BasicDropdown(
                                          listTitle: "status order",
                                          dropdownData: statuses
                                              .map((e) => e.nameStatus!)
                                              .toList(),
                                          selectedIndex: selectedStatusIndex!,
                                          onIndexChanged: (value) {
                                            setState(() {
                                              selectedStatusIndex = value;
                                            });
                                          },
                                        );
                                      }
                                      return const SizedBox();
                                    },
                                  )),
                            ]))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        buildButton(
                            "Edit status", AppColors.darkBrown, _editStatus),
                      ],
                    ),
                  ],
                ))));
  }

  // Widget for building custom buttons

  //! FIXME: id of status got from selectedStatusIndex is not correct.

  void _editStatus() async {
    updatedStatus.id = widget.deliveryInfo.order!.idOrder!;
    updatedStatus.statusID = statuses
        .firstWhere((status) => status.idStatus == selectedStatusIndex! + 1)
        .idStatus!;

    service<RemoteStatusBloc>().add(UpdateStatues(updatedStatus));
    await Future.delayed(const Duration(seconds: 1));
    router.pop();
    router.push(
      Pages.adminAllOrders.screenPath,
    );
  }
}
