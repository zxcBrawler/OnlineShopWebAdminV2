import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/core/widget/searchbar/basic_search_bar.dart';
import 'package:xc_web_admin/core/widget/table/basic_data_source.dart';
import 'package:xc_web_admin/core/widget/table/basic_table.dart';
import 'package:xc_web_admin/core/widget/table/colums_generator.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_address_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/user_entity.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/address/address_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/address/address_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/address/address_state.dart';

class UserAddressesTable extends StatefulWidget {
  final UserEntity user;
  const UserAddressesTable({super.key, required this.user});

  @override
  State<UserAddressesTable> createState() => _UserAddressesTableState();
}

class _UserAddressesTableState extends State<UserAddressesTable> {
  String _searchQuery = ''; // Store the search query
  @override
  Widget build(BuildContext context) {
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
        BlocProvider<RemoteAddressesBloc>(
          // Create method to provide an instance of RemoteDeliveryInfoBloc
          create: (context) => service()..add(GetAddresses(id: widget.user.id)),
          // Child widget to listen for changes in the state of RemoteDeliveryInfoBloc
          child: BlocBuilder<RemoteAddressesBloc, RemoteAddressState>(
            // Builder method to render the widget based on the state of RemoteDeliveryInfoBloc
            builder: (_, state) {
              // Switch on the runtime type of the state to handle different cases
              switch (state.runtimeType) {
                case RemoteAddressLoading:
                  // Show loading indicator while fetching data
                  return const Center(child: CircularProgressIndicator());
                case RemoteAddressDone:
                  // Filter the orders for the current user
                  List<UserAddressEntity> userOrders = state.addresses!
                      .where((element) =>
                          element.user!.id == widget.user.id &&
                          element.address!.nameAddress!
                              .toLowerCase()
                              .contains(_searchQuery))
                      .toList();
                  // Check if no orders are found for the user
                  if (userOrders.isEmpty) {
                    // Display a message
                    return const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: BasicText(title: "no addresses"),
                    );
                  }
                  // Display a table with the user's orders
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BasicTable(
                      columns: generateColumns(
                          state.addresses!.first.getProperties()),
                      dataSource: BasicDataSource<UserAddressEntity>(
                        rowsCount: userOrders.length,
                        columnTitles: state.addresses!.first.getProperties(),
                        data: userOrders,
                      ),
                    ),
                  );
                case RemoteAddressError:
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
