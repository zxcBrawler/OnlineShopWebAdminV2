import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/dto/add_color_dto.dart';
import 'package:xc_web_admin/feature/shared/data/model/color.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/color_entity.dart';

abstract class ColorRepo {
  Future<DataState<List<ColorEntity>>> getColors();
  Future<DataState<ColorModel>> addColor({ColorDTO? color});
}
