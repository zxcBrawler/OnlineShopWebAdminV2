import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/data/dto/add_clothes_dto.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/clothes_repo.dart';

class AddClothesUsecase
    implements UseCase<DataState<ClothesEntity>, ClothesDTO> {
  final ClothesRepo _clothesRepo;

  AddClothesUsecase(this._clothesRepo);

  @override
  Future<DataState<ClothesEntity>> call({ClothesDTO? params}) async {
    return await _clothesRepo.addClothes(clothesDTO: params);
  }
}
