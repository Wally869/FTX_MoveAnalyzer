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




class CurrentPrices {
  List<CurrentPricesResult> result;
  bool success;

  CurrentPrices({this.result, this.success});

  CurrentPrices.fromJson(Map<String, dynamic> json) {
    if (json['result'] != null) {
      result = new List<CurrentPricesResult>();
      json['result'].forEach((v) {
        result.add(new CurrentPricesResult.fromJson(v));
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

class CurrentPricesResult {
  double ask;
  String baseCurrency;
  double bid;
  double change1h;
  double change24h;
  double changeBod;
  bool enabled;
  double last;
  double minProvideSize;
  String name;
  bool postOnly;
  double price;
  double priceIncrement;
  String quoteCurrency;
  double quoteVolume24h;
  bool restricted;
  double sizeIncrement;
  String type;
  String underlying;
  double volumeUsd24h;

  CurrentPricesResult(
      {this.ask,
      this.baseCurrency,
      this.bid,
      this.change1h,
      this.change24h,
      this.changeBod,
      this.enabled,
      this.last,
      this.minProvideSize,
      this.name,
      this.postOnly,
      this.price,
      this.priceIncrement,
      this.quoteCurrency,
      this.quoteVolume24h,
      this.restricted,
      this.sizeIncrement,
      this.type,
      this.underlying,
      this.volumeUsd24h});

  CurrentPricesResult.fromJson(Map<String, dynamic> json) {
    ask = json['ask'];
    baseCurrency = json['baseCurrency'];
    bid = json['bid'];
    change1h = json['change1h'];
    change24h = json['change24h'];
    changeBod = json['changeBod'];
    enabled = json['enabled'];
    last = json['last'];
    minProvideSize = json['minProvideSize'];
    name = json['name'];
    postOnly = json['postOnly'];
    price = json['price'];
    priceIncrement = json['priceIncrement'];
    quoteCurrency = json['quoteCurrency'];
    quoteVolume24h = json['quoteVolume24h'];
    restricted = json['restricted'];
    sizeIncrement = json['sizeIncrement'];
    type = json['type'];
    underlying = json['underlying'];
    volumeUsd24h = json['volumeUsd24h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ask'] = this.ask;
    data['baseCurrency'] = this.baseCurrency;
    data['bid'] = this.bid;
    data['change1h'] = this.change1h;
    data['change24h'] = this.change24h;
    data['changeBod'] = this.changeBod;
    data['enabled'] = this.enabled;
    data['last'] = this.last;
    data['minProvideSize'] = this.minProvideSize;
    data['name'] = this.name;
    data['postOnly'] = this.postOnly;
    data['price'] = this.price;
    data['priceIncrement'] = this.priceIncrement;
    data['quoteCurrency'] = this.quoteCurrency;
    data['quoteVolume24h'] = this.quoteVolume24h;
    data['restricted'] = this.restricted;
    data['sizeIncrement'] = this.sizeIncrement;
    data['type'] = this.type;
    data['underlying'] = this.underlying;
    data['volumeUsd24h'] = this.volumeUsd24h;
    return data;
  }
}




class MoveResponseAPI {
  MoveResult result;
  bool success;

  MoveResponseAPI({this.result, this.success});

  MoveResponseAPI.fromJson(Map<String, dynamic> json) {
    result =
        json['result'] != null ? new MoveResult.fromJson(json['result']) : null;
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    data['success'] = this.success;
    return data;
  }
}

class MoveResult {
  num ask;
  num bid;
  num change1h;
  num change24h;
  num changeBod;
  String description;
  bool enabled;
  bool expired;
  String expiry;
  String expiryDescription;
  String group;
  num imfFactor;
  num index;
  num last;
  num lowerBound;
  num marginPrice;
  num mark;
  String moveStart;
  String name;
  bool perpetual;
  num positionLimitWeight;
  bool postOnly;
  num priceIncrement;
  num sizeIncrement;
  String type;
  String underlying;
  String underlyingDescription;
  num upperBound;
  num volume;
  num volumeUsd24h;

  MoveResult(
      {this.ask,
      this.bid,
      this.change1h,
      this.change24h,
      this.changeBod,
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
      this.upperBound,
      this.volume,
      this.volumeUsd24h});

  MoveResult.fromJson(Map<String, dynamic> json) {
    ask = json['ask'];
    bid = json['bid'];
    change1h = json['change1h'];
    change24h = json['change24h'];
    changeBod = json['changeBod'];
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
    volume = json['volume'];
    volumeUsd24h = json['volumeUsd24h'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ask'] = this.ask;
    data['bid'] = this.bid;
    data['change1h'] = this.change1h;
    data['change24h'] = this.change24h;
    data['changeBod'] = this.changeBod;
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
    data['volume'] = this.volume;
    data['volumeUsd24h'] = this.volumeUsd24h;
    return data;
  }
}
