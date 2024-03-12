import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/data/dto/add_size_dto.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/size_clothes_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/size_repo.dart';

class AddSizeUsecase implements UseCase<DataState<SizeClothesEntity>, SizeDTO> {
  final SizeRepo _sizeRepo;

  AddSizeUsecase(this._sizeRepo);

  @override
  Future<DataState<SizeClothesEntity>> call({SizeDTO? params}) async {
    return await _sizeRepo.addSize(size: params);
  }
}
