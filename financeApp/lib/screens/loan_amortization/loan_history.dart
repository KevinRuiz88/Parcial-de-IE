import 'package:flutter/material.dart';

class LoanHistory extends StatelessWidget {
  final List<Map<String, dynamic>> history;

  LoanHistory({required this.history});

  @override
  Widget build(BuildContext context) {
    if (history.isEmpty) return SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(),
        Text("Historial de Simulaciones", style: TextStyle(fontWeight: FontWeight.bold)),
        SizedBox(height: 8),
        ...history.map((entry) => Card(
              child: ListTile(
                title: Text('Monto: ${entry['monto']} | Total: ${entry['total']}'),
                subtitle: Text('Tasa: ${entry['tasa']} | Plazo: ${entry['plazo']}'),
              ),
            )),
      ],
    );
  }
}
