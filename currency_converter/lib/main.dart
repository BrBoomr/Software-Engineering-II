//https://free.currencyconverterapi.com/api/v6/convert?q=USD_MXN&compact=ultra&apiKey=742f830814a3d14293bb
//https://free.currencyconverterapi.com/api/v6/convert?q=MXN_USD&compact=ultra&apiKey=742f830814a3d14293bb
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';

void main() {
  runApp(new MaterialApp(
      title: 'USD-MXN Converter',
      theme: new ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: new CryptoConverter()));
}

class CustomButton extends StatelessWidget {
  CustomButton({this.text, this.onPressed});

  final String text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: RawMaterialButton(
          shape: const BeveledRectangleBorder(),
          constraints: BoxConstraints.tight(Size(80.0, 80.0)),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: Colors.black, fontSize: 20.0),
          ),
          fillColor: Colors.grey,
        ));
  }
}

class OperatorButton extends StatelessWidget {
  OperatorButton({this.onPressed, this.text});

  final text;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(5.0),
        child: RawMaterialButton(
          shape: const BeveledRectangleBorder(),
          constraints: BoxConstraints.tight(Size(80.0, 80.0)),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          fillColor: Colors.orange,
        ));
  }
}
Future<double> getMXNRate() async{
    var response = await http.get("https://free.currencyconverterapi.com/api/v6/convert?q=USD_MXN&compact=ultra&apiKey=742f830814a3d14293bb");
    return jsonDecode(response.body)["USD_MXN"];
}

class BitcoinView extends StatelessWidget {
  final double _billAmount;

  BitcoinView(this._billAmount);

  @override
  
  Widget build(BuildContext context) {
    var formatCurrency =
        new NumberFormat.currency(decimalDigits: 2, symbol: "");

    double _mxnRate;
    //double _mxnRate =  getMXNRate();
    getMXNRate().then((val) {
      _mxnRate = val;
    });

    var _calculatedMXN = _billAmount * _mxnRate;

    var bitcoinSign = new Text("\B",
        textAlign: TextAlign.left,
        style: TextStyle(color: Colors.grey.withOpacity(0.30), fontSize: 30.0));

    var bitcoinBox = new Text(" ${formatCurrency.format(_calculatedMXN)}",
        textAlign: TextAlign.left,
        style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 30.0));

    return ListTile(leading: bitcoinSign, title: bitcoinBox);
  }
}

class CryptoConverter extends StatefulWidget {
  @override
  _CryptoConverterState createState() => _CryptoConverterState();
}

class _CryptoConverterState extends State<CryptoConverter> {
  double _billAmount = 0.0;
  var _billAmountStr = "0";

  @override
  Widget build(BuildContext context) {
    var formatCurrency =
        new NumberFormat.currency(decimalDigits: 2, symbol: "");

    var dollarSign = new Text("\$ ",
        textAlign: TextAlign.left,
        style: TextStyle(color: Colors.grey.withOpacity(0.30), fontSize: 30.0));

    var cashBox = new Text(" ${formatCurrency.format(_billAmount)}",
        textAlign: TextAlign.left,
        style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 30.0));
    var _resultRow = ListTile(leading: dollarSign, title: cashBox);
    void buttonPressed(var char) {
      setState(() {
        try {
          if (_billAmountStr == "0") {
            _billAmount = double.parse(char);
            _billAmountStr = char;
          } else {
            _billAmount = double.parse(_billAmountStr + char);
            _billAmountStr += char;
          }
        } catch (e) {
          _billAmount = double.parse(_billAmountStr);
        }
      });
    }

    var buttonRow1 = SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomButton(
                  text: "7",
                  onPressed: () {
                    buttonPressed("7");
                  },
                ),
                CustomButton(
                    text: "8",
                    onPressed: () {
                      buttonPressed("8");
                    }),
                CustomButton(
                    text: "9",
                    onPressed: () {
                      buttonPressed("9");
                    }),
              ],
            ),
          ],
        ),
      ),
    );

    var buttonRow2 = SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomButton(
                    text: "4",
                    onPressed: () {
                      buttonPressed("4");
                    }),
                CustomButton(
                    text: "5",
                    onPressed: () {
                      buttonPressed("5");
                    }),
                CustomButton(
                    text: "6",
                    onPressed: () {
                      buttonPressed("6");
                    }),
              ],
            ),
          ],
        ),
      ),
    );

    var buttonRow3 = SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomButton(
                    text: "1",
                    onPressed: () {
                      buttonPressed("1");
                    }),
                CustomButton(
                    text: "2",
                    onPressed: () {
                      buttonPressed("2");
                    }),
                CustomButton(
                    text: "3",
                    onPressed: () {
                      buttonPressed("3");
                    }),
              ],
            ),
          ],
        ),
      ),
    );

    var buttonRow4 = SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                CustomButton(
                    text: ".",
                    onPressed: () {
                      buttonPressed(".");
                    }),
                CustomButton(
                    text: "0",
                    onPressed: () {
                      buttonPressed("0");
                    }),
                OperatorButton(
                  text: "Clear",
                  onPressed: () {
                    setState(() {
                      _billAmountStr = "0";
                      _billAmount = 0;
                    });
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );

    Container container = new Container(
        decoration: BoxDecoration(
          color: Colors.black
        ),
        padding: const EdgeInsets.all(16.0),
        child: new Column(children: [
          new BitcoinView(_billAmount),
          _resultRow,
          Spacer(),
          buttonRow1,
          buttonRow2,
          buttonRow3,
          buttonRow4
        ]));

    AppBar appBar =
        new AppBar(centerTitle: true, title: new Text("USD-MXN"));

    Scaffold scaffold = new Scaffold(
        appBar: appBar,
        body: container,
        backgroundColor: Theme.of(context).primaryColor);
    return scaffold;
  }
}
