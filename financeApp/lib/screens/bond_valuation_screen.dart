import 'package:flutter/material.dart';
import 'dart:math';

class BondValuationScreen extends StatefulWidget {
  @override
  _BondValuationScreenState createState() => _BondValuationScreenState();
}

class _BondValuationScreenState extends State<BondValuationScreen> {
  final TextEditingController _faceValueController = TextEditingController();
  final TextEditingController _couponRateController = TextEditingController();
  final TextEditingController _marketRateController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();

  double? _presentValue;

  double calculateBondPrice(double faceValue, double couponRate, double marketRate, int years) {
    double coupon = faceValue * couponRate / 100;
    double r = marketRate / 100;

    double presentCoupons = 0;
    for (int t = 1; t <= years; t++) {
      presentCoupons += coupon / pow(1 + r, t);
    }

    double presentFaceValue = faceValue / pow(1 + r, years);
    return presentCoupons + presentFaceValue;
  }

  void calculateBond() {
    double faceValue = double.tryParse(_faceValueController.text) ?? 0;
    double couponRate = double.tryParse(_couponRateController.text) ?? 0;
    double marketRate = double.tryParse(_marketRateController.text) ?? 0;
    int years = int.tryParse(_yearsController.text) ?? 0;

    if (faceValue > 0 && couponRate > 0 && marketRate > 0 && years > 0) {
      double price = calculateBondPrice(faceValue, couponRate, marketRate, years);
      setState(() => _presentValue = price);
    } else {
      setState(() => _presentValue = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Valoración de Bonos")),
      backgroundColor: Colors.blueGrey[900],
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _faceValueController,
              decoration: InputDecoration(labelText: "Valor nominal del bono"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _couponRateController,
              decoration: InputDecoration(labelText: "Tasa de cupón (%)"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _marketRateController,
              decoration: InputDecoration(labelText: "Tasa de mercado (%)"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _yearsController,
              decoration: InputDecoration(labelText: "Plazo en años"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateBond,
              child: Text("Calcular Valor Actual"),
            ),
            SizedBox(height: 20),
            if (_presentValue != null)
              Text("Valor actual del bono: \$${_presentValue!.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 20, color: Colors.greenAccent)),
            if (_presentValue == null)
              Text("Introduce datos válidos", style: TextStyle(color: Colors.redAccent)),
          ],
        ),
      ),
    );
  }
}
