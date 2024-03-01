import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/dropdown/basic_dropdown.dart';
import 'package:xc_web_admin/core/widget/header/basic_header_text.dart';
import 'package:xc_web_admin/core/widget/text/base_button_text.dart';
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
  late final TextEditingController dateOrderController;
  late final TextEditingController timeOrderController;
  late final TextEditingController orderNumberController;
  late final TextEditingController sumOrderController;
  late final TextEditingController shopAddressController;
  late final TextEditingController userAddressController;
  final StatusDTO updatedStatus = StatusDTO();
  late List<StatusOrderEntity> statuses;

  late int? selectedStatusIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dateOrderController =
        TextEditingController(text: widget.deliveryInfo.order!.dateOrder);
    timeOrderController =
        TextEditingController(text: widget.deliveryInfo.order!.timeOrder);
    orderNumberController =
        TextEditingController(text: widget.deliveryInfo.order!.numberOrder);
    sumOrderController =
        TextEditingController(text: widget.deliveryInfo.order!.sumOrder);
    shopAddressController = TextEditingController(
        text: widget.deliveryInfo.shopAddresses!.shopAddressDirection);
    userAddressController = TextEditingController(
        text: widget.deliveryInfo.addresses!.directionAddress);
  }

  @override
  Widget build(BuildContext context) {
    final fields = [
      "date order",
      "time order",
      "order number",
      "sum order",
      "shop address",
      "user address"
    ];
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
                              for (var field in fields)
                                _getControllerForField(field).text.isNotEmpty
                                    ? BasicTextField(
                                        title: field,
                                        controller:
                                            _getControllerForField(field),
                                        isEnabled: false,
                                      )
                                    : const SizedBox(),
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
                                              print(selectedStatusIndex);
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
                        _buildButton(
                            "Edit status", AppColors.darkBrown, _editStatus),
                      ],
                    ),
                  ],
                ))));
  }

  // Function to get the controller for a specific input field
  TextEditingController _getControllerForField(String field) {
    switch (field) {
      case "date order":
        return dateOrderController;
      case "time order":
        return timeOrderController;
      case "order number":
        return orderNumberController;
      case "sum order":
        return sumOrderController;
      case "shop address":
        return shopAddressController;
      case "user address":
        return userAddressController;
      default:
        throw Exception("Invalid field: $field");
    }
  }

  // Widget for building custom buttons
  Widget _buildButton(
      String title, Color backgroundColor, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: BaseButtonText(title: title),
      ),
    );
  }

  //FIXME: id of status got from selectedStatusIndex is not correct.

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
