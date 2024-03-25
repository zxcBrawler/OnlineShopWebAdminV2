import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:retrofit/retrofit.dart';
import 'package:xc_web_admin/core/constants/session_storage.dart';
import 'package:xc_web_admin/feature/shared/data/dto/login_responce.dart';
import 'package:xc_web_admin/feature/shared/data/model/address.dart';
import 'package:xc_web_admin/feature/shared/data/model/category_clothes.dart';
import 'package:xc_web_admin/feature/shared/data/model/clothes.dart';
import 'package:xc_web_admin/feature/shared/data/model/clothes_colors.dart';
import 'package:xc_web_admin/feature/shared/data/model/clothes_size_clothes.dart';
import 'package:xc_web_admin/feature/shared/data/model/color.dart';
import 'package:xc_web_admin/feature/shared/data/model/delivery_info.dart';
import 'package:xc_web_admin/feature/shared/data/model/employee_shop.dart';
import 'package:xc_web_admin/feature/shared/data/model/order_comp.dart';
import 'package:xc_web_admin/feature/shared/data/model/photos_of_clothes.dart';
import 'package:xc_web_admin/feature/shared/data/model/role.dart';
import 'package:xc_web_admin/feature/shared/data/model/shop_address.dart';
import 'package:xc_web_admin/feature/shared/data/model/shop_garnish.dart';
import 'package:xc_web_admin/feature/shared/data/model/size_clothes.dart';
import 'package:xc_web_admin/feature/shared/data/model/status_order.dart';
import 'package:xc_web_admin/feature/shared/data/model/type_clothes.dart';
import 'package:xc_web_admin/feature/shared/data/model/user.dart';
import 'package:xc_web_admin/feature/shared/data/model/user_address.dart';

part 'api_service.g.dart';

@RestApi()
abstract class ApiService {
  factory ApiService(Dio dio) = _ApiService;

  void getToken();

  @GET('address')
  Future<HttpResponse<List<AddressModel>>> getAddresses();

  @GET('userAddress/{id}')
  Future<HttpResponse<List<UserAddressModel>>> getAddressesById({
    @Path("id") required int? id,
  });

  @POST('address')
  Future<HttpResponse<void>> addAddress({
    @Body() required AddressModel addressModel,
  });

  @PUT('address/{id}')
  Future<HttpResponse<void>> updateAddress({
    @Body() required AddressModel addressModel,
    @Path("id") required int id,
  });

  @DELETE('address/{id}')
  Future<HttpResponse<void>> deleteAddressById({
    @Path("id") required int idAddress,
  });

  @GET('shopAddresses')
  Future<HttpResponse<List<ShopAddressModel>>> getShopAddresses();

  @FormUrlEncoded()
  @POST('shopAddresses')
  Future<HttpResponse<ShopAddressModel>> addShopAddress({
    @Field("shopMetro") required String shopMetro,
    @Field("shopAddressDirection") required String shopAddressDirection,
    @Field("contactNumber") required String contactNumber,
    @Field("latitude") required String latitude,
    @Field("longitude") required String longitude,
  });

  @FormUrlEncoded()
  @PUT('shopAddresses/{id}')
  Future<HttpResponse<ShopAddressModel>> updateShopAddress({
    @Field("shopMetro") required String shopMetro,
    @Field("shopAddressDirection") required String shopAddressDirection,
    @Field("contactNumber") required String contactNumber,
    @Field("latitude") required String latitude,
    @Field("longitude") required String longitude,
    @Path("id") required int id,
  });
  @DELETE('shopAddresses/{id}')
  Future<HttpResponse<void>> deleteShopAddressById({
    @Path("id") required int id,
  });

  @GET("users")
  Future<HttpResponse<List<UserModel>>> getUsers();

  @GET("role")
  Future<HttpResponse<List<RoleModel>>> getRoles();

  @GET("categoryClothes")
  Future<HttpResponse<List<CategoryClothesModel>>> getGenders();

  @FormUrlEncoded()
  @POST("users")
  Future<HttpResponse<UserModel>> addUser({
    @Field("gender") required int gender,
    @Field("role") required int role,
    @Field("employeeNumber") required String employeeNumber,
    @Field("passwordHash") required String passwordHash,
    @Field("phoneNumber") required String phoneNumber,
    @Field("username") required String username,
    @Field("email") required String email,
    @Field("shopAddressId") required int shopAddressId,
  });
  @FormUrlEncoded()
  @PUT("users/{id}")
  Future<HttpResponse<UserModel>> updateUserById({
    @Path("id") required int id,
    @Field("gender") required int gender,
    @Field("role") required int role,
    @Field("employeeNumber") required String employeeNumber,
    @Field("phoneNumber") required String phoneNumber,
    @Field("username") required String username,
    @Field("email") required String email,
  });

  @DELETE("users/{id}")
  Future<HttpResponse<void>> deleteUserById({
    @Path("id") int? id,
  });

  @GET("deliveryInfo")
  Future<HttpResponse<List<DeliveryInfoModel>>> getAllInfo();

  @GET("clothes")
  Future<HttpResponse<List<ClothesModel>>> getClothes();

  @FormUrlEncoded()
  @POST("clothes")
  Future<HttpResponse<ClothesModel>> addClothes({
    @Field("selectedTypeClothes") required int selectedTypeClothes,
    @Field("priceClothes") required String priceClothes,
    @Field("barcode") required String barcode,
    @Field("nameClothesEn") required String nameClothesEn,
    @Field("nameClothesRu") required String nameClothesRu,
    @Field("selectedSizes") required List<int> selectedSizes,
    @Field("selectedColors") required List<int> selectedColors,
    @Field("uploadedPhotos") required List<String> uploadedPhotos,
  });

  @GET("photosOfClothes/{clothesId}")
  Future<HttpResponse<List<PhotosOfClothesModel>>> getPhotos({
    @Path("clothesId") int? id,
  });

  @GET("clothesSizeClothes/{clothesId}")
  Future<HttpResponse<List<ClothesSizeClothesModel>>> getSizes({
    @Path("clothesId") int? id,
  });

  @GET("sizeClothes")
  Future<HttpResponse<List<SizeClothesModel>>> getAllSizes();

  @GET("colors")
  Future<HttpResponse<List<ColorModel>>> getAllColors();

  @GET("clothesColors/{clothesId}")
  Future<HttpResponse<List<ClothesColorsModel>>> getColors({
    @Path("clothesId") int? id,
  });

  @FormUrlEncoded()
  @POST("colors")
  Future<HttpResponse<ColorModel>> addColor({
    @Field("nameColor") required String nameColor,
    @Field("hex") required String hex,
  });
  @FormUrlEncoded()
  @POST("sizeClothes")
  Future<HttpResponse<SizeClothesModel>> addSize({
    @Field("nameSize") required String nameSize,
  });

  @FormUrlEncoded()
  @POST("shopGarnish")
  Future<HttpResponse<ShopGarnishModel>> addShopGarnish({
    @Field("sizeClothesId") required int sizeClothesId,
    @Field("colorClothesId") required int colorClothesId,
    @Field("shopId") required int shopId,
    @Field("quantity") required int quantity,
  });

  @DELETE("shopGarnish/{id}")
  Future<HttpResponse<void>> deleteShopGarnishById({
    @Path("id") int? id,
  });

  @GET("typeClothes/{id}")
  Future<HttpResponse<List<TypeClothesModel>>> getTypeClothes({
    @Path("id") int? id,
  });

  @GET("statusOrder")
  Future<HttpResponse<List<StatusOrderModel>>> getStatuses();

  @FormUrlEncoded()
  @PUT("orders/{id}")
  Future<HttpResponse<void>> updateStatus({
    @Path("id") int? id,
    @Field("statusID") required int statusID,
  });

  @FormUrlEncoded()
  @POST("auth/login")
  Future<HttpResponse<LoginResponse>> login({
    @Field("username") required String username,
    @Field("passwordHash") required String passwordHash,
  });

  @GET("employeeShop/employee/{employeeId}")
  Future<HttpResponse<EmployeeShopModel>> getShopAddressByEmployeeId({
    @Path("employeeId") int? employeeId,
  });

  @GET("employeeShop/{shopAddressId}")
  Future<HttpResponse<List<EmployeeShopModel>>> getAllEmployees({
    @Path("shopAddressId") int? shopAddressId,
  });

  @GET("shopGarnish/{shopAddressId}")
  Future<HttpResponse<List<ShopGarnishModel>>> getShopGarnish({
    @Path("shopAddressId") int? shopAddressId,
  });

  @FormUrlEncoded()
  @PUT("shopGarnish/{shopGarnishId}")
  Future<HttpResponse<void>> updateQuantity({
    @Path("shopGarnishId") int? shopGarnishId,
    @Field("quantity") required int quantity,
  });

  @GET("ordersComp")
  Future<HttpResponse<List<OrderCompositionModel>>> getOrdersComp();

  @GET("ordersComp/{id}")
  Future<HttpResponse<List<OrderCompositionModel>>> getOrdersCompByOrderId({
    @Path("id") int? id,
  });
}
