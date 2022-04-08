class MarketListModel {
  final List<MarketModel>? data;

  MarketListModel({this.data});

  factory MarketListModel.fromJson(List<dynamic> parsedJson) {
    List<MarketModel> data = <MarketModel>[];
    data = parsedJson.map((i) => MarketModel.fromJson(i)).toList();
    return new MarketListModel(data: data);
  }
}

class MarketModel {
  String? symbol;
  String? pair;
  String? priceChange;
  String? priceChangePercent;
  String? weightedAvgPrice;
  String? lastPrice;
  String? lastQty;
  String? openPrice;
  String? highPrice;
  String? lowPrice;
  String? volume;
  String? baseVolume;
  int? openTime;
  int? closeTime;
  int? firstId;
  int? lastId;
  int? count;

  MarketModel(
      {this.symbol,
      this.pair,
      this.priceChange,
      this.priceChangePercent,
      this.weightedAvgPrice,
      this.lastPrice,
      this.lastQty,
      this.openPrice,
      this.highPrice,
      this.lowPrice,
      this.volume,
      this.baseVolume,
      this.openTime,
      this.closeTime,
      this.firstId,
      this.lastId,
      required this.count});

  MarketModel.fromJson(Map<String, dynamic> json) {
    symbol = json['symbol'];
    pair = json['pair'];
    priceChange = json['priceChange'];
    priceChangePercent = json['priceChangePercent'];
    weightedAvgPrice = json['weightedAvgPrice'];
    lastPrice = json['lastPrice'];
    lastQty = json['lastQty'];
    openPrice = json['openPrice'];
    highPrice = json['highPrice'];
    lowPrice = json['lowPrice'];
    volume = json['volume'];
    baseVolume = json['baseVolume'];
    openTime = json['openTime'];
    closeTime = json['closeTime'];
    firstId = json['firstId'];
    lastId = json['lastId'];
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symbol'] = this.symbol;
    data['pair'] = this.pair;
    data['priceChange'] = this.priceChange;
    data['priceChangePercent'] = this.priceChangePercent;
    data['weightedAvgPrice'] = this.weightedAvgPrice;
    data['lastPrice'] = this.lastPrice;
    data['lastQty'] = this.lastQty;
    data['openPrice'] = this.openPrice;
    data['highPrice'] = this.highPrice;
    data['lowPrice'] = this.lowPrice;
    data['volume'] = this.volume;
    data['baseVolume'] = this.baseVolume;
    data['openTime'] = this.openTime;
    data['closeTime'] = this.closeTime;
    data['firstId'] = this.firstId;
    data['lastId'] = this.lastId;
    data['count'] = this.count;
    return data;
  }
}
