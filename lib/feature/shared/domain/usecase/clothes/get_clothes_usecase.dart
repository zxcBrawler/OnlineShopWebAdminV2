import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/clothes_repo.dart';

class GetClothesUsecase
    implements UseCase<DataState<List<ClothesEntity>>, void> {
  final ClothesRepo _mainRepo;

  GetClothesUsecase(this._mainRepo);

  @override
  Future<DataState<List<ClothesEntity>>> call({void params}) async {
    return await _mainRepo.getClothes();
  }
}
