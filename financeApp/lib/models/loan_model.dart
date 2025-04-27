class Loan {
  final String nombre;
  final double monto;
  final double tasaInteres;
  final int plazo; // en meses
  final double interesCalculado;
  final double totalPagar;

  Loan({
    required this.nombre,
    required this.monto,
    required this.tasaInteres,
    required this.plazo,
    required this.interesCalculado,
    required this.totalPagar,
  });
}
