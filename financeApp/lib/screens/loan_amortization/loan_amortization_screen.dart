import 'dart:math';  // Importar dart:math para usar la función pow

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LoanAmortizationScreen extends StatefulWidget {
  @override
  _LoanAmortizationScreenState createState() => _LoanAmortizationScreenState();
}

class _LoanAmortizationScreenState extends State<LoanAmortizationScreen> {
  final _loanAmountController = TextEditingController();
  final _interestRateController = TextEditingController();
  final _loanTermController = TextEditingController();

  String _result = '';
  final currencyFormat = NumberFormat.currency(locale: 'es_CO', symbol: '\$');

  void _calculateAmortization() {
    final loanAmount = double.tryParse(_loanAmountController.text);
    final interestRate = double.tryParse(_interestRateController.text);
    final loanTerm = int.tryParse(_loanTermController.text);

    if (loanAmount != null && interestRate != null && loanTerm != null) {
      final monthlyInterestRate = interestRate / 100 / 12;
      final numberOfPayments = loanTerm * 12;

      // Usar pow de dart:math
      final monthlyPayment = loanAmount * monthlyInterestRate /
          (1 - pow(1 + monthlyInterestRate, -numberOfPayments));

      final totalPayment = monthlyPayment * numberOfPayments;
      final totalInterest = totalPayment - loanAmount;

      setState(() {
        _result = "Pago mensual: ${currencyFormat.format(monthlyPayment)}\n"
                  "Pago total: ${currencyFormat.format(totalPayment)}\n"
                  "Interés total: ${currencyFormat.format(totalInterest)}";
      });
    } else {
      setState(() {
        _result = "Por favor ingrese valores válidos.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Amortización del Préstamo'),
      ),
      backgroundColor: Colors.blueGrey[900],
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _loanAmountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Monto del Préstamo',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent),
                ),
                hintText: 'Ingrese el monto del préstamo',
                hintStyle: TextStyle(color: Colors.white70),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _interestRateController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Tasa de Interés Anual (%)',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent),
                ),
                hintText: 'Ingrese la tasa de interés anual',
                hintStyle: TextStyle(color: Colors.white70),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _loanTermController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Plazo del Préstamo (Años)',
                labelStyle: TextStyle(color: Colors.white),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.tealAccent),
                ),
                hintText: 'Ingrese el plazo del préstamo en años',
                hintStyle: TextStyle(color: Colors.white70),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _calculateAmortization,
              child: Text('Calcular'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.tealAccent,
              ),
            ),
            SizedBox(height: 20),
            Text(
              _result,
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
