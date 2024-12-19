// To parse this JSON data, do
//
//     final checkEmailVerifyModel = checkEmailVerifyModelFromJson(jsonString);

import 'dart:convert';

CheckEmailVerifyModel checkEmailVerifyModelFromJson(String str) => CheckEmailVerifyModel.fromJson(json.decode(str));

String checkEmailVerifyModelToJson(CheckEmailVerifyModel data) => json.encode(data.toJson());

class CheckEmailVerifyModel {
    int? status;
    bool? success;
    String? message;

    CheckEmailVerifyModel({
        this.status,
        this.success,
        this.message,
    });

    factory CheckEmailVerifyModel.fromJson(Map<String, dynamic> json) => CheckEmailVerifyModel(
        status: json["status"],
        success: json["success"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "success": success,
        "message": message,
    };
}
