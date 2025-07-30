import 'dart:convert';

class Application {
  final int id;
  final String name;
  String kodeOtp;
  final String issuer;
  final String secretKey;
  final String algorithm;

  Application({
    required this.id,
    required this.name,
    required this.kodeOtp,
    required this.issuer,
    required this.secretKey,
    required this.algorithm,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      kodeOtp: json['kode_otp'] ?? '',
      issuer: json['issuer'] ?? '',
      secretKey: json['secret_key'] ?? '',
      algorithm: json['algorithm'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'kode_otp': kodeOtp,
      'issuer': issuer,
      'secret_key': secretKey,
      'algorithm': algorithm,
    };
  }
}

List<Application> decodeApplicationList(String jsonString) {
  final List<dynamic> jsonList = jsonDecode(jsonString);
  return jsonList.map((json) => Application.fromJson(json)).toList();
}

String encodeAppllicationList(List<Application> users) {
  final List<Map<String, dynamic>> jsonList = users
      .map((u) => u.toJson())
      .toList();
  return jsonEncode(jsonList);
}
