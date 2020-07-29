class ExpiredFutures {
  List<Result> result;
  bool success;

  ExpiredFutures({this.result, this.success});

  ExpiredFutures.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    data['success'] = this.success;
    return data;
  }
}

class Result {
  Null ask;
  Null bid;
  String description;
  bool enabled;
  bool expired;
  String expiry;
  String expiryDescription;
  String group;
  double imfFactor;
  double index;
  double last;
  double lowerBound;
  double marginPrice;
  double mark;
  String moveStart;
  String name;
  bool perpetual;
  double positionLimitWeight;
  bool postOnly;
  double priceIncrement;
  double sizeIncrement;
  String type;
  String underlying;
  String underlyingDescription;
  double upperBound;

  Result(
      {this.ask,
      this.bid,
      this.description,
      this.enabled,
      this.expired,
      this.expiry,
      this.expiryDescription,
      this.group,
      this.imfFactor,
      this.index,
      this.last,
      this.lowerBound,
      this.marginPrice,
      this.mark,
      this.moveStart,
      this.name,
      this.perpetual,
      this.positionLimitWeight,
      this.postOnly,
      this.priceIncrement,
      this.sizeIncrement,
      this.type,
      this.underlying,
      this.underlyingDescription,
      this.upperBound});

  Result.fromJson(Map<String, dynamic> json) {
    ask = json['ask'];
    bid = json['bid'];
    description = json['description'];
    enabled = json['enabled'];
    expired = json['expired'];
    expiry = json['expiry'];
    expiryDescription = json['expiryDescription'];
    group = json['group'];
    imfFactor = json['imfFactor'];
    index = json['index'];
    last = json['last'];
    lowerBound = json['lowerBound'];
    marginPrice = json['marginPrice'];
    mark = json['mark'];
    moveStart = json['moveStart'];
    name = json['name'];
    perpetual = json['perpetual'];
    positionLimitWeight = json['positionLimitWeight'];
    postOnly = json['postOnly'];
    priceIncrement = json['priceIncrement'];
    sizeIncrement = json['sizeIncrement'];
    type = json['type'];
    underlying = json['underlying'];
    underlyingDescription = json['underlyingDescription'];
    upperBound = json['upperBound'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ask'] = this.ask;
    data['bid'] = this.bid;
    data['description'] = this.description;
    data['enabled'] = this.enabled;
    data['expired'] = this.expired;
    data['expiry'] = this.expiry;
    data['expiryDescription'] = this.expiryDescription;
    data['group'] = this.group;
    data['imfFactor'] = this.imfFactor;
    data['index'] = this.index;
    data['last'] = this.last;
    data['lowerBound'] = this.lowerBound;
    data['marginPrice'] = this.marginPrice;
    data['mark'] = this.mark;
    data['moveStart'] = this.moveStart;
    data['name'] = this.name;
    data['perpetual'] = this.perpetual;
    data['positionLimitWeight'] = this.positionLimitWeight;
    data['postOnly'] = this.postOnly;
    data['priceIncrement'] = this.priceIncrement;
    data['sizeIncrement'] = this.sizeIncrement;
    data['type'] = this.type;
    data['underlying'] = this.underlying;
    data['underlyingDescription'] = this.underlyingDescription;
    data['upperBound'] = this.upperBound;
    return data;
  }
}
