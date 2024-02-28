class RoleEntity {
  final int? id;
  final String? roleName;

  const RoleEntity({this.id, this.roleName});

  List<String> getProperties() {
    return [
      'role name',
    ];
  }

  dynamic getPropertyValue(String propertyName) {
    switch (propertyName) {
      // Replace 'id' with the actual property name
      case 'role name':
        return roleName;

      default:
        throw ArgumentError('Invalid property name: $propertyName');
    }
  }
}
