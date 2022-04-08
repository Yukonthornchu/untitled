class TimeListModel {
  final List<TimeModel>? data;

  TimeListModel({this.data});

  factory TimeListModel.fromJson(List<dynamic> parsedJson) {
    List<TimeModel> data = <TimeModel>[];
    data = parsedJson.map((i) => TimeModel.fromJson(i)).toList();
    return new TimeListModel(data: data);
  }
}

class TimeModel {
  String? priceUsd;
  int? time;
  String? circulatingSupply;
  String? date;

  TimeModel({this.priceUsd, this.time, this.circulatingSupply, this.date});

  TimeModel.fromJson(Map<String, dynamic> json) {
    priceUsd = json['priceUsd'];
    time = json['time'];
    circulatingSupply = json['circulatingSupply'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['priceUsd'] = this.priceUsd;
    data['time'] = this.time;
    data['circulatingSupply'] = this.circulatingSupply;
    data['date'] = this.date;
    return data;
  }
}
