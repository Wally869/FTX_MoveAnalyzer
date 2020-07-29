import 'package:http/http.dart' as http;
import 'dart:convert';

import 'ftxQueryClasses.dart';

const String corsEndpoint = "https://lendfinex-cors.herokuapp.com/";
const String apiEndpoint = "https://ftx.com/api/expired_futures";

Future<ExpiredFutures> fetchExpiredContractsData() async {
  var response =
      await http.get(apiEndpoint); //http.get(corsEndpoint + apiEndpoint);

  if (response.statusCode == 200) {
    return ExpiredFutures.fromJson(json.decode(response.body));
  } else {
    throw Exception("Failed to fetch Expired Contracts Data");
  }
}

List<String> weekDays = new List<String>.from({
  "",
  "Monday",
  "Tuesday",
  "Wednesday",
  "Thursday",
  "Friday",
  "Saturday",
  "Sunday"
}); // padding to start at 1
List<String> months = new List<String>.from({
  "", // padding to start at 1
  "January",
  "February",
  "March",
  "April",
  "May",
  "June",
  "July",
  "August",
  "September",
  "October",
  "November",
  "December"
});

class PrunedDataContract {
  num expiryPrice;
  num underlyingPrice;
  String contractDay;
  String contractMonth;

  PrunedDataContract(Result apiRawData) {
    this.expiryPrice = apiRawData.last;
    this.underlyingPrice = apiRawData.index;

    //print(apiRawData.expiry);
    var dateContract = DateTime.parse(apiRawData.expiry);
    this.contractDay = weekDays[dateContract.weekday];
    this.contractMonth = months[dateContract.month];
  }
}

main() {
  List<PrunedDataContract> prunedDatas = new List<PrunedDataContract>();
  fetchExpiredContractsData().then((expiredFuturesData) => {
        for (int i = 0; i < expiredFuturesData.result.length; i++)
          {
            prunedDatas
                .add(new PrunedDataContract(expiredFuturesData.result[i]))
          },
      });

  //print(DateTime.parse("2020-07-29").month);
  //print(prunedDatas[0]);
}
