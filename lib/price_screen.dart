import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:bitcointracker/coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen({super.key});
  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  double currencyValue = 0;
  double currencyValue2 = 0;
  double currencyValue3 = 0;
  // String cryptoCurrency='BTC';
  Widget androidPicker() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        value: currency,
        child: Text(currency),
      );
      dropdownItems.add(newItem);
    }
    return DropdownButton<String>(
      dropdownColor: Colors.cyan,
      style: const TextStyle(color: Colors.black,),
        value: selectedCurrency,
        items: dropdownItems,
        onChanged: (newValue) {
          setState(() {
            selectedCurrency = newValue!;
            getValue();
          });
        });
  }

  Widget iOSPicker() {
    List<Widget> newWidget = [];
    String currency = '';
    for (currency in currenciesList) {
      newWidget.add(Text(currency));
    }
    return CupertinoPicker(
      itemExtent: 35,
      onSelectedItemChanged: (setIndex) {
        setState(() {
          selectedCurrency = currenciesList[setIndex];
          getValue();
        });
      },
      children: newWidget,
    );
  }

  Future<void> getValue() async {
    try {
      double data1 = await CoinData().getCoinData(selectedCurrency, 'BTC');
      double data2 = await CoinData().getCoinData(selectedCurrency, 'ETH');
      double data3 = await CoinData().getCoinData(selectedCurrency, 'LTC');

      //13. We can't await in a setState(). So you have to separate it out into two steps.
      setState(() {
        String strValue = data1.toStringAsFixed(3);
        currencyValue = double.parse(strValue);
        String strValue1 = data2.toStringAsFixed(3);
        currencyValue2 = double.parse(strValue1);
        String strValue2 = data3.toStringAsFixed(3);
        currencyValue3 = double.parse(strValue2);

        // print(currencyValue);
      });
    } catch (e) {
      // print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getValue();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.cyan,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child:Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 BTC = $currencyValue $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.cyan,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child:Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 ETH = $currencyValue2 $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.cyan,
                    elevation: 5.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child:Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                      child: Text(
                        '1 LTC = $currencyValue $selectedCurrency',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: const EdgeInsets.only(bottom: 30.0),
            color: Colors.cyan,
            child: Platform.isIOS ? iOSPicker() : androidPicker(),
          ),
        ],
      ),
    );
  }
}
