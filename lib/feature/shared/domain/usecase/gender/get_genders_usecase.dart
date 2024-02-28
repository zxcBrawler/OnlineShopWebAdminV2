import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/category_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/gender_repository.dart';

class GetGendersUsecase
    implements UseCase<DataState<List<CategoryClothesEntity>>, void> {
  final GenderRepo _mainRepo;

  GetGendersUsecase(this._mainRepo);

  @override
  Future<DataState<List<CategoryClothesEntity>>> call({void params}) async {
    return await _mainRepo.getGenders();
  }
}
