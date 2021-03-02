import 'dart:io' show Platform;

import 'package:bitcoin_ticker/coin_data.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

const initiallySelectedIndex = 0;

class _PriceScreenState extends State<PriceScreen> {
  CoinData coinData = CoinData();
  int selectedIndex = initiallySelectedIndex;
  List<Rate> rates = [];

  void onItemSelected(int selectedIndex) {
    setState(() {
      this.selectedIndex = selectedIndex;
      getRate(selectedIndex);
    });
  }

  getRate(int selectedIndex) async {
    var rates = await coinData.getCoinData(currenciesList[selectedIndex]);
    setState(() {
      this.rates = rates;
    });
  }

  CupertinoPicker getIosPicker() {
    List<Widget> items = [];
    currenciesList.forEach((element) {
      items.add(Text(element));
    });
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        onItemSelected(selectedIndex);
      },
      children: items,
    );
  }

  DropdownButton getAndroidDropdown() {
    List<DropdownMenuItem> items = [];
    for (int index = 0; index < currenciesList.length; index++) {
      final currentCurrency = currenciesList[index];
      items.add(DropdownMenuItem(
        child: Text(currentCurrency),
        value: currentCurrency,
      ));
    }

    return DropdownButton(
      value: currenciesList[selectedIndex],
      items: items,
      onChanged: (selectedValue) {
        onItemSelected(currenciesList.indexOf(selectedValue));
      },
    );
  }

  @override
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
              children: rates
                  .map(
                    (rate) => Card(
                        color: Colors.lightBlueAccent,
                        elevation: 5.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 15.0, horizontal: 28.0),
                          child: Text(
                            '1 ${rate.coin} = ${rate.rate} ${rate.currency}',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        )),
                  )
                  .toList(),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS ? getIosPicker() : getAndroidDropdown(),
          ),
        ],
      ),
    );
  }
}
