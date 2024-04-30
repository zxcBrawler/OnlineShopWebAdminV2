// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `username`
  String get username {
    return Intl.message(
      'username',
      name: 'username',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password {
    return Intl.message(
      'password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `phone number`
  String get phoneNumber {
    return Intl.message(
      'phone number',
      name: 'phoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `email`
  String get email {
    return Intl.message(
      'email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `employee number`
  String get employeeNumber {
    return Intl.message(
      'employee number',
      name: 'employeeNumber',
      desc: '',
      args: [],
    );
  }

  /// `user addresses`
  String get userAddresses {
    return Intl.message(
      'user addresses',
      name: 'userAddresses',
      desc: '',
      args: [],
    );
  }

  /// `user orders`
  String get userOrders {
    return Intl.message(
      'user orders',
      name: 'userOrders',
      desc: '',
      args: [],
    );
  }

  /// `auth`
  String get auth {
    return Intl.message(
      'auth',
      name: 'auth',
      desc: '',
      args: [],
    );
  }

  /// `dashboard`
  String get dashboard {
    return Intl.message(
      'dashboard',
      name: 'dashboard',
      desc: '',
      args: [],
    );
  }

  /// `clothes info`
  String get clothesInfo {
    return Intl.message(
      'clothes info',
      name: 'clothesInfo',
      desc: '',
      args: [],
    );
  }

  /// `all users`
  String get allUsers {
    return Intl.message(
      'all users',
      name: 'allUsers',
      desc: '',
      args: [],
    );
  }

  /// `all orders`
  String get allOrders {
    return Intl.message(
      'all orders',
      name: 'allOrders',
      desc: '',
      args: [],
    );
  }

  /// `orders`
  String get orders {
    return Intl.message(
      'orders',
      name: 'orders',
      desc: '',
      args: [],
    );
  }

  /// `all sizes`
  String get allSizes {
    return Intl.message(
      'all sizes',
      name: 'allSizes',
      desc: '',
      args: [],
    );
  }

  /// `all colors`
  String get allColors {
    return Intl.message(
      'all colors',
      name: 'allColors',
      desc: '',
      args: [],
    );
  }

  /// `clothes`
  String get allClothes {
    return Intl.message(
      'clothes',
      name: 'allClothes',
      desc: '',
      args: [],
    );
  }

  /// `female clothes`
  String get allFemaleClothes {
    return Intl.message(
      'female clothes',
      name: 'allFemaleClothes',
      desc: '',
      args: [],
    );
  }

  /// `male clothes`
  String get allMaleClothes {
    return Intl.message(
      'male clothes',
      name: 'allMaleClothes',
      desc: '',
      args: [],
    );
  }

  /// `total male clothes`
  String get totalMaleClothes {
    return Intl.message(
      'total male clothes',
      name: 'totalMaleClothes',
      desc: '',
      args: [],
    );
  }

  /// `total female clothes`
  String get totalFemaleClothes {
    return Intl.message(
      'total female clothes',
      name: 'totalFemaleClothes',
      desc: '',
      args: [],
    );
  }

  /// `shop address details`
  String get shopAddressDetails {
    return Intl.message(
      'shop address details',
      name: 'shopAddressDetails',
      desc: '',
      args: [],
    );
  }

  /// `shop address`
  String get shopAddress {
    return Intl.message(
      'shop address',
      name: 'shopAddress',
      desc: '',
      args: [],
    );
  }

  /// `shop metro`
  String get shopMetro {
    return Intl.message(
      'shop metro',
      name: 'shopMetro',
      desc: '',
      args: [],
    );
  }

  /// `contact number`
  String get contactNumber {
    return Intl.message(
      'contact number',
      name: 'contactNumber',
      desc: '',
      args: [],
    );
  }

  /// `latitude`
  String get latitude {
    return Intl.message(
      'latitude',
      name: 'latitude',
      desc: '',
      args: [],
    );
  }

  /// `longitude`
  String get longitude {
    return Intl.message(
      'longitude',
      name: 'longitude',
      desc: '',
      args: [],
    );
  }

  /// `update shop`
  String get updateShop {
    return Intl.message(
      'update shop',
      name: 'updateShop',
      desc: '',
      args: [],
    );
  }

  /// `shops`
  String get shops {
    return Intl.message(
      'shops',
      name: 'shops',
      desc: '',
      args: [],
    );
  }

  /// `edit`
  String get edit {
    return Intl.message(
      'edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `delete`
  String get delete {
    return Intl.message(
      'delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `gender`
  String get gender {
    return Intl.message(
      'gender',
      name: 'gender',
      desc: '',
      args: [],
    );
  }

  /// `role`
  String get role {
    return Intl.message(
      'role',
      name: 'role',
      desc: '',
      args: [],
    );
  }

  /// `user details`
  String get userDetails {
    return Intl.message(
      'user details',
      name: 'userDetails',
      desc: '',
      args: [],
    );
  }

  /// `users`
  String get users {
    return Intl.message(
      'users',
      name: 'users',
      desc: '',
      args: [],
    );
  }

  /// `items sold overview`
  String get itemsSoldOverview {
    return Intl.message(
      'items sold overview',
      name: 'itemsSoldOverview',
      desc: '',
      args: [],
    );
  }

  /// `error`
  String get error {
    return Intl.message(
      'error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `orders overview`
  String get ordersOverview {
    return Intl.message(
      'orders overview',
      name: 'ordersOverview',
      desc: '',
      args: [],
    );
  }

  /// `weekly orders made overview`
  String get weeklyOrdersMadeOverview {
    return Intl.message(
      'weekly orders made overview',
      name: 'weeklyOrdersMadeOverview',
      desc: '',
      args: [],
    );
  }

  /// `pick up`
  String get pickUp {
    return Intl.message(
      'pick up',
      name: 'pickUp',
      desc: '',
      args: [],
    );
  }

  /// `delivery`
  String get delivery {
    return Intl.message(
      'delivery',
      name: 'delivery',
      desc: '',
      args: [],
    );
  }

  /// `no orders`
  String get noOrders {
    return Intl.message(
      'no orders',
      name: 'noOrders',
      desc: '',
      args: [],
    );
  }

  /// `no addresses`
  String get noAddresses {
    return Intl.message(
      'no addresses',
      name: 'noAddresses',
      desc: '',
      args: [],
    );
  }

  /// `address name`
  String get addressName {
    return Intl.message(
      'address name',
      name: 'addressName',
      desc: '',
      args: [],
    );
  }

  /// `address direction`
  String get addressDirection {
    return Intl.message(
      'address direction',
      name: 'addressDirection',
      desc: '',
      args: [],
    );
  }

  /// `address city`
  String get addressCity {
    return Intl.message(
      'address city',
      name: 'addressCity',
      desc: '',
      args: [],
    );
  }

  /// `total users`
  String get totalUsers {
    return Intl.message(
      'total users',
      name: 'totalUsers',
      desc: '',
      args: [],
    );
  }

  /// `total sizes`
  String get totalSizes {
    return Intl.message(
      'total sizes',
      name: 'totalSizes',
      desc: '',
      args: [],
    );
  }

  /// `total colors`
  String get totalColors {
    return Intl.message(
      'total colors',
      name: 'totalColors',
      desc: '',
      args: [],
    );
  }

  /// `total orders`
  String get totalOrders {
    return Intl.message(
      'total orders',
      name: 'totalOrders',
      desc: '',
      args: [],
    );
  }

  /// `total clothes`
  String get totalClothes {
    return Intl.message(
      'total clothes',
      name: 'totalClothes',
      desc: '',
      args: [],
    );
  }

  /// `generate pdf`
  String get generatePdf {
    return Intl.message(
      'generate pdf',
      name: 'generatePdf',
      desc: '',
      args: [],
    );
  }

  /// `orders by status`
  String get ordersByStatus {
    return Intl.message(
      'orders by status',
      name: 'ordersByStatus',
      desc: '',
      args: [],
    );
  }

  /// `weekly items sold overview`
  String get weeklyItemsSoldOverview {
    return Intl.message(
      'weekly items sold overview',
      name: 'weeklyItemsSoldOverview',
      desc: '',
      args: [],
    );
  }

  /// `size name`
  String get sizeName {
    return Intl.message(
      'size name',
      name: 'sizeName',
      desc: '',
      args: [],
    );
  }

  /// `add new size`
  String get addNewSize {
    return Intl.message(
      'add new size',
      name: 'addNewSize',
      desc: '',
      args: [],
    );
  }

  /// `add new shop`
  String get addNewShop {
    return Intl.message(
      'add new shop',
      name: 'addNewShop',
      desc: '',
      args: [],
    );
  }

  /// `add new color`
  String get addNewColor {
    return Intl.message(
      'add new color',
      name: 'addNewColor',
      desc: '',
      args: [],
    );
  }

  /// `add new clothes`
  String get addNewClothes {
    return Intl.message(
      'add new clothes',
      name: 'addNewClothes',
      desc: '',
      args: [],
    );
  }

  /// `color name`
  String get colorName {
    return Intl.message(
      'color name',
      name: 'colorName',
      desc: '',
      args: [],
    );
  }

  /// `choose color`
  String get chooseColor {
    return Intl.message(
      'choose color',
      name: 'chooseColor',
      desc: '',
      args: [],
    );
  }

  /// `barcode`
  String get barcode {
    return Intl.message(
      'barcode',
      name: 'barcode',
      desc: '',
      args: [],
    );
  }

  /// `name clothes ru`
  String get nameClothesRu {
    return Intl.message(
      'name clothes ru',
      name: 'nameClothesRu',
      desc: '',
      args: [],
    );
  }

  /// `name clothes en`
  String get nameClothesEn {
    return Intl.message(
      'name clothes en',
      name: 'nameClothesEn',
      desc: '',
      args: [],
    );
  }

  /// `price clothes`
  String get priceClothes {
    return Intl.message(
      'price clothes',
      name: 'priceClothes',
      desc: '',
      args: [],
    );
  }

  /// `enter clothes details`
  String get enterClothesDetails {
    return Intl.message(
      'enter clothes details',
      name: 'enterClothesDetails',
      desc: '',
      args: [],
    );
  }

  /// `choose sizes`
  String get chooseSizes {
    return Intl.message(
      'choose sizes',
      name: 'chooseSizes',
      desc: '',
      args: [],
    );
  }

  /// `choose colors`
  String get chooseColors {
    return Intl.message(
      'choose colors',
      name: 'chooseColors',
      desc: '',
      args: [],
    );
  }

  /// `add photo URL`
  String get addPhotoURL {
    return Intl.message(
      'add photo URL',
      name: 'addPhotoURL',
      desc: '',
      args: [],
    );
  }

  /// `choose gender`
  String get chooseGender {
    return Intl.message(
      'choose gender',
      name: 'chooseGender',
      desc: '',
      args: [],
    );
  }

  /// `choose type clothes`
  String get chooseTypeClothes {
    return Intl.message(
      'choose type clothes',
      name: 'chooseTypeClothes',
      desc: '',
      args: [],
    );
  }

  /// `photo URL`
  String get photoURL {
    return Intl.message(
      'photo URL',
      name: 'photoURL',
      desc: '',
      args: [],
    );
  }

  /// `add new user`
  String get addNewUser {
    return Intl.message(
      'add new user',
      name: 'addNewUser',
      desc: '',
      args: [],
    );
  }

  /// `choose role`
  String get chooseRole {
    return Intl.message(
      'choose role',
      name: 'chooseRole',
      desc: '',
      args: [],
    );
  }

  /// `enter user details`
  String get enterUserDetails {
    return Intl.message(
      'enter user details',
      name: 'enterUserDetails',
      desc: '',
      args: [],
    );
  }

  /// `choose shop address`
  String get chooseShopAddress {
    return Intl.message(
      'choose shop address',
      name: 'chooseShopAddress',
      desc: '',
      args: [],
    );
  }

  /// `clothes details`
  String get clothesDetails {
    return Intl.message(
      'clothes details',
      name: 'clothesDetails',
      desc: '',
      args: [],
    );
  }

  /// `available in sizes`
  String get availableInSizes {
    return Intl.message(
      'available in sizes',
      name: 'availableInSizes',
      desc: '',
      args: [],
    );
  }

  /// `available in colors`
  String get availableInColors {
    return Intl.message(
      'available in colors',
      name: 'availableInColors',
      desc: '',
      args: [],
    );
  }

  /// `my shop`
  String get myShop {
    return Intl.message(
      'my shop',
      name: 'myShop',
      desc: '',
      args: [],
    );
  }

  /// `employees`
  String get employees {
    return Intl.message(
      'employees',
      name: 'employees',
      desc: '',
      args: [],
    );
  }

  /// `shop orders`
  String get shopOrders {
    return Intl.message(
      'shop orders',
      name: 'shopOrders',
      desc: '',
      args: [],
    );
  }

  /// `current week`
  String get currentWeek {
    return Intl.message(
      'current week',
      name: 'currentWeek',
      desc: '',
      args: [],
    );
  }

  /// `date order`
  String get dateOrder {
    return Intl.message(
      'date order',
      name: 'dateOrder',
      desc: '',
      args: [],
    );
  }

  /// `time order`
  String get timeOrder {
    return Intl.message(
      'time order',
      name: 'timeOrder',
      desc: '',
      args: [],
    );
  }

  /// `sum order`
  String get sumOrder {
    return Intl.message(
      'sum order',
      name: 'sumOrder',
      desc: '',
      args: [],
    );
  }

  /// `order number`
  String get orderNumber {
    return Intl.message(
      'order number',
      name: 'orderNumber',
      desc: '',
      args: [],
    );
  }

  /// `user address`
  String get userAddress {
    return Intl.message(
      'user address',
      name: 'userAddress',
      desc: '',
      args: [],
    );
  }

  /// `order details`
  String get orderDetails {
    return Intl.message(
      'order details',
      name: 'orderDetails',
      desc: '',
      args: [],
    );
  }

  /// `order composition`
  String get orderComposition {
    return Intl.message(
      'order composition',
      name: 'orderComposition',
      desc: '',
      args: [],
    );
  }

  /// `edit status`
  String get editStatus {
    return Intl.message(
      'edit status',
      name: 'editStatus',
      desc: '',
      args: [],
    );
  }

  /// `status order`
  String get statusOrder {
    return Intl.message(
      'status order',
      name: 'statusOrder',
      desc: '',
      args: [],
    );
  }

  /// `size`
  String get size {
    return Intl.message(
      'size',
      name: 'size',
      desc: '',
      args: [],
    );
  }

  /// `color`
  String get color {
    return Intl.message(
      'color',
      name: 'color',
      desc: '',
      args: [],
    );
  }

  /// `quantity`
  String get quantity {
    return Intl.message(
      'quantity',
      name: 'quantity',
      desc: '',
      args: [],
    );
  }

  /// `enter quantity`
  String get enterQuantity {
    return Intl.message(
      'enter quantity',
      name: 'enterQuantity',
      desc: '',
      args: [],
    );
  }

  /// `choose clothes`
  String get chooseClothes {
    return Intl.message(
      'choose clothes',
      name: 'chooseClothes',
      desc: '',
      args: [],
    );
  }

  /// `choose size`
  String get chooseSize {
    return Intl.message(
      'choose size',
      name: 'chooseSize',
      desc: '',
      args: [],
    );
  }

  /// `add new clothes to shop`
  String get addNewClothesToShop {
    return Intl.message(
      'add new clothes to shop',
      name: 'addNewClothesToShop',
      desc: '',
      args: [],
    );
  }

  /// `item already exists`
  String get itemAlreadyExists {
    return Intl.message(
      'item already exists',
      name: 'itemAlreadyExists',
      desc: '',
      args: [],
    );
  }

  /// `item added`
  String get itemAdded {
    return Intl.message(
      'item added',
      name: 'itemAdded',
      desc: '',
      args: [],
    );
  }

  /// `search...`
  String get search {
    return Intl.message(
      'search...',
      name: 'search',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
