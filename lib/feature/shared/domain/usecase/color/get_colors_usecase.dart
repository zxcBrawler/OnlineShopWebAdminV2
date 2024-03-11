import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/color_entity.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/color_repo.dart';

class GetColorsUsecase implements UseCase<DataState<List<ColorEntity>>, void> {
  final ColorRepo _colorRepo;

  GetColorsUsecase(this._colorRepo);

  @override
  Future<DataState<List<ColorEntity>>> call({void params}) async {
    return await _colorRepo.getColors();
  }
}
