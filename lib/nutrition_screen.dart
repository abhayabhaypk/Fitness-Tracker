import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class NutritionScreen extends StatefulWidget {
  const NutritionScreen({super.key});

  @override
  _NutritionScreenState createState() => _NutritionScreenState();
}

class _NutritionScreenState extends State<NutritionScreen> {
  // Mock data for nutrition
  final Map<String, double> _nutritionData = {
    'Protein': 25,
    'Carbs': 50,
    'Fat': 25,
  };

  final double _totalCalories = 2000;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition Tracker'),
        backgroundColor: const Color(0xFF1F1F1F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildMacroChartCard(),
            const SizedBox(height: 20),
            _buildCalorieSummaryCard(),
            const SizedBox(height: 20),
            _buildMealLoggingSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildMacroChartCard() {
    return Card(
      color: const Color(0xFF1F1F1F),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Text(
              'Today\'s Macronutrients',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 200,
              child: PieChart(
                PieChartData(
                  sections: _getChartSections(),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 2,
                  centerSpaceRadius: 50,
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {},
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildLegend(),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _getChartSections() {
    final List<Color> colors = [
      const Color(0xFFBB86FC), // Protein
      const Color(0xFF03DAC6), // Carbs
      Colors.orange,          // Fat
    ];
    int i = 0;
    return _nutritionData.entries.map((entry) {
      final color = colors[i++];
      return PieChartSectionData(
        color: color,
        value: entry.value,
        title: '${entry.value.toStringAsFixed(0)}%',
        radius: 60,
        titleStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      );
    }).toList();
  }

  Widget _buildLegend() {
    final List<Color> colors = [
      const Color(0xFFBB86FC),
      const Color(0xFF03DAC6),
      Colors.orange,
    ];
    int i = 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _nutritionData.keys.map((key) {
        final color = colors[i++];
        return Row(
          children: <Widget>[
            Container(width: 16, height: 16, color: color),
            const SizedBox(width: 8),
            Text(key, style: const TextStyle(fontSize: 16, color: Colors.white)),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildCalorieSummaryCard() {
    return Card(
      color: const Color(0xFF1F1F1F),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Total Calories',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            Text(
              '${_totalCalories.toStringAsFixed(0)} kcal',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF03DAC6)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMealLoggingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Log Your Meals',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
        ),
        const SizedBox(height: 10),
        _buildMealCard('Breakfast', Icons.free_breakfast, '450 kcal'),
        _buildMealCard('Lunch', Icons.lunch_dining, '750 kcal'),
        _buildMealCard('Dinner', Icons.dinner_dining, '800 kcal'),
      ],
    );
  }

  Widget _buildMealCard(String meal, IconData icon, String calories) {
    return Card(
      color: const Color(0xFF2C2C2C),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFBB86FC), size: 40),
        title: Text(meal, style: const TextStyle(fontSize: 20, color: Colors.white)),
        subtitle: Text(calories, style: const TextStyle(fontSize: 16, color: Colors.white70)),
        trailing: IconButton(
          icon: const Icon(Icons.add_circle_outline, color: Colors.white70),
          onPressed: () {
            // Placeholder for adding food items
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Add food to $meal')),
            );
          },
        ),
      ),
    );
  }
}
