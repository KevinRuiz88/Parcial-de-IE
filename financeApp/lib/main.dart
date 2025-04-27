import 'package:finance_app/screens/loan_amortization/loan_amortization_screen.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/loan_application_screen.dart';
import 'screens/loans_screen.dart';
import 'screens/finance_calculations_screen.dart';
import 'screens/simple_interest_screen.dart';
import 'screens/compound_interest_screen.dart';
import 'screens/arithmetic_gradient_screen.dart';
import 'screens/bond_valuation_screen.dart';
import 'screens/inflation_adjustment_screen.dart';
import 'screens/investment_comparison_screen.dart';
import 'screens/tir_screen.dart';
import 'screens/uvr_converter_screen.dart';


void main() {
  runApp(FinanceApp());
}

class FinanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinanceApp',
      theme: ThemeData(
        primaryColor: Colors.blueGrey,
        colorScheme: ColorScheme.dark().copyWith(
          primary: Colors.blueGrey,
          secondary: Colors.tealAccent,
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
        ),
      ),
      initialRoute: '/home', // Asegúrate de que la pantalla inicial sea Home
      routes: {
        '/home': (context) => HomeScreen(),
        '/loan_application': (context) => LoanApplicationScreen(),
        '/loans': (context) => LoansScreen(),
        '/loan_amortization': (context) => LoanAmortizationScreen(),
        '/finance_calculations': (context) => FinanceCalculationsScreen(),
        '/simple_interest': (context) => SimpleInterestScreen(),
        '/compound_interest': (context) => CompoundInterestScreen(),
        '/arithmetic_gradient': (context) => ArithmeticGradientScreen(),
        '/bond_valuation': (context) => BondValuationScreen(),
        '/inflation_adjustment': (context) => InflationAdjustmentScreen(),
        '/investment_comparison': (context) => InvestmentComparisonScreen(),
        '/tir': (context) => TirScreen(),
        '/uvr_converter': (context) => UvrConverterScreen(),
      },
    );
  }
}
