import 'package:flutter/material.dart';

class CurrencyConverterMaterialPage extends StatefulWidget {
  const CurrencyConverterMaterialPage({super.key});

  @override
  _CurrencyConverterMaterialPageState createState() =>
      _CurrencyConverterMaterialPageState();
}

class _CurrencyConverterMaterialPageState
    extends State<CurrencyConverterMaterialPage> {
  double result = 0.0;
  final TextEditingController textEditingController = TextEditingController();
  String selectedCurrency = 'USD'; // Default selected currency

  // Conversion rates from INR to other currencies
  final Map<String, double> conversionRates = {
    'USD': 0.013,
    'EUR': 0.011,
    'GBP': 0.0098,
    'JPY': 1.45,
    'AUD': 0.019,
    // Add more currencies and their rates here
  };

  void convertCurrency() {
    setState(() {
      double rate = conversionRates[selectedCurrency] ?? 0.0;
      result = double.parse(textEditingController.text) * rate;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 0, 0, 0),
          elevation: 0,
          title: const Text(
            'Currency Converter',
            style: TextStyle(color: Colors.orange, fontSize: 20),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    result.toStringAsFixed(2),
                    style: const TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(width: 10),
                  DropdownButton<String>(
                    value: selectedCurrency,
                    dropdownColor: Colors.black,
                    style: const TextStyle(color: Colors.white),
                    items: conversionRates.keys.map((String key) {
                      return DropdownMenuItem<String>(
                        value: key,
                        child: Text(
                          key,
                          style: const TextStyle(color: Colors.orange),
                        ),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCurrency = newValue!;
                      });
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: TextField(
                  controller: textEditingController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Please enter the amount in INR',
                    labelStyle: TextStyle(color: Colors.orange),
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(11.0),
                      child: Text(
                        '\u20B9', // Unicode character for INR symbol
                        style: TextStyle(fontSize: 18, color: Colors.lightBlue),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                    ),
                  ),
                  cursorColor: Colors.orange,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: convertCurrency,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black),
                  foregroundColor: MaterialStateProperty.all(Colors.lightBlue),
                  elevation:
                      MaterialStateProperty.all(0), // Remove default elevation
                  overlayColor: MaterialStateProperty.resolveWith<Color>(
                    (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Colors.orange.withOpacity(
                            0.5); // Apply yellow overlay when pressed
                      }
                      return Colors
                          .transparent; // Transparent overlay otherwise
                    },
                  ),
                  shadowColor: MaterialStateProperty.all(
                      Colors.transparent), // Set shadow color to transparent
                ),
                child: const Text(
                  'Convert',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
