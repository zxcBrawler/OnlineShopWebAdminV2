import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:xc_web_admin/config/color.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
import 'package:xc_web_admin/core/routes/app_router.dart';
import 'package:xc_web_admin/core/routes/router_utils.dart';
import 'package:xc_web_admin/core/widget/dropdown/basic_dropdown.dart';
import 'package:xc_web_admin/core/widget/text/base_button_text.dart';
import 'package:xc_web_admin/core/widget/text/basic_text.dart';
import 'package:xc_web_admin/core/widget/textfield/basic_textfield.dart';
import 'package:xc_web_admin/di/service.dart';
import 'package:xc_web_admin/feature/shared/data/dto/shop_garnish_dto.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_state.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_event.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shop_garnish/shop_garnish_state.dart';

class DirectorAddClothesDialog extends StatefulWidget {
  const DirectorAddClothesDialog({super.key});

  @override
  State<DirectorAddClothesDialog> createState() =>
      _DirectorAddClothesDialogState();
}

class _DirectorAddClothesDialogState extends State<DirectorAddClothesDialog> {
  late final RemoteClothesBloc colorBloc;
  late final RemoteClothesBloc sizeBloc;
  bool ifExists = false;
  int? selectedClothesIndex;
  int? selectedColorIndex = 0;
  int? selectedSizeIndex = 0;
  int? colorForAdding = 0;
  int? sizeForAdding = 0;
  int? selectedClothesForAdding = 0;
  MaskedTextController quantity = MaskedTextController(mask: '0000');
  final ShopGarnishDTO newShopGarnish = ShopGarnishDTO();

  @override
  void initState() {
    super.initState();
    colorBloc = service<RemoteClothesBloc>()
      ..add(const GetClothesColors(id: 1));
    sizeBloc = service<RemoteClothesBloc>()..add(const GetClothesSizes(id: 1));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SingleChildScrollView(
        child: Column(
          children: [
            const BasicText(title: "add clothes"),
            _buildClothesDropdown(),
            BasicTextField(
              title: "enter quantity",
              controller: quantity,
              isEnabled: true,
            ),
            _buildAddClothesButton()
          ],
        ),
      ),
    );
  }

  Widget _buildClothesDropdown() {
    return BlocProvider<RemoteClothesBloc>(
      create: (context) => service()..add(const GetClothes()),
      child: BlocBuilder<RemoteClothesBloc, RemoteClothesState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case RemoteClothesLoading:
              return const CircularProgressIndicator();
            case RemoteClothesDone:
              return Column(
                children: [
                  BasicDropdown(
                    listTitle: "choose clothes",
                    dropdownData: state.clothes!
                        .map((e) => "${e.barcode} - ${e.nameClothesEn}")
                        .toList(),
                    selectedIndex: selectedClothesIndex ?? 0,
                    onIndexChanged: (value) {
                      setState(() {
                        selectedClothesIndex = value;
                        selectedClothesForAdding =
                            state.clothes![value].idClothes!;

                        sizeBloc.add(GetClothesSizes(
                            id: state.clothes![value].idClothes!));
                        colorBloc.add(GetClothesColors(
                            id: state.clothes![value].idClothes!));
                      });
                    },
                    isColorDropdown: false,
                  ),
                  BlocProvider<RemoteClothesBloc>(
                    create: (context) => sizeBloc,
                    child: BlocBuilder<RemoteClothesBloc, RemoteClothesState>(
                      builder: (context, state) {
                        switch (state.runtimeType) {
                          case RemoteClothesLoading:
                            return const SizedBox();
                          case RemoteClothesSizeClothesDone:
                            return BasicDropdown(
                              listTitle: "choose size",
                              dropdownData: state.clothesSizeClothes!
                                  .map((e) => e.sizeClothes!.nameSize ?? "")
                                  .toList(),
                              selectedIndex: selectedSizeIndex!,
                              onIndexChanged: (value) {
                                setState(() {
                                  selectedSizeIndex = value;
                                  sizeForAdding = state
                                      .clothesSizeClothes![selectedSizeIndex!]
                                      .id;
                                });
                              },
                              isColorDropdown: false,
                            );
                          default:
                            return const SizedBox();
                        }
                      },
                    ),
                  ),
                  BlocProvider<RemoteClothesBloc>(
                    create: (context) => colorBloc,
                    child: BlocBuilder<RemoteClothesBloc, RemoteClothesState>(
                      builder: (context, state) {
                        switch (state.runtimeType) {
                          case RemoteClothesLoading:
                            return const SizedBox();
                          case RemoteClothesColorsDone:
                            return BasicDropdown(
                              listTitle: "choose color",
                              dropdownData: state.clothesColors!
                                  .map((e) => e.colors!.nameColor ?? "")
                                  .toList(),
                              colorDropdownData: state.clothesColors!
                                  .map((e) => e.colors!.hex ?? "")
                                  .toList(),
                              selectedIndex: selectedColorIndex!,
                              onIndexChanged: (value) {
                                setState(() {
                                  selectedColorIndex = value;
                                  colorForAdding =
                                      state.clothesColors![value].id;
                                });
                              },
                              isColorDropdown: true,
                            );
                          default:
                            return const SizedBox();
                        }
                      },
                    ),
                  )
                ],
              );
            default:
              return const SizedBox();
          }
        },
      ),
    );
  }

  void _addToShop() async {
    newShopGarnish.colorClothesId = colorForAdding!;
    newShopGarnish.sizeClothesId = sizeForAdding!;
    newShopGarnish.shopId = int.parse(SessionStorage.getValue("shopAddressId"));
    newShopGarnish.quantity = int.parse(quantity.text);
    service<RemoteShopGarnishBloc>()
        .add(AddShopGarnish(shopGarnishDTO: newShopGarnish));
    await Future.delayed(const Duration(seconds: 1));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Item added to shop'),
        duration: Duration(seconds: 2), // Adjust as needed
      ),
    );
    router.pop();
    router.push(
      Pages.directorClothes.screenPath,
    );
  }

  Future<bool> _checkIfExists() async {
    var shopGarnishBloc = service<RemoteShopGarnishBloc>();
    shopGarnishBloc.add(GetShopGarnish(
        id: int.parse(SessionStorage.getValue("shopAddressId"))));

    return shopGarnishBloc.stream.map((event) {
      if (event is RemoteShopGarnishDone) {
        return event.shopGarnish!.any((element) =>
            element.colorClothesGarnish!.id == colorForAdding &&
            element.sizeClothesGarnish!.id == sizeForAdding &&
            element.sizeClothesGarnish!.clothes!.idClothes ==
                selectedClothesForAdding);
      }
      return false;
    }).first;
  }

  Widget _buildAddClothesButton() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () async {
          ifExists = await _checkIfExists();
          if (ifExists) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Item already exists in the shop.'),
                duration: Duration(seconds: 2), // Adjust as needed
              ),
            );
          } else {
            _addToShop();
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.darkBrown,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const BaseButtonText(title: "add new clothes to shop"),
      ),
    );
  }
}
