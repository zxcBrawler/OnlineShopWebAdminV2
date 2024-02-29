import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/data/model/shop_address.dart';
import 'package:xc_web_admin/feature/shared/data/model/user.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shopAddress/shop_address_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shopAddress/shop_address_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_event.dart';

class TableIcons<T> extends StatefulWidget {
  final String type;
  final T data;

  const TableIcons({
    Key? key,
    required this.type,
    required this.data,
  }) : super(key: key);

  @override
  State<TableIcons> createState() => _TableIconsState();
}

class _TableIconsState extends State<TableIcons> {
  @override
  Widget build(BuildContext ctx) {
    return Row(
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => _handleMoreOption(),
          icon: Icon(
            Icons.more_horiz,
            size: 30,
            color: AppColors.darkBrown,
          ),
        ),
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () => _handleDeleteOption(ctx),
          icon: const Icon(
            Icons.delete,
            size: 30,
            color: Colors.red,
          ),
        )
      ],
    );
  }

  /// Handles the action when the user taps on the "More Options" button.
  ///
  /// Depending on the data type specified in [widget.type], navigates to the
  /// corresponding page for detailed information.
  void _handleMoreOption() {
    // Switch statement based on the data type
    switch (widget.type) {
      // For ShopAddressModel, navigate to the detailed shop address information page
      case "ShopAddressModel":
        router.push(
          Pages.adminShopAddressInfo.screenPath,
          extra: {widget.data as ShopAddressModel},
        );
        break;
      // For UserModel, navigate to the detailed user information page
      case "UserModel":
        router.push(
          Pages.adminUserInfo.screenPath,
          extra: {widget.data as UserModel},
        );
        break;
      // Default case does nothing
      default:
        break;
    }
  }

  /// Displays a confirmation dialog for item deletion and handles user actions.
  ///
  /// Shows an AlertDialog with options to confirm or cancel the deletion. If confirmed,
  /// calls the [_handleDelete] function to perform the deletion based on the data type.
  ///
  /// Parameters:
  ///   - context: The BuildContext used to display the dialog.
  Future<void> _handleDeleteOption(BuildContext context) async {
    // Show a confirmation dialog using the provided BuildContext
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm deletion'),
          content: const Text('Are you sure you want to delete this data?'),
          actions: [
            // Yes button triggers the deletion process
            TextButton(
              onPressed: () async {
                // Call the _handleDelete function to perform deletion
                await _handleDelete();
              },
              child: const BasicText(
                title: 'Yes',
              ),
            ),
            // No button closes the dialog without performing deletion
            TextButton(
              onPressed: () {
                // Close the dialog
                router.pop();
              },
              child: const BasicText(
                title: 'No',
              ),
            ),
          ],
        );
      },
    );
  }

  /// Handles the deletion process depending on the data type specified in [widget.type].
  Future<void> _handleDelete() async {
    switch (widget.type) {
      case "ShopAddressModel":
        ShopAddressModel shopAddress = widget.data as ShopAddressModel;
        service<RemoteShopAddressesBloc>()
            .add(DeleteShopAddress(shopAddress.shopAddressId));
        await Future.delayed(const Duration(seconds: 1));
        router.pop();
        router.push(
          Pages.adminShops.screenPath,
        );
        break;
      case "UserModel":
        UserModel user = widget.data as UserModel;
        if (user.role!.roleName! != "user") {
          service<RemoteUserBloc>().add(DeleteUser(id: user.id!));
          await Future.delayed(const Duration(seconds: 1));
          router.pop();
          router.push(
            Pages.adminAllUsers.screenPath,
          );
        } else {
          //TODO: handle case when user wants to delete buyer (that's not allowed)
          router.pop();
        }

        break;
      default:
        break;
    }
  }
}
