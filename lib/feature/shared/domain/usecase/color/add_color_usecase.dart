import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/core/usecase/usecase.dart';
import 'package:xc_web_admin/feature/shared/data/dto/add_color_dto.dart';
import 'package:xc_web_admin/feature/shared/data/model/color.dart';
import 'package:xc_web_admin/feature/shared/domain/repository/color_repo.dart';

class AddColorUsecase implements UseCase<DataState<ColorModel>, ColorDTO> {
  final ColorRepo _colorRepo;

  AddColorUsecase(this._colorRepo);

  @override
  Future<DataState<ColorModel>> call({ColorDTO? params}) async {
    return await _colorRepo.addColor(color: params);
  }
}
