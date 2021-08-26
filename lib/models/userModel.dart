enum UserRole { Volunteer, Admin, Visitor }

class User {
  String _name;
  String _email;
  // String _lastLogin;
  String? _memberSinceDate;
  String? _phoneNumber;
  String _id;
  String _role;
  int? _score;
  User(
      {required String id,
      required String email,
      required String name,
      required String role,
      required String memberSinceDate,
      String? phoneNumber,
      // required String lastLogin,
      int? score})
      : this._id = id,
        this._email = email,
        this._name = name,
        this._role = role,
        // this._lastLogin = lastLogin,
        this._memberSinceDate = memberSinceDate,
        this._score = score,
        this._phoneNumber = phoneNumber;

  /// The BITS ID string
  String get id => _id;

  String get name => _name;

  // String get lastLogin => _lastLogin;

  // set lastLogin(String lastLogin) => _lastLogin = lastLogin;
  /// Name as provided by database call
  String get email => _email;

  /// UserRole for displaying in UI
  String get roleString => _role;

  /// UserRole to use in managing role based views
  UserRole get role {
    switch (this.roleString) {
      case "Volunteer":
        return UserRole.Volunteer;
      default:
        return UserRole.Admin;
    }
  }

  String get phoneNumber => _phoneNumber ?? "No number provided";

  // set email(String email) => _email = email;
  factory User.fromJson(Map<String, dynamic> json) {
    if (json['user'] == null)
      return User(
          id: json["_id"],
          email: json['email'],
          name: json['name'],
          memberSinceDate: json['memberSinceDate'] ?? "2020",
          role: json['role'] ?? "Volunteer");
    else
      return User(
          id: json['user']["_id"],
          email: json['user']['email'],
          name: json['user']['name'],
          memberSinceDate: json['user']['memberSinceDate'] ?? "2020",
          role: json['user']['role'] ?? "Volunteer");
  }
  Map<String, dynamic> toJson() => {
        "_id": _id,
        "name": _name,
        "email": email,
        "role": _role,
        "phoneNumber": _phoneNumber,
        "score": _score,
      };
  //  {
  //   _userId = json['userId'];
  //   _username = json['username'];
  //   _name = json['name'];
  //   _lastLogin = json['lastLogin'];
  //   _email = json['email'];
  // }
}
