import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/domain/entities/color_entity.dart';

abstract class ColorRepo {
  Future<DataState<List<ColorEntity>>> getColors();
}
