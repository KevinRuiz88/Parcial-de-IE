import 'package:flutter/material.dart';

class ArithmeticGradientScreen extends StatefulWidget {
  @override
  _ArithmeticGradientScreenState createState() => _ArithmeticGradientScreenState();
}

class _ArithmeticGradientScreenState extends State<ArithmeticGradientScreen> {
  final TextEditingController _initialPaymentController = TextEditingController();
  final TextEditingController _gradientController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String _selectedTimeUnit = 'Años';
  double _total = 0;
  List<String> _history = [];

  void calculateGradient() {
    double initialPayment = double.tryParse(_initialPaymentController.text) ?? 0;
    double gradient = double.tryParse(_gradientController.text) ?? 0;
    double time = double.tryParse(_timeController.text) ?? 0;

    if (_selectedTimeUnit == 'Meses') {
      time = time / 12;
    } else if (_selectedTimeUnit == 'Días') {
      time = time / 365;
    }

    setState(() {
      _total = initialPayment + (gradient * time);
      _history.insert(0, "Pago Inicial: \$${initialPayment.toStringAsFixed(2)}, Total: \$${_total.toStringAsFixed(2)}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gradiente Aritmético")),
      backgroundColor: Colors.blueGrey[900],
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _initialPaymentController,
              decoration: InputDecoration(labelText: "Pago Inicial"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _gradientController,
              decoration: InputDecoration(labelText: "Gradiente"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: "Tiempo"),
              keyboardType: TextInputType.number,
            ),
            DropdownButton<String>(
              value: _selectedTimeUnit,
              items: ["Años", "Meses", "Días"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedTimeUnit = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateGradient,
              child: Text("Calcular"),
            ),
            SizedBox(height: 20),
            Text("Total: \$${_total.toStringAsFixed(2)}", style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _history.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_history[index], style: TextStyle(color: Colors.white)),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}