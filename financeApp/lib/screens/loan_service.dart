import 'package:flutter/material.dart';
// Asegúrate de tener la lógica de servicios en este archivo
import 'package:intl/intl.dart';

class LoansScreen extends StatelessWidget {
  final currencyFormat = NumberFormat.currency(locale: 'es_CO', symbol: '\$');

  @override
  Widget build(BuildContext context) {
    final loans = LoanService.getLoans();  // Obtiene los préstamos

    return Scaffold(
      appBar: AppBar(title: Text("Préstamos Activos")),
      backgroundColor: Colors.blueGrey[900],
      body: Padding(
        padding: EdgeInsets.all(20),
        child: loans.isEmpty
            ? Center(
                child: Text(
                  "No hay préstamos registrados",
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                ),
              )
            : ListView.builder(
                itemCount: loans.length,
                itemBuilder: (context, index) {
                  final loan = loans[index];
                  return Card(
                    color: Colors.blueGrey[800],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text(
                        loan.nombre,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        "Monto: ${currencyFormat.format(loan.monto)}\nTasa: ${loan.tasaInteres}%\nPlazo: ${loan.plazo} años\nInterés: ${currencyFormat.format(loan.interesCalculado)}\nTotal a pagar: ${currencyFormat.format(loan.totalPagar)}",
                        style: TextStyle(color: Colors.white70),
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete, color: Colors.redAccent),
                        onPressed: () {
                          LoanService.removeLoan(index);  // Elimina el préstamo
                          // Actualiza la vista después de la eliminación
                          // ignore: invalid_use_of_protected_member
                          (context as Element).reassemble();
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

// Clase LoanService (ejemplo básico de implementación)
class LoanService {
  static List<Loan> _loans = [
    Loan(nombre: "Préstamo 1", monto: 1000000, tasaInteres: 12, plazo: 5),
    Loan(nombre: "Préstamo 2", monto: 500000, tasaInteres: 8, plazo: 3),
  ];

  static List<Loan> getLoans() {
    return _loans;
  }

  static void removeLoan(int index) {
    _loans.removeAt(index);
  }
}

class Loan {
  String nombre;
  double monto;
  double tasaInteres;
  int plazo;
  double interesCalculado;
  double totalPagar;

  Loan({
    required this.nombre,
    required this.monto,
    required this.tasaInteres,
    required this.plazo,
  })  : interesCalculado = monto * tasaInteres / 100 * plazo,
        totalPagar = monto + (monto * tasaInteres / 100 * plazo);
}
