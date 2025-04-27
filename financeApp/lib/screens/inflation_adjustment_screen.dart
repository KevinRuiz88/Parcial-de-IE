import 'package:flutter/material.dart';
import 'dart:math';

class InflationAdjustmentScreen extends StatefulWidget {
  @override
  _InflationAdjustmentScreenState createState() => _InflationAdjustmentScreenState();
}

class _InflationAdjustmentScreenState extends State<InflationAdjustmentScreen> {
  final TextEditingController _initialValueController = TextEditingController();
  final TextEditingController _inflationRateController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();

  double? _adjustedValue;

  void calculateAdjustedValue() {
    double initialValue = double.tryParse(_initialValueController.text) ?? 0;
    double inflationRate = double.tryParse(_inflationRateController.text) ?? 0;
    int years = int.tryParse(_yearsController.text) ?? 0;

    if (initialValue > 0 && inflationRate > 0 && years > 0) {
      double result = initialValue / pow(1 + inflationRate / 100, years);
      setState(() => _adjustedValue = result);
    } else {
      setState(() => _adjustedValue = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Ajuste por Inflación")),
      backgroundColor: Colors.blueGrey[900],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _initialValueController,
              decoration: InputDecoration(labelText: "Valor actual (COP)"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _inflationRateController,
              decoration: InputDecoration(labelText: "Inflación anual (%)"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _yearsController,
              decoration: InputDecoration(labelText: "Número de años"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateAdjustedValue,
              child: Text("Calcular Valor Ajustado"),
            ),
            SizedBox(height: 20),
            if (_adjustedValue != null)
              Text(
                "Valor ajustado: \$${_adjustedValue!.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 20, color: Colors.amberAccent),
              )
            else
              Text(
                "Por favor, introduce datos válidos.",
                style: TextStyle(color: Colors.redAccent),
              ),
          ],
        ),
      ),
    );
  }
}
