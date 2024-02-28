import 'package:xc_web_admin/core/resources/data/data_state.dart';
import 'package:xc_web_admin/feature/shared/data/model/category_clothes.dart';

abstract class GenderRepo {
  Future<DataState<List<CategoryClothesModel>>> getGenders();
}
