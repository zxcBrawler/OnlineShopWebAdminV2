class ShopAddressEntity {
  final int? shopAddressId;
  final String? shopAddressDirection;
  final String? shopMetro;
  final String? contactNumber;
  final String? latitude;
  final String? longitude;

  const ShopAddressEntity(
      {this.shopAddressId,
      this.shopAddressDirection,
      this.shopMetro,
      this.contactNumber,
      this.latitude,
      this.longitude});

  List<String> getProperties() {
    return [
      'shop address direction',
      'shop metro',
      'contact number',
      'latitude',
      'longitude',
    ];
  }

  dynamic getPropertyValue(String propertyName) {
    switch (propertyName) {
      case 'shop address direction':
        return shopAddressDirection;
      case 'shop metro':
        return shopMetro;
      case 'contact number':
        return contactNumber;
      case 'latitude':
        return latitude;
      case 'longitude':
        return longitude;
      default:
        throw ArgumentError('Invalid property name: $propertyName');
    }
  }
}
