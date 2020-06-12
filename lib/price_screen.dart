import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;
import 'coin_data.dart';
import 'coin_data.dart';
import 'coin_data.dart';
import 'services/NetworkHelper.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String BTCtoUSD = '?';
  String btctoUSD;

  String ETHtoUSD = '?';
  String ethtoUSD;

  String LTCtoUSD = '?';
  String ltctoUSD;

  NetworkHelper networkHelper = NetworkHelper();
  int currencyIndex = 0;
  void initState() {
    super.initState();
    getBTCRate();
    getETHRate();
    getLTCRate();
  }

  DropdownButton<String> androidDropdownButton() {
    List<DropdownMenuItem<String>> dropDownItems = [];
    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];
      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );
      dropDownItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedString,
      items: dropDownItems,
      onChanged: (value) {
        setState(() {
          selectedString = value;
        });
      },
    );
  }

  CupertinoPicker iosPicker() {
    String currency;
    List<Text> item = [];
    for (currency in currenciesList) {
      var currencyItem = Text(
        currency,
        style: TextStyle(
          color: Colors.white,
        ),
      );
      item.add(currencyItem);
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      useMagnifier: true,
      magnification: 1.1,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedindex) {
        setState(() {
          currencyIndex = selectedindex;
          getBTCRate();
          getETHRate();
          getLTCRate();
        });
      },
      children: item,
    );
  }

  void getBTCRate() async {
    btctoUSD =
        await networkHelper.getNetworkData(currenciesList[currencyIndex], 0);
    setState(() {
      BTCtoUSD = btctoUSD;
    });
  }

  void getETHRate() async {
    ethtoUSD =
        await networkHelper.getNetworkData(currenciesList[currencyIndex], 1);
    setState(() {
      ETHtoUSD = ethtoUSD;
    });
  }

  void getLTCRate() async {
    ltctoUSD =
        await networkHelper.getNetworkData(currenciesList[currencyIndex], 2);
    setState(() {
      LTCtoUSD = ltctoUSD;
    });
  }

  @override
  String selectedString = 'USD';
  CoinData coinData = CoinData();
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Column(
              children: <Widget>[
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 BTC = $BTCtoUSD ${currenciesList[currencyIndex]}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = $ETHtoUSD ${currenciesList[currencyIndex]}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = $LTCtoUSD ${currenciesList[currencyIndex]}',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? iosPicker() : androidDropdownButton(),
          ),
        ],
      ),
    );
  }
}
