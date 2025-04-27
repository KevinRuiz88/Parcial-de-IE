import 'package:finance_app/screens/loan_amortization/loan_amortization_screen.dart';
import 'package:flutter/material.dart';
import 'package:finance_app/screens/loan_application_screen.dart';
import 'package:finance_app/screens/loans_screen.dart';
import 'package:finance_app/screens/finance_calculations_screen.dart';
import 'package:finance_app/screens/simple_interest_screen.dart';
import 'package:finance_app/screens/compound_interest_screen.dart';
import 'package:finance_app/screens/arithmetic_gradient_screen.dart';
import 'package:finance_app/screens/bond_valuation_screen.dart';
import 'package:finance_app/screens/inflation_adjustment_screen.dart';
import 'package:finance_app/screens/investment_comparison_screen.dart';
import 'package:finance_app/screens/tir_screen.dart';
import 'package:finance_app/screens/uvr_converter_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bienvenido a FinanceApp"),
        backgroundColor: Colors.blueGrey[900],
      ),
      backgroundColor: Colors.blueGrey[800],
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Selecciona una opción',
              style: TextStyle(color: Colors.white70, fontSize: 18),
            ),
            SizedBox(height: 20),
            _buildButton(context, "Aplicación de Préstamos", LoanApplicationScreen(), Icons.credit_card),
            _buildButton(context, "Préstamos Activos", LoansScreen(), Icons.attach_money),
            _buildButton(context, "Amortización de Préstamos", LoanAmortizationScreen(), Icons.date_range),
            _buildButton(context, "Cálculos Financieros", FinanceCalculationsScreen(), Icons.calculate),
            _buildButton(context, "Interés Simple", SimpleInterestScreen(), Icons.money),
            _buildButton(context, "Interés Compuesto", CompoundInterestScreen(), Icons.monetization_on),
            _buildButton(context, "Gradiente Aritmético", ArithmeticGradientScreen(), Icons.show_chart),
            _buildButton(context, "Valor de Bonos", BondValuationScreen(), Icons.assessment),
            _buildButton(context, "Ajuste por Inflación", InflationAdjustmentScreen(), Icons.trending_up),
            _buildButton(context, "Comparación de Inversiones", InvestmentComparisonScreen(), Icons.compare_arrows),
            _buildButton(context, "Tasa Interna de Retorno (TIR)", TirScreen(), Icons.trending_flat),
            _buildButton(context, "Conversor UVR", UvrConverterScreen(), Icons.swap_horiz),
          ],
        ),
      ),
    );
  }

  Widget _buildButton(BuildContext context, String title, Widget screen, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton.icon(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => screen),
          );
        },
        icon: Icon(icon, color: Colors.white),
        label: Text(title, style: TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey[700],
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
