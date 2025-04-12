import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Variables {
  static String supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY'] ??
      "No se ha encontrado el Anon Key de Supabase";
}

enum Operations { income, expense }

extension OperationsExtension on Operations {
  static Operations fromName(String? name) {
    return Operations.values.firstWhere(
      (operation) => operation.name == name,
      orElse: () => Operations.expense, // Valor predeterminado
    );
  }
}

// Icons related to monetary actions
const Map<String, IconData> icons = {
  'Wallet': Icons.wallet,
  'Bank': Icons.account_balance,
  'Savings': Icons.savings,
  'Credit Card': Icons.credit_card,
  'Cash': Icons.money,
  'Piggy Bank': Icons.savings,
  'Investment': Icons.trending_up,
  'Shopping Cart': Icons.shopping_cart,
  'Money Transfer': Icons.swap_horiz,
  'Loan': Icons.request_quote,
  'Budget': Icons.pie_chart,
  'Coins': Icons.monetization_on,
  'Safe': Icons.safety_check,
  'Receipt': Icons.receipt,
  'Check': Icons.check_circle,
};
// Colors with names and HEX values
const List<Map<String, String>> colors = [
  {'name': 'Red', 'hex': '#FF0000'},
  {'name': 'Blue', 'hex': '#0000FF'},
  {'name': 'Green', 'hex': '#008000'},
  {'name': 'Yellow', 'hex': '#FFFF00'},
  {'name': 'Purple', 'hex': '#800080'},
  {'name': 'Orange', 'hex': '#FFA500'},
  {'name': 'Pink', 'hex': '#FFC0CB'},
  {'name': 'Teal', 'hex': '#008080'},
  {'name': 'Brown', 'hex': '#A52A2A'},
  {'name': 'Gray', 'hex': '#808080'},
];

// Currencies with country names and currency codes
const List<Map<String, String>> currencies = [
  {'country': 'United States', 'currency': 'USD'},
  {'country': 'Eurozone', 'currency': 'EUR'},
  {'country': 'United Kingdom', 'currency': 'GBP'},
  {'country': 'Japan', 'currency': 'JPY'},
  {'country': 'India', 'currency': 'INR'},
  {'country': 'Canada', 'currency': 'CAD'},
  {'country': 'Australia', 'currency': 'AUD'},
  {'country': 'Switzerland', 'currency': 'CHF'},
  {'country': 'China', 'currency': 'CNY'},
  {'country': 'Sweden', 'currency': 'SEK'},
  {'country': 'New Zealand', 'currency': 'NZD'},
  {'country': 'Mexico', 'currency': 'MXN'},
  {'country': 'Singapore', 'currency': 'SGD'},
  {'country': 'Hong Kong', 'currency': 'HKD'},
  {'country': 'Norway', 'currency': 'NOK'},
  {'country': 'South Korea', 'currency': 'KRW'},
  {'country': 'Turkey', 'currency': 'TRY'},
  {'country': 'Russia', 'currency': 'RUB'},
  {'country': 'Brazil', 'currency': 'BRL'},
  {'country': 'South Africa', 'currency': 'ZAR'},
  {'country': 'Philippines', 'currency': 'PHP'},
  {'country': 'Indonesia', 'currency': 'IDR'},
  {'country': 'Malaysia', 'currency': 'MYR'},
  {'country': 'Thailand', 'currency': 'THB'},
  {'country': 'Vietnam', 'currency': 'VND'},
];
