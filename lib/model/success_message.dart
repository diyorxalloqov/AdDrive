class SuccessMessage {
  final bool? success;
  final String? message;

  SuccessMessage({this.success, this.message});

  factory SuccessMessage.fromJson(Map<String, dynamic> json) {
    return SuccessMessage(success: json['success'], message: json['message']);
  }
}
