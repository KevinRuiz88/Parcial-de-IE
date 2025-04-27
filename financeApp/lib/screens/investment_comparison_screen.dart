import 'package:flutter/material.dart';
import 'dart:math';

class InvestmentComparisonScreen extends StatefulWidget {
  @override
  _InvestmentComparisonScreenState createState() => _InvestmentComparisonScreenState();
}

class _InvestmentComparisonScreenState extends State<InvestmentComparisonScreen> {
  final TextEditingController _rateController = TextEditingController(text: "10");
  final TextEditingController _projectAController = TextEditingController();
  final TextEditingController _projectBController = TextEditingController();
  double? _vanA, _vanB;

  double calcularVAN(List<double> flujos, double tasa) {
    double van = 0;
    for (int t = 0; t < flujos.length; t++) {
      van += flujos[t] / pow(1 + tasa, t);
    }
    return van;
  }

  void evaluarProyectos() {
    try {
      double tasa = (double.tryParse(_rateController.text) ?? 0) / 100;
      List<double> flujosA = _projectAController.text.split(',').map((e) => double.tryParse(e.trim()) ?? 0).toList();
      List<double> flujosB = _projectBController.text.split(',').map((e) => double.tryParse(e.trim()) ?? 0).toList();

      setState(() {
        _vanA = calcularVAN(flujosA, tasa);
        _vanB = calcularVAN(flujosB, tasa);
      });
    } catch (e) {
      setState(() {
        _vanA = null;
        _vanB = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Evaluación de Alternativas de Inversión")),
      backgroundColor: Colors.blueGrey[900],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _rateController,
              decoration: InputDecoration(labelText: "Tasa de Descuento (%)"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              controller: _projectAController,
              decoration: InputDecoration(
                labelText: "Flujos Proyecto A (separados por comas)",
                hintText: "-1000, 300, 400, 500",
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _projectBController,
              decoration: InputDecoration(
                labelText: "Flujos Proyecto B (separados por comas)",
                hintText: "-800, 200, 350, 600",
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: evaluarProyectos,
              child: Text("Evaluar Alternativas"),
            ),
            SizedBox(height: 20),
            if (_vanA != null && _vanB != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("VAN Proyecto A: \$${_vanA!.toStringAsFixed(2)}", style: TextStyle(color: Colors.greenAccent, fontSize: 18)),
                  Text("VAN Proyecto B: \$${_vanB!.toStringAsFixed(2)}", style: TextStyle(color: Colors.tealAccent, fontSize: 18)),
                  SizedBox(height: 10),
                  Text(
                    _vanA! > _vanB!
                        ? "✅ Proyecto A es más rentable"
                        : _vanA == _vanB
                            ? "⚖️ Ambos proyectos son equivalentes"
                            : "✅ Proyecto B es más rentable",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ],
              )
            else
              Text("Introduce flujos y tasa válidos", style: TextStyle(color: Colors.redAccent)),
          ],
        ),
      ),
    );
  }
}
