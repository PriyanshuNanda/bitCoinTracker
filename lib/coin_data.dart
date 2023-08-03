import 'dart:convert';
import 'package:http/http.dart'as http;

const aPIKey='44036556-6505-4AF7-91E3-85C204588512';
const url='https://rest.coinapi.io/v1/exchangerate/';

class CoinData{
  late http.Response response;
  Future getCoinData(String value,String cryptoCurrency) async {
    http.Response response=await http.get(Uri.parse('$url$cryptoCurrency/$value/apikey-$aPIKey'));
    if(response.statusCode==200){return jsonDecode(response.body)['rate'];}
    else{
      print('NO Data');
    }
  }

}


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
