import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/methods.dart';
import 'package:xc_web_admin/config/responsive.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/button/build_button.dart';
import 'package:xc_web_admin/core/widget/dropdown/basic_dropdown.dart';
import 'package:xc_web_admin/core/widget/header/basic_header_text.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/text/card_text.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/edit_status_dto.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/delivery_info.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/order_comp_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/status_order_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/order_comp/order_comp_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/order_comp/order_comp_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/order_comp/order_comp_state.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/status/status_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/status/status_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/status/status_state.dart';
import 'package:xc_web_admin/generated/l10n.dart';

class OrderDetails extends StatefulWidget {
  final DeliveryInfoEntity deliveryInfo;
  const OrderDetails({super.key, required this.deliveryInfo});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  late final Map<String, TextEditingController> controllers;
  final StatusDTO updatedStatus = StatusDTO();
  late List<StatusOrderEntity> statuses;

  late int? selectedStatusIndex;
  bool isInitialized = false;

  /// Initializes the [_OrderDetailsState] with the necessary text editing controllers
  /// and sets the initial values for the controllers based on the [widget.deliveryInfo] parameter.
  @override
  void initState() {
    // Call the parent's initState method
    super.initState();

    selectedStatusIndex =
        widget.deliveryInfo.order!.currentStatus!.idStatus! - 1;
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

    if (isInitialized == false) {
      controllers = {
        S.of(context).dateOrder:
            TextEditingController(text: widget.deliveryInfo.order!.dateOrder!),
        S.of(context).timeOrder:
            TextEditingController(text: widget.deliveryInfo.order!.timeOrder!),
        S.of(context).orderNumber: TextEditingController(
            text: widget.deliveryInfo.order!.numberOrder!),
        S.of(context).sumOrder:
            TextEditingController(text: widget.deliveryInfo.order!.sumOrder!),
        S.of(context).shopAddress: TextEditingController(
            text:
                widget.deliveryInfo.shopAddresses!.shopAddressDirection ?? ""),
        S.of(context).userAddress: TextEditingController(
            text: widget.deliveryInfo.addresses!.directionAddress ?? ""),
      };
      isInitialized = true;
    }

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
                                  title: S.current.orderDetails,
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
                              _buildStatusesDropdown()
                            ])),
                      ],
                    ),
                    BasicText(title: S.current.orderComposition),
                    _buildOrderCompList(),

                    // Build the edit status button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        buildButton(S.current.editStatus, AppColors.darkBrown,
                            _editStatus),
                      ],
                    ),
                  ],
                ))));
  }

  /// Builds a dropdown widget that displays a list of statuses retrieved from a
  /// RemoteStatusBloc. When a status is selected, the selected status index is
  /// stored in [selectedStatusIndex].
  ///
  /// Returns a [BasicDropdown] widget.
  Widget _buildStatusesDropdown() {
    // Provides the RemoteStatusBloc to its child
    return BlocProvider<RemoteStatusBloc>(
      create: (context) =>
          service<RemoteStatusBloc>()..add(const GetStatuses()),
      // Builds the dropdown based on the state of the RemoteStatusBloc
      child: BlocBuilder<RemoteStatusBloc, RemoteStatusState>(
        builder: (_, state) {
          // If the RemoteStatusBloc has retrieved the statuses
          if (state is RemoteStatusDone) {
            // Sort the statuses by their id
            statuses = state.statuses!;
            statuses.sort((a, b) => a.idStatus!.compareTo(b.idStatus!));

            // Build the dropdown widget
            return BasicDropdown(
              listTitle: S.current.statusOrder,
              // Map the status names to a list of strings
              dropdownData: statuses.map((e) => e.nameStatus!).toList(),
              // Set the selected index to the stored selected status index
              selectedIndex: selectedStatusIndex!,
              // When the selected index changes, update the selected status index
              onIndexChanged: (value) {
                setState(() {
                  selectedStatusIndex = state.statuses![value].idStatus! - 1;
                });
              },
              isColorDropdown: false,
            );
          }
          // If the RemoteStatusBloc has not retrieved the statuses, return an empty SizedBox
          return const SizedBox();
        },
      ),
    );
  }

  Widget _buildOrderCompList() {
    final isMobile = Responsive.isMobile(context);
    return Row(
      children: [
        Expanded(
          child: BlocProvider<RemoteOrderCompBloc>(
            create: (context) => service<RemoteOrderCompBloc>()
              ..add(GetOrderCompByOrderId(
                  id: widget.deliveryInfo.order!.idOrder!)),
            child: BlocBuilder<RemoteOrderCompBloc, RemoteOrderCompState>(
              builder: (_, state) {
                switch (state.runtimeType) {
                  case RemoteOrderCompDone:
                    List<OrderCompositionEntity> compositions =
                        state.compositions!;
                    return SizedBox(
                      height: 500, // Set a fixed height
                      child: ListView.builder(
                        itemCount: compositions.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: BasicContainer(
                                child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      height: isMobile ? 75 : 200,
                                      width: isMobile ? 75 : 200,
                                      child: CachedNetworkImage(
                                        imageUrl: compositions[index]
                                            .clothesComp!
                                            .clothesPhoto!,
                                        fit: BoxFit.fill,
                                        height: 200,
                                        width: 200,
                                      )),
                                ),
                                Column(
                                  children: [
                                    BasicText(
                                        title: compositions[index]
                                            .clothesComp!
                                            .nameClothesEn!),
                                    CardText(
                                        title:
                                            "${S.current.barcode}: ${compositions[index].clothesComp!.barcode!}"),
                                    CardText(
                                        title:
                                            "${S.current.size}: ${compositions[index].sizeClothes!.nameSize!}"),
                                    CardText(
                                        title:
                                            "${S.current.color}: ${compositions[index].colorClothes!.nameColor!}"),
                                  ],
                                ),
                                const Spacer(),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CardText(
                                        title:
                                            "${compositions[index].clothesComp!.priceClothes}₽ X ${compositions[index].quantity} "),
                                  ],
                                )
                              ],
                            )),
                          );
                        },
                      ),
                    );

                  case RemoteOrderCompError:
                    return Text(S.of(context).error);
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ],
    );
  }

  /// Edit the status of an order.
  ///
  /// This function updates the status of an order by calling the [UpdateStatues] event
  /// and navigates back to the [adminAllOrders] page.
  void _editStatus() async {
    // Set the id of the updated status to the id of the order
    updatedStatus.id = widget.deliveryInfo.order!.idOrder!;

    // Set the status id of the updated status to the id of the selected status
    updatedStatus.statusID = selectedStatusIndex! + 1;

    // Add the UpdateStatues event to the RemoteStatusBloc
    service<RemoteStatusBloc>().add(UpdateStatues(updatedStatus));

    // Wait for 1 second
    await Future.delayed(const Duration(seconds: 1));

    // Pop the current route and push to the adminAllOrders page
    router.pop();

    if (SessionStorage.getValue("role") == "admin") {
      router.push(
        Pages.adminAllOrders.screenPath,
      );
    }
    if (SessionStorage.getValue("role") == "director") {
      router.push(
        Pages.directorAllOrders.screenPath,
      );
    }
    if (SessionStorage.getValue("role") == "employee") {
      router.push(
        Pages.employeeAllOrders.screenPath,
      );
    }
  }
}
