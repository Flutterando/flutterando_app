enum Roles {
  standart('standard'),
  admin('admin'),
  creator('creator');

  final String label;
  const Roles(this.label);

  static Roles fromString(String data) => Roles.values.firstWhere((role) {
    return role.label == data;
  }, orElse: () => Roles.standart);

  @override
  String toString() => label;
}
