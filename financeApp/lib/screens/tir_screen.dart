import 'package:flutter/material.dart';
import 'dart:math';

class TirScreen extends StatefulWidget {
  @override
  _TirScreenState createState() => _TirScreenState();
}

class _TirScreenState extends State<TirScreen> {
  final TextEditingController _flowsController = TextEditingController();
  double? _tirResult;

  double calculateTIR(List<double> flows, {double guess = 0.1}) {
    const double tolerance = 1e-6;
    const int maxIterations = 1000;
    double x0 = guess;
    for (int i = 0; i < maxIterations; i++) {
      double f = 0;
      double df = 0;
      for (int t = 0; t < flows.length; t++) {
        f += flows[t] / pow(1 + x0, t);
        if (t > 0) {
          df -= t * flows[t] / pow(1 + x0, t + 1);
        }
      }
      double x1 = x0 - f / df;
      if ((x1 - x0).abs() < tolerance) return x1;
      x0 = x1;
    }
    return double.nan;
  }

  void onCalculate() {
    try {
      List<double> flows = _flowsController.text
          .split(',')
          .map((s) => double.tryParse(s.trim()) ?? 0)
          .toList();
      double result = calculateTIR(flows);
      setState(() => _tirResult = result * 100);
    } catch (e) {
      setState(() => _tirResult = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Tasa Interna de Retorno (TIR)")),
      backgroundColor: Colors.blueGrey[900],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _flowsController,
              decoration: InputDecoration(
                labelText: 'Flujos de caja (separados por comas)',
                hintText: 'Ej: -1000, 200, 300, 400, 500',
              ),
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: onCalculate,
              child: Text("Calcular TIR"),
            ),
            SizedBox(height: 20),
            if (_tirResult != null)
              Text(
                "TIR: ${_tirResult!.toStringAsFixed(2)}%",
                style: TextStyle(fontSize: 22, color: Colors.greenAccent),
              ),
            if (_tirResult == null)
              Text(
                "Por favor, ingresa valores válidos.",
                style: TextStyle(color: Colors.redAccent),
              ),
          ],
        ),
      ),
    );
  }
}
