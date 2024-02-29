import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/clothes_colors_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/clothes_repo.dart';

class GetClothesColorsUsecase
    implements UseCase<DataState<List<ClothesColorsEntity>>, int> {
  final ClothesRepo _mainRepo;

  GetClothesColorsUsecase(this._mainRepo);

  @override
  Future<DataState<List<ClothesColorsEntity>>> call({int? params}) async {
    return await _mainRepo.getClothesColors(id: params);
  }
}
