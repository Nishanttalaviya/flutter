import 'package:flutter/material.dart';

class BMIC extends StatefulWidget {
  BMIC({super.key});

  @override
  State<BMIC> createState() => _BMICState();
}

class _BMICState extends State<BMIC> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  double result = 0;
  String message = '';

  @override
  void dispose() {
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  void calculateBMI() {
    final heightText = _heightController.text;
    final weightText = _weightController.text;

    if (heightText.isNotEmpty && weightText.isNotEmpty) {
      final height = double.tryParse(heightText);
      final weight = double.tryParse(weightText);

      if (height != null && weight != null) {
        final heightInMeters = height / 100; // Convert height to meters
        setState(() {
          result = weight / (heightInMeters * heightInMeters);
          message = 'Your BMI is: ${result.toStringAsFixed(2)}';
        });
      } else {
        setState(() {
          message = 'Please enter valid numbers';
        });
      }
    } else {
      setState(() {
        message = 'Please fill in both fields';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Calculator'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              'assets/bmi.jpg', // Path to your image
              height: 175.0,
              width: 175.0,
              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                return const Text('Image not found', style: TextStyle(fontSize: 16));
              },
            ),
            const SizedBox(height: 10),
            inputField('Enter the Height in centimeters', _heightController),
            const SizedBox(height: 10),
            inputField('Enter the Weight in kilograms', _weightController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateBMI,
              child: const Text('Calculate BMI'),
            ),
            const SizedBox(height: 20),
            Text(
              message,
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }

  Container inputField(String hintText, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50.0,),
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey),
            ),
            labelText: hintText,
            hintText: hintText,
          ),
          keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}
