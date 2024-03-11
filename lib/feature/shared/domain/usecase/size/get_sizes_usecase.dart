import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/size_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/size_repo.dart';

class GetSizesUsecase
    implements UseCase<DataState<List<SizeClothesEntity>>, void> {
  final SizeRepo _sizeRepo;

  GetSizesUsecase(this._sizeRepo);

  @override
  Future<DataState<List<SizeClothesEntity>>> call({void params}) async {
    return await _sizeRepo.getSizes();
  }
}
