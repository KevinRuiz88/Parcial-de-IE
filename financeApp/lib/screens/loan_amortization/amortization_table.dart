import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AmortizationTable extends StatelessWidget {
  final List<Map<String, dynamic>> table;

  AmortizationTable({required this.table});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'es_CO', symbol: '\$');

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('Periodo')),
          DataColumn(label: Text('Pago')),
          DataColumn(label: Text('Interés')),
          DataColumn(label: Text('Amortización')),
          DataColumn(label: Text('Saldo')),
        ],
        rows: table.map((row) {
          return DataRow(cells: [
            DataCell(Text('${row['period']}')),
            DataCell(Text(formatter.format(row['payment']))),
            DataCell(Text(formatter.format(row['interest']))),
            DataCell(Text(formatter.format(row['principal']))),
            DataCell(Text(formatter.format(row['balance']))),
          ]);
        }).toList(),
      ),
    );
  }
}
