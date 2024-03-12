class SizeClothesEntity {
  final int? id;
  final String? nameSize;

  const SizeClothesEntity({this.id, this.nameSize});
  List<String> getProperties() {
    return [
      'name size',
    ];
  }

  dynamic getPropertyValue(String propertyName) {
    switch (propertyName) {
      case 'name size':
        return nameSize;

      default:
        throw ArgumentError('Invalid property name: $propertyName');
    }
  }
}
