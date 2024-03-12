import 'package:xc_web_admin/feature/shared/data/dto/add_size_dto.dart';

abstract class RemoteSizeEvent {
  final dynamic param;
  const RemoteSizeEvent({this.param});
}

class GetSizes extends RemoteSizeEvent {
  const GetSizes();
}

class AddSize extends RemoteSizeEvent {
  final SizeDTO size;
  const AddSize({required this.size});
}
