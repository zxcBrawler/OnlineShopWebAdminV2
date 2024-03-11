import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:xc_web_admin/core/constants/shared_prefs.dart';
import 'package:xc_web_admin/core/resources/controller/side_menu_controller.dart';
import 'package:xc_web_admin/feature/shared/data/data_source/api_service.dart';
import 'package:xc_web_admin/feature/shared/data/repository/address_repo_impl.dart';
import 'package:xc_web_admin/feature/shared/data/repository/auth_repo_impl.dart';
import 'package:xc_web_admin/feature/shared/data/repository/clothes_repo_impl.dart';
import 'package:xc_web_admin/feature/shared/data/repository/color_repo_impl.dart';
import 'package:xc_web_admin/feature/shared/data/repository/delivery_info_repo_impl.dart';
import 'package:xc_web_admin/feature/shared/data/repository/gender_repo_impl.dart';
import 'package:xc_web_admin/feature/shared/data/repository/role_repo_impl.dart';
import 'package:xc_web_admin/feature/shared/data/repository/shop_address_repo_impl.dart';
import 'package:xc_web_admin/feature/shared/data/repository/size_repo_impl.dart';
import 'package:xc_web_admin/feature/shared/data/repository/status_repo_impl.dart';
import 'package:xc_web_admin/feature/shared/data/repository/user_repo_impl.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/address_repo.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/auth_repo.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/clothes_repo.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/color_repo.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/delivery_info_repo.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/gender_repository.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/role_repository.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/shop_address_repo.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/size_repo.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/status_repo.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/user_repository.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/address/get_addresses_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/auth/authenticate.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/clothes/add_clothes_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/clothes/get_clothes_colors_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/clothes/get_clothes_photos_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/clothes/get_clothes_sizes_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/clothes/get_clothes_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/clothes/get_type_clothes_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/color/get_colors_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/gender/get_genders_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/order/get_orders_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/role/get_roles_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/shopAddress/delete_shop_address_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/shopAddress/get_shop_addresses_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/size/get_sizes_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/status/get_statuses_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/status/update_status_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/user/add_user_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/user/delete_user_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/user/get_users_usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/usecase/user/update_user_usecase.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/address/address_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/auth/auth_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/clothes/clothes_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/color/color_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/delivery_info/delivery_info_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/gender/gender_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/role/role_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/shopAddress/shop_address_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/size/size_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/status/status_bloc.dart';
import 'package:xc_web_admin/feature/shared/presentation/bloc/user/user_bloc.dart';

final service = GetIt.instance;
Future<void> init() async {
  //Controller
  service.registerLazySingleton(() => SideMenuController());

  //Bloc
  service.registerFactory<RemoteAddressesBloc>(
      () => RemoteAddressesBloc(service()));
  service.registerFactory<RemoteShopAddressesBloc>(
      () => RemoteShopAddressesBloc(service(), service()));
  service.registerFactory<RemoteUserBloc>(
      () => RemoteUserBloc(service(), service(), service(), service()));
  service.registerFactory<RemoteDeliveryInfoBloc>(
      () => RemoteDeliveryInfoBloc(service()));
  service.registerFactory<RemoteRoleBloc>(() => RemoteRoleBloc(service()));
  service
      .registerFactory<RemoteGendersBloc>(() => RemoteGendersBloc(service()));
  service.registerFactory<RemoteClothesBloc>(() => RemoteClothesBloc(
      service(), service(), service(), service(), service(), service()));

  service.registerFactory<RemoteStatusBloc>(
      () => RemoteStatusBloc(service(), service()));
  service.registerFactory<AuthBloc>(() => AuthBloc(service()));

  service.registerFactory<RemoteColorBloc>(() => RemoteColorBloc(service()));
  service.registerFactory<RemoteSizeBloc>(() => RemoteSizeBloc(service()));

  //Dio
  service.registerSingletonAsync<SharedPreferencesManager>(
    () async => SharedPreferencesManager(),
  );
  service.registerSingleton<Dio>(Dio());

  //Repo -> repository repositoryimpl datasource (local, remote)
  service.registerSingleton<ApiService>(ApiService(service()));
  service.registerSingleton<AddressRepo>(AddressRepoImpl(service()));
  service.registerSingleton<ShopAddressRepo>(ShopAddressRepoImpl(service()));
  service.registerSingleton<UserRepo>(UserRepoImpl(service()));
  service.registerSingleton<DeliveryInfoRepo>(DeliveryInfoRepoImpl(service()));
  service.registerSingleton<RoleRepo>(RoleRepoImpl(service()));
  service.registerSingleton<GenderRepo>(GenderRepoImpl(service()));
  service.registerSingleton<ClothesRepo>(ClothesRepoImpl(service()));
  service.registerSingleton<StatusRepo>(StatusRepoImpl(service()));
  service.registerSingleton<AuthRepo>(AuthRepoImpl(service()));
  service.registerSingleton<ColorRepo>(ColorRepoImpl(service()));
  service.registerSingleton<SizeRepo>(SizeRepoImpl(service()));

  //Use case
  service
      .registerSingleton<GetAddressesUsecase>(GetAddressesUsecase(service()));
  service.registerSingleton<GetShopAddressesUsecase>(
      GetShopAddressesUsecase(service()));
  service.registerSingleton<DeleteShopAddressUsecase>(
      DeleteShopAddressUsecase(service()));

  service.registerSingleton<GetUsersUsecase>(GetUsersUsecase(service()));
  service.registerSingleton<GetDeliveryInfoUsecase>(
      GetDeliveryInfoUsecase(service()));
  service.registerSingleton<AddUserUsecase>(AddUserUsecase(service()));

  service.registerSingleton<GetRolesUsecase>(GetRolesUsecase(service()));
  service.registerSingleton<GetGendersUsecase>(GetGendersUsecase(service()));

  service.registerSingleton<UpdateUserUsecase>(UpdateUserUsecase(service()));

  service.registerSingleton<DeleteUserUsecase>(DeleteUserUsecase(service()));

  service.registerSingleton<GetClothesUsecase>(GetClothesUsecase(service()));
  service.registerSingleton<GetClothesSizesUsecase>(
      GetClothesSizesUsecase(service()));
  service.registerSingleton<GetClothesColorsUsecase>(
      GetClothesColorsUsecase(service()));
  service.registerSingleton<GetClothesPhotosUsecase>(
      GetClothesPhotosUsecase(service()));

  service.registerSingleton<GetStatusesUsecase>(GetStatusesUsecase(service()));
  service
      .registerSingleton<UpdateStatusUsecase>(UpdateStatusUsecase(service()));

  service.registerSingleton<Authenticate>(Authenticate(service()));

  service.registerSingleton<AddClothesUsecase>(AddClothesUsecase(service()));

  service.registerSingleton<GetTypeClothesUsecase>(
      GetTypeClothesUsecase(service()));

  service.registerSingleton<GetColorsUsecase>(GetColorsUsecase(service()));
  service.registerSingleton<GetSizesUsecase>(GetSizesUsecase(service()));
}
