import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bitcoin_ticker/coin_data.dart';

import '../coin_data.dart';
import '../coin_data.dart';

class NetworkHelper {
  String url = 'https://rest.coinapi.io/v1/exchangerate';
  String apikey = '8996568E-14BB-4656-8AF1-F99407F48CD2';
  String currencyName = 'USD';
  Future getNetworkData(String currency, int listindex) async {
    try {
      CoinData coinData = CoinData();
      currencyName = coinData.getCryptoList(listindex);
      print('CurrencyName: $currencyName');
      var response =
          await http.get('$url/$currencyName/$currency?apikey=$apikey');
      var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var rate = data['rate'];
        return rate.toString();
      } else {
        return 'Error';
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
