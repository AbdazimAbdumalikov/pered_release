class OrderAccident {
  bool? success;
  int? statusCode;
  String? message;
  String? data;

  OrderAccident({this.success, this.statusCode, this.message, this.data});

  OrderAccident.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['statusCode'];
    message = json['message'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['statusCode'] = this.statusCode;
    data['message'] = this.message;
    data['data'] = this.data;
    return data;
  }
}