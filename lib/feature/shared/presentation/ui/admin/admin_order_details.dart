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

  /// Initializes the [_AdminOrderDetailsState] with the necessary text editing controllers
  /// and sets the initial values for the controllers based on the [widget.deliveryInfo] parameter.
  @override
  void initState() {
    // Call the parent's initState method
    super.initState();

    // Set the initial value for the "date order" controller
    controllers["date order"]!.text = widget.deliveryInfo.order!.dateOrder!;
    // Set the initial value for the "time order" controller
    controllers["time order"]!.text = widget.deliveryInfo.order!.timeOrder!;
    // Set the initial value for the "order number" controller
    controllers["order number"]!.text = widget.deliveryInfo.order!.numberOrder!;
    // Set the initial value for the "sum order" controller
    controllers["sum order"]!.text = widget.deliveryInfo.order!.sumOrder!;
    // Set the initial value for the "shop address" controller
    controllers["shop address"]!.text =
        widget.deliveryInfo.shopAddresses!.shopAddressDirection ?? "";
    // Set the initial value for the "user address" controller
    controllers["user address"]!.text =
        widget.deliveryInfo.addresses!.directionAddress ?? "";
  }

  @override

  /// Builds the widget tree for the AdminOrderDetails screen.
  ///
  /// This method builds the widget tree for the AdminOrderDetails screen,
  /// which displays details about a specific order. It includes various
  /// text fields for displaying information about the order, such as the
  /// date and time of the order, the order number, and the sum of the order.
  /// It also includes a dropdown menu for selecting the status of the order.
  /// Finally, it includes a button for editing the status of the order.
  Widget build(BuildContext context) {
    // Check if the device is a mobile device
    final isMobile = Responsive.isMobile(context);

    // Build the widget tree
    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Build the header row
                    Row(
                      children: [
                        IconButton(
                          padding: EdgeInsets.zero,
                          onPressed: () {
                            // Navigate back to the previous screen
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
                    // Build the order details row
                    Row(
                      children: [
                        Icon(Icons.assignment,
                            size: 500, color: AppColors.darkBrown),
                        Expanded(
                            child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                              // Build the text fields for order details

                              for (var field in controllers.keys)
                                Methods.getControllerForField(
                                            controllers, field)
                                        .text
                                        .isNotEmpty
                                    ? BasicTextField(
                                        title: field,
                                        controller:
                                            Methods.getControllerForField(
                                                controllers, field),
                                        isEnabled: false,
                                      )
                                    : const SizedBox(),

                              // Build the dropdown menu for status selection
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
                                          isColorDropdown: false,
                                        );
                                      }
                                      return const SizedBox();
                                    },
                                  )),
                            ]))
                      ],
                    ),
                    // Build the edit status button
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

  /// Edit the status of an order.
  ///
  /// This function updates the status of an order by calling the [UpdateStatues] event
  /// and navigates back to the [adminAllOrders] page.
  void _editStatus() async {
    // Set the id of the updated status to the id of the order
    updatedStatus.id = widget.deliveryInfo.order!.idOrder!;

    // Set the status id of the updated status to the id of the selected status
    updatedStatus.statusID = statuses
        .firstWhere((status) => status.idStatus == selectedStatusIndex! + 1)
        .idStatus!;

    // Add the UpdateStatues event to the RemoteStatusBloc
    service<RemoteStatusBloc>().add(UpdateStatues(updatedStatus));

    // Wait for 1 second
    await Future.delayed(const Duration(seconds: 1));

    // Pop the current route and push to the adminAllOrders page
    router.pop();
    router.push(
      Pages.adminAllOrders.screenPath,
    );
  }
}
