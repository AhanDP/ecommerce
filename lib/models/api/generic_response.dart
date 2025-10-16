class GenericResponse {
  bool status = false;
  String message = "";

  GenericResponse.fromJson(Map<String, dynamic> json) {
    status = json["status"] ?? false;
    message = json["message"] ?? json["Message"] ?? "";
  }

  static GenericResponse fromJsonToModel(Map<String, dynamic> json) =>
      GenericResponse.fromJson(json);
}
