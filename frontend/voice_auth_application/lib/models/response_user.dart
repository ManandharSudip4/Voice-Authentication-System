import 'package:voice_auth_app/models/user.dart';

class ResponseUsers {
  final String status;
  final int code;
  final String? error;
  final String? success;
  final List<User>? data;

  const ResponseUsers({
    required this.status,
    required this.code,
    required this.error,
    required this.success,
    required this.data
  });
  factory ResponseUsers.fromJson(Map<String, dynamic> json) {
    List<User>? data = [];
    if (json['data'] != null){
      json['data'].forEach((d){
        data!.add(User.fromJson(d));
      });
    }else{
      data = null;
    }
    return ResponseUsers(
      status: json['status'],
      code: json['code'],
      error: json['error'],
      success: json['success'],
      data: data
      // data: jsonDecode(json['data'])
    );
  }
}

class ResponseSingleUser {
  final String status;
  final int code;
  final String? error;
  final String? success;
  final User? data;

  const ResponseSingleUser({
    required this.status,
    required this.code,
    required this.error,
    required this.success,
    required this.data
  });
  factory ResponseSingleUser.fromJson(Map<String, dynamic> json) {
    User? data;
    if (json['data'] != null){
      data = User.fromJson(json['data']);
    }else{
      data = null;
    }
    return ResponseSingleUser(
      status: json['status'],
      code: json['code'],
      error: json['error'],
      success: json['success'],
      data: data
      // data: jsonDecode(json['data'])
    );
  }
}
// class Autogenerated {
//   String? status;
//   int? code;
//   Null? error;
//   String? success;
//   List<Data>? data;

//   Autogenerated({this.status, this.code, this.error, this.success, this.data});

//   Autogenerated.fromJson(Map<String, dynamic> json) {
//     status = json['status'];
//     code = json['code'];
//     error = json['error'];
//     success = json['success'];
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['status'] = this.status;
//     data['code'] = this.code;
//     data['error'] = this.error;
//     data['success'] = this.success;
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Data {
//   String? sId;
//   String? userName;

//   Data({this.sId, this.userName});

//   Data.fromJson(Map<String, dynamic> json) {
//     sId = json['_id'];
//     userName = json['userName'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['_id'] = this.sId;
//     data['userName'] = this.userName;
//     return data;
//   }
// }