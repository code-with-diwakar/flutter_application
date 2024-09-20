import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for input formatters

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  _CalculatorViewState createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final TextEditingController _controllerOne = TextEditingController();
  final TextEditingController _controllerTwo = TextEditingController();
  final TextEditingController _resultController = TextEditingController();

  // Function to perform the selected operation
  void _performOperation(String operation) {
    setState(() {
      double num1 = double.tryParse(_controllerOne.text) ?? 0;
      double num2 = double.tryParse(_controllerTwo.text) ?? 0;
      double result = 0;

      switch (operation) {
        case '+':
          result = num1 + num2;
          break;
        case '−':
          result = num1 - num2;
          break;
        case '×':
          result = num1 * num2;
          break;
        case '÷':
          if (num2 != 0) {
            result = num1 / num2;
          } else {
            // Handle division by zero
            _resultController.text = 'Error: Division by zero';
            return;
          }
          break;
      }
      _resultController.text = result.toString();
    });
  }

  // Function to clear all the fields
  void _clearFields() {
    setState(() {
      _controllerOne.clear();
      _controllerTwo.clear();
      _resultController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            // Input and result fields in a Card
            Card(
              elevation: 8,
              margin: const EdgeInsets.all(8.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    DisplayOne(controller: _controllerOne),
                    const SizedBox(height: 20),
                    DisplayOne(controller: _controllerTwo),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _resultController,
                      readOnly: true,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: "Result",
                        hintText: "The result will be shown here",
                        filled: true,
                        fillColor: Colors.grey[300],
                      ),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // Operation buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Addition button
                OperationButton(
                  symbol: '+',
                  color: Colors.green,
                  onTap: () => _performOperation('+'),
                ),
                // Subtraction button
                OperationButton(
                  symbol: '−',
                  color: Colors.orange,
                  onTap: () => _performOperation('−'),
                ),
                // Multiplication button
                OperationButton(
                  symbol: '×',
                  color: Colors.purple,
                  onTap: () => _performOperation('×'),
                ),
                // Division button
                OperationButton(
                  symbol: '÷',
                  color: Colors.red,
                  onTap: () => _performOperation('÷'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Clear All button
            ElevatedButton.icon(
              onPressed: _clearFields,
              icon: const Icon(Icons.clear),
              label: const Text('Clear All'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                textStyle: const TextStyle(fontSize: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom widget for the operation buttons
class OperationButton extends StatelessWidget {
  final String symbol;
  final Color color;
  final VoidCallback onTap;

  const OperationButton({
    required this.symbol,
    required this.color,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: const Size(70, 70),
        shape: const CircleBorder(),
      ),
      child: Text(
        symbol,
        style: const TextStyle(
          fontSize: 32,
          color: Colors.white,
        ),
      ),
    );
  }
}

// Custom widget for input fields
class DisplayOne extends StatelessWidget {
  final TextEditingController controller;

  const DisplayOne({
    required this.controller, // Pass controller from parent
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller, // Bind controller
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')), // Allow digits and decimal point
      ],
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: "Enter a number",
        hintText: "Enter a number",
        filled: true,
        fillColor: Colors.grey[200],
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue, // Change color as necessary
          ),
        ),
      ),
    );
  }
}
