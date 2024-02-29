import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_size_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/clothes_repo.dart';

class GetClothesSizesUsecase
    implements UseCase<DataState<List<ClothesSizeClothesEntity>>, int> {
  final ClothesRepo _mainRepo;

  GetClothesSizesUsecase(this._mainRepo);

  @override
  Future<DataState<List<ClothesSizeClothesEntity>>> call({int? params}) async {
    return await _mainRepo.getClothesSizeClothes(id: params);
  }
}
