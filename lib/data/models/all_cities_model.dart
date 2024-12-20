
class AllCitiesModel {
    int? status;
    String? message;
    List<CityModel>? result;

    AllCitiesModel({
        this.status,
        this.message,
        this.result,
    });

    factory AllCitiesModel.fromJson(Map<String, dynamic> json) => AllCitiesModel(
        status: json["status"],
        message: json["message"],
        result: json["result"] == null ? [] : List<CityModel>.from(json["result"]!.map((x) => CityModel.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "result": result == null ? [] : List<CityModel>.from(result!.map((x) => x.toJson())),
    };
}

class CityModel {
    String? id;
    String? text;

    CityModel({
        this.id,
        this.text,
    });

    factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
        id: json["id"],
        text: json["text"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "text": text,
    };
}
