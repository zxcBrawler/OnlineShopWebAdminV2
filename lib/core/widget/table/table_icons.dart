import 'package:flutter/material.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/config/methods.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/data/model/clothes.dart';
import 'package:xc_web_admin/feature/shared/data/model/color.dart';
import 'package:xc_web_admin/feature/shared/data/model/delivery_info.dart';
import 'package:xc_web_admin/feature/shared/data/model/shop_address.dart';
import 'package:xc_web_admin/feature/shared/data/model/shop_garnish.dart';
import 'package:xc_web_admin/feature/shared/data/model/user.dart';
import 'package:xc_web_admin/feature/shared/data/model/user_address.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shopAddress/shop_address_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shopAddress/shop_address_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/widget/admin/admin_user_address_info_dialog.dart';

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

  /// Builds the widget tree for the table icons.
  ///
  /// This method builds a row containing two icon buttons. The first icon button
  /// displays the "more" option, while the second icon button displays the delete
  /// option. The onPressed callbacks for both buttons are set to call the
  /// respective handling methods.
  ///
  /// Parameters:
  ///   - ctx: The build context of the widget tree.
  ///
  /// Returns:
  ///   - A row widget containing two icon buttons.
  Widget build(BuildContext ctx) {
    bool isUser = false;
    UserModel? userData;
    if (widget.data is UserModel) {
      userData = widget.data as UserModel;
      if (userData.role!.roleName == 'user') {
        isUser = true;
      } else {
        isUser = false;
      }
    }
    bool isUserAddress = false;

    if (widget.data is UserAddressModel) {
      isUserAddress = true;
    } else {
      isUserAddress = false;
    }

    // Build the widget tree for the table icons with the delete option

    // Build the widget tree for the table icons.
    return Row(
      children: [
        // Build the "more" option icon button
        IconButton(
          padding: EdgeInsets.zero,
          onPressed: () =>
              _handleMoreOption(), // Call the handling method when pressed
          icon: Icon(
            Icons.more_horiz,
            size: 30,
            color: AppColors.darkBrown, // Set the color to dark brown
          ),
        ),
        // Build the delete option icon button

        SessionStorage.getValue('role') != 'employee' &&
                isUser == false &&
                isUserAddress == false
            ? IconButton(
                padding: EdgeInsets.zero,
                onPressed: () => _handleDeleteOption(
                    ctx), // Call the handling method when pressed
                icon: const Icon(
                  Icons.delete,
                  size: 30,
                  color: Colors.red, // Set the color to red
                ),
              )
            : const SizedBox(),
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
      // Case for ShopAddressModel, navigate to the detailed shop address information page
      case "ShopAddressModel":
        // Navigate to the detailed shop address information page with the shop address data
        router.push(
          Pages.adminShopAddressInfo.screenPath,
          extra: {widget.data as ShopAddressModel},
        );
        break;
      // Case for UserModel, navigate to the detailed user information page
      case "UserModel":
        // Navigate to the detailed user information page with the user data
        router.push(
          Pages.adminUserInfo.screenPath,
          extra: {widget.data as UserModel},
        );
        break;

      // Case for DeliveryInfoModel, navigate to the detailed order information page
      case "DeliveryInfoModel":
        // Navigate to the detailed order information page with the delivery info data

        router.push(
          Pages.adminOrderDetails.screenPath,
          extra: {widget.data as DeliveryInfoModel},
        );

        break;
      // Case for ClothesModel, navigate to the detailed clothes information page
      case "ClothesModel":
        // Navigate to the detailed clothes information page with the clothes data
        router.push(
          Pages.adminClothesDetails.screenPath,
          extra: {widget.data as ClothesModel},
        );
        break;
      case "UserAddressModel":
        // Navigate to the detailed clothes information page with the clothes data
        showDialog(
            context: context,
            builder: (BuildContext context) => UserAddressDialog(
                  address: widget.data as UserAddressModel,
                ));
        break;

      // Case for ShopGarnishModel, navigate to the detailed clothes information page
      case "ShopGarnishModel":
        // Navigate to the detailed clothes information page with the clothes data
        SessionStorage.getValue('role') != 'employee'
            ? router.push(
                Pages.directorClothesDetails.screenPath,
                extra: {widget.data as ShopGarnishModel},
              )
            : router.push(
                Pages.employeeClothesDetails.screenPath,
                extra: {widget.data as ShopGarnishModel},
              );
        break;

      // Case for ColorModel, show a dialog with the color preview
      case "ColorModel":
        // Show a dialog with the color preview
        showDialog(
          context: context,
          builder: (BuildContext context) {
            ColorModel? currentColor = widget.data! as ColorModel;
            return Dialog(
              backgroundColor:
                  Methods.getColorFromHex(currentColor.hex ?? "##FFF"),
              child: const SizedBox(
                height: 300,
                width: 300,
              ),
            );
          },
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
            // "Yes" button triggers the deletion process
            TextButton(
              onPressed: () async {
                // Call the _handleDelete function to perform deletion
                await _handleDelete();
              },
              child: const BasicText(
                title: 'Yes',
              ),
            ),
            // "No" button closes the dialog without performing deletion
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
  ///
  /// Deletion process is different for each data type:
  ///  - For "ShopAddressModel", deletes the shop address from the remote database and navigates to the admin shop page.
  ///  - For "UserModel", deletes the user from the remote database and navigates to the admin all users page, except when the user is a buyer.
  ///  - For "DeliveryInfoModel", does nothing (TODO: handle case when user wants to delete order).
  Future<void> _handleDelete() async {
    // Switch statement based on the data type
    switch (widget.type) {
      // Case for ShopAddressModel
      case "ShopAddressModel":
        // Cast widget.data to ShopAddressModel
        ShopAddressModel shopAddress = widget.data as ShopAddressModel;
        // Delete shop address from remote database
        service<RemoteShopAddressesBloc>()
            .add(DeleteShopAddress(shopAddress.shopAddressId));
        // Wait for 1 second
        await Future.delayed(const Duration(seconds: 1));
        // Pop the current route and navigate to admin shop page
        router.pop();
        router.push(Pages.adminShops.screenPath);
        break;

      // Case for UserModel
      case "UserModel":
        UserModel user = widget.data as UserModel;
        // Check if the user is not a buyer
        if (user.role!.roleName != "user") {
          // Delete user from remote database
          service<RemoteUserBloc>().add(DeleteUser(id: user.id!));
          // Wait for 1 second
          await Future.delayed(const Duration(seconds: 1));
          // Pop the current route and navigate to admin all users page
          router.pop();
          router.push(Pages.adminAllUsers.screenPath);
        } else {
          // User is a buyer, do nothing (TODO: handle case when user wants to delete buyer)
          router.pop();
        }
        break;

      // Case for DeliveryInfoModel
      case "DeliveryInfoModel":
        // Do nothing (TODO: handle case when user wants to delete order)
        router.pop();
        break;

      // Case for ShopGarnishModel
      case "ShopGarnishModel":
        // Cast widget.data to ShopGarnishModel
        ShopGarnishModel shopGarnish = widget.data as ShopGarnishModel;
        // Delete shop garnish from remote database
        service<RemoteShopGarnishBloc>()
            .add(DeleteShopGarnish(id: shopGarnish.shopGarnishId!));
        // Wait for 1 second
        await Future.delayed(const Duration(seconds: 1));
        // Pop the current route and navigate to director clothes details page
        router.pop();
        router.push(Pages.directorAllClothes.screenPath, extra: {"clothes"});
        break;

      // Default case, do nothing
      default:
        break;
    }
  }
}
