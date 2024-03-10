import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/type_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/clothes_repo.dart';

class GetTypeClothesUsecase
    implements UseCase<DataState<List<TypeClothesEntity>>, int> {
  final ClothesRepo _clothesRepo;

  GetTypeClothesUsecase(this._clothesRepo);

  @override
  Future<DataState<List<TypeClothesEntity>>> call({int? params}) async {
    return await _clothesRepo.getTypeClothes(id: params);
  }
}
