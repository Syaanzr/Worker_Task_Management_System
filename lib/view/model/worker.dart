//import 'dart:math';

class Worker {
  String? iD;
  String? name;
  String? email;
  String? phone;
  String? password;
  String? address;

  Worker(
      {this.iD,
      this.name,
      this.email,
      this.phone,
      this.password,
      this.address,
      });

  Worker.fromJson(Map<String, dynamic> json) {
    iD = json['iD'].toString();
    name = json['name'].toString();
    email = json['email'].toString();
    phone = json['phone'].toString();
    password = json['password'].toString();
    address = json['address'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iD'] = iD;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['password'] = password;
    data['address'] = address;
    return data;
  }
}