import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UvrConverterScreen extends StatefulWidget {
  @override
  _UvrConverterScreenState createState() => _UvrConverterScreenState();
}

class _UvrConverterScreenState extends State<UvrConverterScreen> {
  final TextEditingController _copController = TextEditingController();
  final TextEditingController _uvrRateController = TextEditingController(text: "300");
  double? _convertedValue;
  final currencyFormat = NumberFormat.currency(locale: 'es_CO', symbol: '\$');

  void convertToUVR() {
    double cop = double.tryParse(_copController.text) ?? 0;
    double uvrRate = double.tryParse(_uvrRateController.text) ?? 1;
    if (cop > 0 && uvrRate > 0) {
      setState(() {
        _convertedValue = cop / uvrRate;
      });
    } else {
      setState(() => _convertedValue = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Conversión COP → UVR")),
      backgroundColor: Colors.blueGrey[900],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _copController,
              decoration: InputDecoration(
                labelText: "Valor en Pesos Colombianos",
                prefixText: "\$ ",
              ),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _uvrRateController,
              decoration: InputDecoration(
                labelText: "Tasa UVR (COP por 1 UVR)",
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: convertToUVR,
              child: Text("Convertir"),
            ),
            SizedBox(height: 20),
            if (_convertedValue != null)
              Text(
                "Equivalente en UVR: ${_convertedValue!.toStringAsFixed(2)} UVR",
                style: TextStyle(fontSize: 22, color: Colors.tealAccent),
              ),
            if (_convertedValue == null)
              Text(
                "Ingrese valores válidos.",
                style: TextStyle(color: Colors.redAccent),
              ),
          ],
        ),
      ),
    );
  }
}
