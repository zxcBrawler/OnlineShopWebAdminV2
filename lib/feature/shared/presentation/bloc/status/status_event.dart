import 'package:xc_web_admin/feature/shared/data/dto/edit_status_dto.dart';

abstract class RemoteStatusEvent {
  final dynamic param;
  const RemoteStatusEvent({this.param});
}

class GetStatuses extends RemoteStatusEvent {
  const GetStatuses();
}

class UpdateStatues extends RemoteStatusEvent {
  final StatusDTO statusDTO;
  const UpdateStatues(this.statusDTO);
}
