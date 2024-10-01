class Register {
  Register({
    required this.mobile,
    required this.code,
  });

  final String? mobile;
  final String? code;

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      code: json["code"],
      mobile: json["mobile"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "code": code,
      "mobile": mobile,
    };
  }

  @override
  String toString() {
    return "$code, $mobile, ";
  }
}
