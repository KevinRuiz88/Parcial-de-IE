import 'package:flutter/material.dart';

class LoansScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Préstamos Activos")),
      backgroundColor: Colors.blueGrey[900],
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Lista de préstamos activos",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: 3, // Se debe reemplazar con datos reales
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.blueGrey[800],
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      title: Text("Préstamo #${index + 1}", style: TextStyle(color: Colors.white)),
                      subtitle: Text("Monto: \$${(index + 1) * 1000}\nEstado: Aprobado",
                          style: TextStyle(color: Colors.white70)),
                      trailing: Icon(Icons.check_circle, color: Colors.tealAccent),
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
