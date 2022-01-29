class User {
  final String id;
  final String userName;

  const User({
    required this.id,
    required this.userName
  });
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      userName: json['userName']
    ); 
  }
}