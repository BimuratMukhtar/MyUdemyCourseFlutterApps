import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const apiKey = 'FE9EEC9B-47FD-483E-BC3D-BD01497AD48C';

class Rate {
  final String coin;
  final String currency;
  final String rate;

  Rate({this.coin, this.currency, this.rate});

  @override
  String toString() {
    return 'Rate{coin: $coin, currency: $currency, rate: $rate}';
  }
}

class CoinData {
  Future<List<Rate>> getCoinData(String currency) async {
    List<Future<Rate>> answers = [];
    for (String crypto in cryptoList) {
      answers.add(getCoin(crypto, currency));
    }
    List<Rate> waited = [];
    for (Future<Rate> rate in answers) {
      waited.add(await rate);
    }
    return waited;
  }

  Future<Rate> getCoin(String coin, String currency) async {
    LinkedHashMap<String, String> headers = LinkedHashMap();
    headers['X-CoinAPI-Key'] = apiKey;
    http.Response response = await http.get(
      'https://rest.coinapi.io/v1/exchangerate/$coin/$currency',
      headers: headers,
    );
    dynamic data = jsonDecode(response.body);
    print(data);
    return Rate(
        coin: coin,
        currency: currency,
        rate: (data['rate'] as num)?.toStringAsFixed(1) ?? '?');
  }
}
