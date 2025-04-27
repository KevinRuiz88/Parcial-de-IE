import 'package:flutter/material.dart';

class LoanApplicationScreen extends StatefulWidget {
  @override
  _LoanApplicationScreenState createState() => _LoanApplicationScreenState();
}

class _LoanApplicationScreenState extends State<LoanApplicationScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  void submitLoanRequest() {
    String name = _nameController.text;
    double amount = double.tryParse(_amountController.text) ?? 0;
    double rate = double.tryParse(_rateController.text) ?? 0;
    int time = int.tryParse(_timeController.text) ?? 0;

    if (name.isNotEmpty && amount > 0 && rate > 0 && time > 0) {
      Navigator.pushNamed(context, '/loans');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Solicitud de Préstamo")),
      backgroundColor: Colors.blueGrey[900],
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Nombre"),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: "Monto del Préstamo"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _rateController,
              decoration: InputDecoration(labelText: "Tasa de Interés (%)"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: "Tiempo en años"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitLoanRequest,
              child: Text("Solicitar Préstamo"),
            ),
          ],
        ),
      ),
    );
  }
}
