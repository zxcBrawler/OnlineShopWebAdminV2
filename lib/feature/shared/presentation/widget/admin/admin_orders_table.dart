import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xc_web_admin/config/pdf_service.dart';
import 'package:xc_web_admin/core/widget/searchbar/basic_search_bar.dart';
import 'package:xc_web_admin/core/widget/table/basic_data_source.dart';
import 'package:xc_web_admin/core/widget/table/basic_table.dart';
import 'package:xc_web_admin/core/widget/table/colums_generator.dart';
import 'package:xc_web_admin/core/widget/text/card_text.dart';
import 'package:xc_web_admin/core/widget/widget/basic_container.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/delivery_info.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_state.dart';
import 'package:xc_web_admin/generated/l10n.dart';

class OrdersTable extends StatefulWidget {
  const OrdersTable({super.key});

  @override
  State<OrdersTable> createState() => _OrdersTableState();
}

class _OrdersTableState extends State<OrdersTable> {
  String _searchQuery = ''; // Store the search query
  @override

  /// Builds the widget tree based on the state of the [RemoteDeliveryInfoBloc].
  ///
  /// Wraps the widget with [BlocProvider] to provide the [RemoteDeliveryInfoBloc].
  /// Creates an instance of [RemoteDeliveryInfoBloc] using the [service] method.
  /// Listens for changes in the state of [RemoteDeliveryInfoBloc] using [BlocBuilder].
  ///
  /// Returns the widget tree based on the runtime type of the state.
  @override
  Widget build(BuildContext context) {
    // Initialize list to store all the orders
    List<DeliveryInfoEntity> allOrders = [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Add search bar widget to filter orders
        BasicSearchBar(
          onChangedCallback: (value) {
            setState(() {
              _searchQuery =
                  value?.toLowerCase() ?? ''; // Update the search query
            });
          },
        ),
        // Add button to generate pdf of all orders
        Row(
          children: [
            CardText(title: S.of(context).generatePdf),
            SizedBox(
              height: 70,
              width: 70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BasicContainer(
                  child: IconButton(
                    onPressed: () {
                      PdfService().printOrdersPDF(
                          allOrders); // Generate pdf of all orders
                    },
                    icon: const Icon(Icons.description),
                  ),
                ),
              ),
            ),
          ],
        ),
        // Add bloc provider to listen for changes in state of RemoteDeliveryInfoBloc
        BlocProvider<RemoteDeliveryInfoBloc>(
          create: (context) => service()..add(const GetDeliveryInfo()),
          child: BlocBuilder<RemoteDeliveryInfoBloc, RemoteDeliveryInfoState>(
            builder: (_, state) {
              // Handle different states of RemoteDeliveryInfoBloc
              switch (state.runtimeType) {
                case RemoteDeliveryInfoLoading:
                  return const Center(child: CircularProgressIndicator());
                case RemoteDeliveryInfoDone:
                  // Filter orders based on search query and update allOrders list
                  allOrders = state.info!
                      .where((element) =>
                          element.order!.numberOrder!.contains(_searchQuery))
                      .toList();
                  // Return table widget with filtered orders
                  return BasicTable(
                    columns: generateColumns(state.info!.first.getProperties()),
                    dataSource: BasicDataSource<DeliveryInfoEntity>(
                      rowsCount: allOrders.length,
                      columnTitles: state.info!.first.getProperties(),
                      data: allOrders,
                    ),
                  );
                case RemoteDeliveryInfoError:
                  return Text(S.of(context).error);
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
