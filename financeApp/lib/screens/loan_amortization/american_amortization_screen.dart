import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AmericanAmortizationScreen extends StatefulWidget {
  @override
  _AmericanAmortizationScreenState createState() => _AmericanAmortizationScreenState();
}

class _AmericanAmortizationScreenState extends State<AmericanAmortizationScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _termController = TextEditingController();
  final currencyFormat = NumberFormat.currency(locale: 'es_CO', symbol: '\$');

  List<Map<String, dynamic>> _schedule = [];

  void calculateAmericanAmortization() {
    double amount = double.tryParse(_amountController.text) ?? 0;
    double annualRate = double.tryParse(_rateController.text) ?? 0;
    int months = int.tryParse(_termController.text) ?? 0;

    if (amount <= 0 || annualRate <= 0 || months <= 0) return;

    double monthlyRate = annualRate / 12 / 100;
    double monthlyInterest = amount * monthlyRate;

    _schedule.clear();

    for (int i = 1; i <= months; i++) {
      double principal = (i == months) ? amount : 0;
      double payment = monthlyInterest + principal;

      _schedule.add({
        'month': i,
        'payment': payment,
        'interest': monthlyInterest,
        'principal': principal,
        'balance': (i == months) ? 0 : amount,
      });
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Amortización Americana")),
      backgroundColor: Colors.blueGrey[900],
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: "Monto del préstamo"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _rateController,
              decoration: InputDecoration(labelText: "Tasa de interés anual (%)"),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _termController,
              decoration: InputDecoration(labelText: "Plazo en meses"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: calculateAmericanAmortization,
              child: Text("Calcular"),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _schedule.length,
                itemBuilder: (context, index) {
                  final row = _schedule[index];
                  return ListTile(
                    title: Text("Cuota #${row['month']}", style: TextStyle(color: Colors.white)),
                    subtitle: Text(
                      "Pago: ${currencyFormat.format(row['payment'])}\nInterés: ${currencyFormat.format(row['interest'])}\nCapital: ${currencyFormat.format(row['principal'])}\nSaldo: ${currencyFormat.format(row['balance'])}",
                      style: TextStyle(color: Colors.white70),
                    ),
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
