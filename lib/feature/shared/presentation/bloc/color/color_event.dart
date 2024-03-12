import 'package:xc_web_admin/feature/shared/data/dto/add_color_dto.dart';

abstract class RemoteColorEvent {
  final dynamic param;
  const RemoteColorEvent({this.param});
}

class GetColors extends RemoteColorEvent {
  const GetColors();
}

class AddColor extends RemoteColorEvent {
  final ColorDTO color;
  const AddColor({required this.color});
}
