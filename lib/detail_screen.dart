import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  final String name;
  final String image;
  final int active;
  final int critical;
  final int test;
  final int totalCases;
  final int totalDeaths;
  final int totalRecovered;

  const DetailScreen({
    Key? key,
    required this.name,
    required this.image,
    required this.active,
    required this.critical,
    required this.test,
    required this.totalCases,
    required this.totalDeaths,
    required this.totalRecovered,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  image,
                  height: 150,
                  width: 220,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Divider(
              thickness: 2,
              color: Colors.teal[200],
            ),
            const SizedBox(height: 16),
            _buildStatRow("Active Cases", active, Colors.orange),
            _buildStatRow("Critical Cases", critical, Colors.red),
            _buildStatRow("Tests Conducted", test, Colors.blue),
            _buildStatRow("Total Cases", totalCases, Colors.purple),
            _buildStatRow("Total Deaths", totalDeaths, Colors.black),
            _buildStatRow("Total Recovered", totalRecovered, Colors.green),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, int value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          Text(
            value.toString(),
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
