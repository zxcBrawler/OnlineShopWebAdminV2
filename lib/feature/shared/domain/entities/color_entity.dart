class ColorEntity {
  final int? colorId;
  final String? nameColor;
  final String? hex;

  const ColorEntity({this.colorId, this.nameColor, this.hex});

  List<String> getProperties() {
    return [
      'name color',
      'hex value',
    ];
  }

  dynamic getPropertyValue(String propertyName) {
    switch (propertyName) {
      case 'name color':
        return nameColor;
      case 'hex value':
        return hex;

      default:
        throw ArgumentError('Invalid property name: $propertyName');
    }
  }
}
