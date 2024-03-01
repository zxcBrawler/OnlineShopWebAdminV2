class StatusOrderEntity {
  final int? idStatus;
  final String? nameStatus;

  const StatusOrderEntity({this.idStatus, this.nameStatus});

  List<String> getProperties() {
    return [
      'status name',
    ];
  }

  dynamic getPropertyValue(String propertyName) {
    switch (propertyName) {
      case 'status name':
        return nameStatus;

      default:
        throw ArgumentError('Invalid property name: $propertyName');
    }
  }
}
