import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String? selectedCurrency = "USD";
  var target;
  var bitCoinRates;
  var etheriumRates;
  var lightCoinRates;
  List<DropdownMenuItem<String>> getDropdownList() {
    List<DropdownMenuItem<String>> dropdownList = [];

    for (int i = 0; i < currenciesList.length; i++) {
      String currency = currenciesList[i];

      var newItem = DropdownMenuItem(
        child: Text(currency),
        value: currency,
      );

      dropdownList.add(newItem);
    }

    return dropdownList;
  }

  Future getData() async {
    var url =
        'http://api.coinlayer.com/live?access_key=c358647accd38b02999dd0014b17d506';
    Uri urlAddress = Uri.parse(url);

    http.Response response = await http.get(urlAddress);

    if (response.statusCode == 200) {
      var data = response.body;
      // print(data["target"]);
      var decodedData = jsonDecode(data);
      // target = decodedData["target"];
      // double ratesDouble = decodedData["rates"]["BTC"];
      // rates = ratesDouble.toInt();
      // print(target);
      // print(rates);
      return decodedData;
    } else {
      print(response.statusCode);
    }
  }

  void setTexts() async {
    var decodedData = await getData();
    setState(() {
      target = decodedData["target"];
      double bitcoinDouble = decodedData["rates"]["BTC"];
      bitCoinRates = bitcoinDouble.toInt();
      double etheriumDouble = decodedData["rates"]["ETH"];
      etheriumRates = etheriumDouble.toInt();
      double lightCoinDouble = decodedData["rates"]["LTC"];
      lightCoinRates = lightCoinDouble.toInt();
      print(target);
      print(bitCoinRates);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setTexts();
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 28.0),
                        child: Text(
                          '1 BTC = $bitCoinRates $target',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 ETH = $etheriumRates $target',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                child: Card(
                  color: Colors.lightBlueAccent,
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                    child: Text(
                      '1 LTC = $lightCoinRates $target',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: DropdownButton<String>(
              value: selectedCurrency,
              items: getDropdownList(),
              onChanged: (value) {
                setState(() {
                  selectedCurrency = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
