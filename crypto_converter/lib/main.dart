import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(new MaterialApp(
      title: 'Crypto Converter',
      theme: new ThemeData(
        primaryColor: Colors.purple[600],
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

class BitcoinView extends StatelessWidget {
  final double _billAmount;

  BitcoinView(this._billAmount);

  @override
  Widget build(BuildContext context) {
    var formatCurrency =
        new NumberFormat.currency(decimalDigits: 2, symbol: "");

    double _bitcoinRate = 10;
    double _calculatedBitcoin = _billAmount * _bitcoinRate / 100.0;

    var bitcoinSign = new Text("\B",
        textAlign: TextAlign.left,
        style: TextStyle(color: Colors.grey.withOpacity(0.30), fontSize: 30.0));

    var bitcoinBox = new Text(" ${formatCurrency.format(_calculatedBitcoin)}",
        textAlign: TextAlign.left,
        style: TextStyle(
            color: Colors.white.withOpacity(0.6), fontSize: 30.0));

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
        style: TextStyle(
            color: Colors.white.withOpacity(0.6), fontSize: 30.0));
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
                  text: "X",
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
        gradient: LinearGradient(
          // Where the linear gradient begins and ends
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // Add one stop for each color. Stops should increase from 0 to 1
          stops: [0.1, 0.5, 0.7, 0.9],
          colors: [
            // Colors are easy thanks to Flutter's Colors class.
            Colors.purple[800],
            Colors.purple[700],
            Colors.purple[600],
            Colors.purple[400],
          ],
        ),
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

    AppBar appBar = new AppBar(centerTitle:true, title: new Text("Crypto Converter"));

    Scaffold scaffold = new Scaffold(
        appBar: appBar,
        body: container,
        backgroundColor: Theme.of(context).primaryColor);
    return scaffold;
  }
}
