import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const GDPPredictionApp());
}

class GDPPredictionApp extends StatelessWidget {
  const GDPPredictionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GDP Growth Predictor',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const PredictionScreen(),
    );
  }
}

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _countryController = TextEditingController();
  final _consumptionController = TextEditingController();
  final _capitalController = TextEditingController();
  final _exportsController = TextEditingController();
  final _importsController = TextEditingController();
  final _fiscalController = TextEditingController();
  
  bool _isLoading = false;
  String? _prediction;
  String? _error;

  // API endpoint 
  final String apiUrl = 'https://api-tyky.onrender.com/predict_gdp_growth';

  Future<void> _makePrediction() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
      _error = null;
      _prediction = null;
    });

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'Country': _countryController.text,
          'Final consumption expenditure (% of GDP)': double.parse(_consumptionController.text),
          'Gross capital formation (% of GDP)': double.parse(_capitalController.text),
          'Exports of goods and services (% of GDP)': double.parse(_exportsController.text),
          'Imports of goods and services (% of GDP)': double.parse(_importsController.text),
          'Central government, Fiscal Balance (% of GDP)': double.parse(_fiscalController.text),
        }),
      );

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        setState(() {
          _prediction = result.toString();
        });
      } else {
        setState(() {
          _error = 'Error: ${response.statusCode} - ${response.body}';
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Network error: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('African GDP Growth Predictor'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Enter Economic Indicators',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              
              TextFormField(
                controller: _countryController,
                decoration: const InputDecoration(
                  labelText: 'Country',
                  border: OutlineInputBorder(),
                  hintText: 'e.g., Nigeria, Malawi',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a country name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _consumptionController,
                decoration: const InputDecoration(
                  labelText: 'Final Consumption Expenditure (% of GDP)',
                  border: OutlineInputBorder(),
                  hintText: '50.0 - 150.0',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  final num = double.tryParse(value);
                  if (num == null || num <= 50 || num > 150) {
                    return 'Value must be between 50.0 and 150.0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _capitalController,
                decoration: const InputDecoration(
                  labelText: 'Gross Capital Formation (% of GDP)',
                  border: OutlineInputBorder(),
                  hintText: '0.0 - 50.0',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  final num = double.tryParse(value);
                  if (num == null || num <= 0 || num > 50) {
                    return 'Value must be between 0.0 and 50.0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _exportsController,
                decoration: const InputDecoration(
                  labelText: 'Exports of Goods and Services (% of GDP)',
                  border: OutlineInputBorder(),
                  hintText: '0.0 - 150.0',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  final num = double.tryParse(value);
                  if (num == null || num < 0 || num > 150) {
                    return 'Value must be between 0.0 and 150.0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _importsController,
                decoration: const InputDecoration(
                  labelText: 'Imports of Goods and Services (% of GDP)',
                  border: OutlineInputBorder(),
                  hintText: '0.0 - 150.0',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  final num = double.tryParse(value);
                  if (num == null || num < 0 || num > 150) {
                    return 'Value must be between 0.0 and 150.0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              
              TextFormField(
                controller: _fiscalController,
                decoration: const InputDecoration(
                  labelText: 'Central Government Fiscal Balance (% of GDP)',
                  border: OutlineInputBorder(),
                  hintText: '-20.0 - 10.0',
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a value';
                  }
                  final num = double.tryParse(value);
                  if (num == null || num < -20 || num > 10) {
                    return 'Value must be between -20.0 and 10.0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              
              ElevatedButton(
                onPressed: _isLoading ? null : _makePrediction,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : const Text('Predict GDP Growth', style: TextStyle(fontSize: 16)),
              ),
              
              if (_prediction != null) ...[
                const SizedBox(height: 24),
                Card(
                  color: Colors.green.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Icon(Icons.trending_up, color: Colors.green, size: 48),
                        const SizedBox(height: 8),
                        const Text(
                          'Predicted GDP Growth Rate',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${double.parse(_prediction!).toStringAsFixed(2)}%',
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              
              if (_error != null) ...[
                const SizedBox(height: 24),
                Card(
                  color: Colors.red.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        const Icon(Icons.error, color: Colors.red, size: 48),
                        const SizedBox(height: 8),
                        const Text(
                          'Error',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _error!,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _countryController.dispose();
    _consumptionController.dispose();
    _capitalController.dispose();
    _exportsController.dispose();
    _importsController.dispose();
    _fiscalController.dispose();
    super.dispose();
  }
}