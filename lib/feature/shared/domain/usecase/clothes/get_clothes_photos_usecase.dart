import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/photos_of_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/clothes_repo.dart';

class GetClothesPhotosUsecase
    implements UseCase<DataState<List<PhotosOfClothesEntity>>, int> {
  final ClothesRepo _mainRepo;

  GetClothesPhotosUsecase(this._mainRepo);

  @override
  Future<DataState<List<PhotosOfClothesEntity>>> call({int? params}) async {
    return await _mainRepo.getPhotosOfClothes(id: params);
  }
}
