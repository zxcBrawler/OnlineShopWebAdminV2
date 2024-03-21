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
  adminOrderDetails, // separate window
  adminClothesDetails, // separate window
  adminAllColors,
  adminAllSizes,
  directorDashboard,
  directorShop,
  directorEmployees,
  directorClothes,
  directorAllClothes,
  directorClothesDetails, // separate window
  directorOrders,
  directorAllOrders,
  directorOrderDetails,
  employeeDashboard,
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
      Pages.adminClothesDetails => '/adminClothesDetails',
      Pages.directorDashboard => '/directorDashboard',
      Pages.employeeDashboard => '/employeeDashboard',
      Pages.directorShop => '/directorShop',
      Pages.directorEmployees => '/directorEmployees',
      Pages.directorClothes => '/directorClothes',
      Pages.directorAllClothes => '/directorAllClothes',
      Pages.directorClothesDetails => '/directorClothesDetails',
      Pages.directorOrders => '/directorOrders',
      Pages.directorAllOrders => '/directorAllOrders',
      Pages.directorOrderDetails => '/directorOrderDetails',
      Pages.adminAllColors => '/adminAllColors',
      Pages.adminAllSizes => '/adminAllSizes',
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
      Pages.adminClothesDetails => 'adminClothesDetails',
      Pages.directorDashboard => 'directorDashboard',
      Pages.directorShop => 'directorShop',
      Pages.directorEmployees => 'directorEmployees',
      Pages.directorClothes => 'directorClothes',
      Pages.directorAllClothes => 'directorAllClothes',
      Pages.directorClothesDetails => 'directorClothesDetails',
      Pages.directorOrders => 'directorOrders',
      Pages.directorAllOrders => 'directorAllOrders',
      Pages.directorOrderDetails => 'directorOrderDetails',
      Pages.employeeDashboard => 'employeeDashboard',
      Pages.adminAllColors => 'adminAllColors',
      Pages.adminAllSizes => 'adminAllSizes',
    };
  }
}
