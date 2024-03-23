import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/widget/searchbar/basic_search_bar.dart';
import 'package:xc_web_admin/core/widget/table/basic_data_source.dart';
import 'package:xc_web_admin/core/widget/table/basic_table.dart';
import 'package:xc_web_admin/core/widget/table/colums_generator.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/delivery_info.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_state.dart';

class UserOrdersTable extends StatefulWidget {
  final UserEntity user;
  const UserOrdersTable({super.key, required this.user});

  @override
  State<UserOrdersTable> createState() => _UserOrdersTableState();
}

class _UserOrdersTableState extends State<UserOrdersTable> {
  String _searchQuery = ''; // Store the search query
  @override

  /// Builds the widget tree based on the state of the [RemoteDeliveryInfoBloc].
  ///
  /// Wraps the widget with [BlocProvider] to provide the [RemoteDeliveryInfoBloc].
  /// Creates an instance of [RemoteDeliveryInfoBloc] using the [service] method.
  /// Listens for changes in the state of [RemoteDeliveryInfoBloc] using [BlocBuilder].
  /// Returns the widget tree based on the runtime type of the state.
  Widget build(BuildContext context) {
    // Wrap the widget with BlocProvider to provide the RemoteDeliveryInfoBloc
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BasicSearchBar(
          onChangedCallback: (value) {
            setState(() {
              _searchQuery =
                  value?.toLowerCase() ?? ''; // Update the search query
            });
          },
        ),
        BlocProvider<RemoteDeliveryInfoBloc>(
          // Create method to provide an instance of RemoteDeliveryInfoBloc
          create: (context) => service()..add(const GetDeliveryInfo()),
          // Child widget to listen for changes in the state of RemoteDeliveryInfoBloc
          child: BlocBuilder<RemoteDeliveryInfoBloc, RemoteDeliveryInfoState>(
            // Builder method to render the widget based on the state of RemoteDeliveryInfoBloc
            builder: (_, state) {
              // Switch on the runtime type of the state to handle different cases
              switch (state.runtimeType) {
                case RemoteDeliveryInfoLoading:
                  // Show loading indicator while fetching data
                  return const Center(child: CircularProgressIndicator());
                case RemoteDeliveryInfoDone:
                  // Filter the orders for the current user
                  List<DeliveryInfoEntity> userOrders = state.info!
                      .where((element) =>
                          element.order?.userCard?.user?.id == widget.user.id &&
                          element.order!.numberOrder!.contains(_searchQuery))
                      .toList();
                  // Check if no orders are found for the user
                  if (userOrders.isEmpty) {
                    // Display a message
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: BasicText(title: "no orders"),
                    );
                  }
                  // Display a table with the user's orders
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BasicTable(
                      columns:
                          generateColumns(state.info!.first.getProperties()),
                      dataSource: BasicDataSource<DeliveryInfoEntity>(
                        rowsCount: userOrders.length,
                        columnTitles: state.info!.first.getProperties(),
                        data: userOrders,
                      ),
                    ),
                  );
                case RemoteDeliveryInfoError:
                  // Display error message
                  return const Text("error");
                default:
                  // Return an empty SizedBox if no case is matched
                  return const SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }
}
