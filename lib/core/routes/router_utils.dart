enum Pages {
  auth,
  adminMain, // separate window
  adminDashboard,
  adminUsers,
  adminClothes,
  adminShops,
  adminOrders,
  adminUserInfo, // separate window
  adminWeeklyActivityDetails,
  adminAllUsers,
  adminAllActiveUsers,
  adminUserAddresses,
  adminShopAddressInfo,
  adminAllOrders,
  adminAllClothes,
  adminOrderDetails
}

enum DirectorPages { director }

enum EmployeePages { emp }

extension AppPageExtension on Pages {
  String get screenPath {
    return switch (this) {
      Pages.auth => '/',
      Pages.adminMain => '/adminMain',
      Pages.adminDashboard => '/adminDashboard',
      Pages.adminUsers => '/adminUsers',
      Pages.adminClothes => '/adminClothes',
      Pages.adminShops => '/adminShops',
      Pages.adminOrders => '/adminOrders',
      Pages.adminUserInfo => '/adminUserInfo',
      Pages.adminWeeklyActivityDetails => '/adminWeeklyActivityDetails',
      Pages.adminAllUsers => '/adminAllUsers',
      Pages.adminAllActiveUsers => '/adminAllActiveUsers',
      Pages.adminUserAddresses => '/adminUserAddresses',
      Pages.adminShopAddressInfo => '/adminShopAddressInfo',
      Pages.adminAllOrders => '/adminAllOrders',
      Pages.adminAllClothes => '/adminAllClothes',
      Pages.adminOrderDetails => '/adminOrderDetails',
    };
  }

  String get screenName {
    return switch (this) {
      Pages.auth => 'auth',
      Pages.adminMain => 'adminMain',
      Pages.adminDashboard => 'adminDashboard',
      Pages.adminUsers => 'adminUsers',
      Pages.adminClothes => 'adminClothes',
      Pages.adminShops => 'adminShops',
      Pages.adminOrders => 'adminOrders',
      Pages.adminUserInfo => 'adminUserInfo',
      Pages.adminWeeklyActivityDetails => 'adminWeeklyActivityDetails',
      Pages.adminAllUsers => 'adminAllUsers',
      Pages.adminAllActiveUsers => 'adminAllActiveUsers',
      Pages.adminUserAddresses => 'adminUserAddresses',
      Pages.adminShopAddressInfo => 'adminShopAddressInfo',
      Pages.adminAllOrders => 'adminAllOrders',
      Pages.adminAllClothes => 'adminAllClothes',
      Pages.adminOrderDetails => 'adminOrderDetails',
    };
  }
}
