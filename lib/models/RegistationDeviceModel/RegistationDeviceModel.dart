class RegistationDeviceModel {
  RegistationDeviceModel({
      this.status, 
      this.message, 
      this.responseCode, 
      this.data,});

  RegistationDeviceModel.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    responseCode = json['responseCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  bool? status;
  String? message;
  int? responseCode;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['responseCode'] = responseCode;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      this.visitorToken,});

  Data.fromJson(dynamic json) {
    visitorToken = json['visitorToken'];
  }
  String? visitorToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['visitorToken'] = visitorToken;
    return map;
  }

}