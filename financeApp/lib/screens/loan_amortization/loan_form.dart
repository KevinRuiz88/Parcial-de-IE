import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';

class LoanForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onCalculate;

  LoanForm({required this.onCalculate});

  @override
  _LoanFormState createState() => _LoanFormState();
}

class _LoanFormState extends State<LoanForm> {
  final _amountController = TextEditingController();
  final _rateController = TextEditingController();
  final _timeController = TextEditingController();
  String _selectedUnit = 'Años';

  void _handleCalculate() {
    final double principal = double.tryParse(_amountController.text) ?? 0;
    final double rate = double.tryParse(_rateController.text) ?? 0;
    final int time = int.tryParse(_timeController.text) ?? 0;

    if (principal <= 0 || rate <= 0 || time <= 0) return;

    int months = _selectedUnit == 'Años'
        ? time * 12
        : _selectedUnit == 'Meses'
            ? time
            : (time / 30).round(); // Aproximación para días

    final monthlyRate = rate / 12 / 100;
    final monthlyPayment = (principal * monthlyRate) /
        (1 - pow(1 + monthlyRate, -months));

    double balance = principal;
    List<Map<String, dynamic>> table = [];

    for (int i = 1; i <= months; i++) {
      final interest = balance * monthlyRate;
      final principalPayment = monthlyPayment - interest;
      balance -= principalPayment;

      table.add({
        'period': i,
        'payment': monthlyPayment,
        'interest': interest,
        'principal': principalPayment,
        'balance': balance < 0 ? 0 : balance,
      });
    }

    final formatter = NumberFormat.currency(locale: 'es_CO', symbol: '\$');
    final total = monthlyPayment * months;

    widget.onCalculate({
      'table': table,
      'summary': {
        'monto': formatter.format(principal),
        'tasa': '$rate%',
        'plazo': '$time $_selectedUnit',
        'total': formatter.format(total),
      },
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _amountController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Monto del préstamo'),
        ),
        TextFormField(
          controller: _rateController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Tasa de interés anual (%)'),
        ),
        TextFormField(
          controller: _timeController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Plazo'),
        ),
        DropdownButton<String>(
          value: _selectedUnit,
          onChanged: (value) => setState(() => _selectedUnit = value!),
          items: ['Años', 'Meses', 'Días']
              .map((unit) => DropdownMenuItem(value: unit, child: Text(unit)))
              .toList(),
        ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: _handleCalculate,
          child: Text('Calcular'),
        ),
      ],
    );
  }
}
