
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nutrition Tracker'),
        backgroundColor: const Color(0xFF2C2C2C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              'Today\'s Macronutrients',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: _getChartSections(),
                  borderData: FlBorderData(show: false),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
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
    final List<PieChartSectionData> sections = [];
    final List<Color> colors = [Colors.blue, Colors.green, Colors.red];
    int i = 0;
    _nutritionData.forEach((key, value) {
      sections.add(
        PieChartSectionData(
          color: colors[i],
          value: value,
          title: '${value.toInt()}%',
          radius: 100,
          titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      );
      i++;
    });
    return sections;
  }

  Widget _buildLegend() {
    final List<Widget> legends = [];
    final List<Color> colors = [Colors.blue, Colors.green, Colors.red];
    int i = 0;
    _nutritionData.forEach((key, value) {
      legends.add(
        Row(
          children: [
            Container(
              width: 20,
              height: 20,
              color: colors[i],
            ),
            const SizedBox(width: 10),
            Text(key, style: const TextStyle(fontSize: 18, color: Colors.white)),
          ],
        ),
      );
      legends.add(const SizedBox(height: 10));
      i++;
    });
    return Column(children: legends);
  }
}
