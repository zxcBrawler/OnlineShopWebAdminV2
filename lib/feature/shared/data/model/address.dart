import 'package:xc_web_admin/feature/shared/domain/entities/address_entity.dart';

class AddressModel extends AddressEntity {
  const AddressModel({
    int? idAddress,
    String? city,
    String? nameAddress,
    String? directionAddress,
  }) : super(
            idAddress: idAddress,
            city: city,
            nameAddress: nameAddress,
            directionAddress: directionAddress);

  factory AddressModel.fromJson(Map<String, dynamic> map) {
    return AddressModel(
      idAddress: map['idAddress'],
      city: map['city'],
      nameAddress: map['nameAddress'],
      directionAddress: map['directionAddress'],
    );
  }

  factory AddressModel.fromEntity(AddressEntity addressEntity) {
    return AddressModel(
      idAddress: addressEntity.idAddress,
      city: addressEntity.city,
      nameAddress: addressEntity.nameAddress,
      directionAddress: addressEntity.directionAddress,
    );
  }

  Map<String, dynamic> toJson() => {
        'idAddress': idAddress,
        'city': city,
        'nameAddress': nameAddress,
        'directionAddress': directionAddress,
      };
}
