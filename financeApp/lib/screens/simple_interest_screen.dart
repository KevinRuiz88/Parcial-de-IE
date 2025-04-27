import 'package:flutter/material.dart';

class SimpleInterestScreen extends StatefulWidget {
  @override
  _SimpleInterestScreenState createState() => _SimpleInterestScreenState();
}

class _SimpleInterestScreenState extends State<SimpleInterestScreen> {
  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  String _selectedTimeUnit = 'Años';
  double _result = 0;
  List<String> _history = [];

  void calculateSimpleInterest() {
    double principal = double.tryParse(_principalController.text) ?? 0;
    double rate = double.tryParse(_rateController.text) ?? 0;
    double time = double.tryParse(_timeController.text) ?? 0;

    if (_selectedTimeUnit == 'Meses') {
      time = time / 12;
    } else if (_selectedTimeUnit == 'Días') {
      time = time / 365;
    }

    setState(() {
      _result = (principal * rate * time) / 100;
      _history.insert(0, "Capital: \$${principal.toStringAsFixed(2)}, Interés: \$${_result.toStringAsFixed(2)}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Interés Simple")),
      backgroundColor: Colors.blueGrey[900],
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _principalController,
              decoration: InputDecoration(labelText: "Capital Inicial"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _rateController,
              decoration: InputDecoration(labelText: "Tasa de Interés (%)"),
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
              onPressed: calculateSimpleInterest,
              child: Text("Calcular"),
            ),
            SizedBox(height: 20),
            Text("Interés: \$${_result.toStringAsFixed(2)}", style: TextStyle(fontSize: 20)),
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
