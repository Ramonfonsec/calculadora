import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora',
      home: CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _displayText = '';

  // Função para inserir número ou operadores
  void _input(String text) {
    setState(() {
      _displayText += text;
    });
  }

  // Função para limpar o display
  void _clearDisplay() {
    setState(() {
      _displayText = '';
    });
  }

  // Função para calcular o resultado usando a biblioteca 'expressions'
  void _calculateResult() {
    try {
      final expression = Expression.parse(_displayText.replaceAll('x', '*'));
      final evaluator = const ExpressionEvaluator();
      var result = evaluator.eval(expression, {});
      setState(() {
        _displayText = result.toString();
      });
    } catch (e) {
      setState(() {
        _displayText = 'Erro';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          // Display
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              _displayText,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(),

          // Button Rows
          _buildButtonRow(['7', '8', '9', '/']),
          _buildButtonRow(['4', '5', '6', 'x']),
          _buildButtonRow(['1', '2', '3', '-']),
          _buildButtonRow(['0', 'C', '=', '+']),

          // Footer with developer name
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '© Ramon Fonseca',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((buttonText) {
        return _buildButton(buttonText);
      }).toList(),
    );
  }

  Widget _buildButton(String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 70, // Define o tamanho do botão quadrado
          height: 70, // Altura igual à largura para manter quadrado
          child: ElevatedButton(
            onPressed: () {
              if (text == 'C') {
                _clearDisplay();
              } else if (text == '=') {
                _calculateResult();
              } else {
                _input(text);
              }
            },
            child: Text(
              text,
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}
