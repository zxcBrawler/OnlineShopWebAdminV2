import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/dto/add_size_dto.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/size_clothes_entity.dart';

abstract class SizeRepo {
  Future<DataState<List<SizeClothesEntity>>> getSizes();
  Future<DataState<SizeClothesEntity>> addSize({SizeDTO? size});
}
