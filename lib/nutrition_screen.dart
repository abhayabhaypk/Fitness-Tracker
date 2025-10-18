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
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: const Text('Nutrition Tracker'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage('https://images.unsplash.com/photo-1498837167922-ddd27525d352?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          SingleChildScrollView(
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
        ],
      ),
    );
  }

  Widget _buildMacroChartCard() {
    return Card(
      color: Colors.black.withOpacity(0.5),
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
      color: Colors.black.withOpacity(0.5),
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
        _buildMealCard('Breakfast', 'https://images.unsplash.com/photo-1484723051597-62b8a788a660?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '450 kcal'),
        _buildMealCard('Lunch', 'https://images.unsplash.com/photo-1540189549336-e6e99c3679fe?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '750 kcal'),
        _buildMealCard('Dinner', 'https://images.unsplash.com/photo-1511690656952-34342bb7c2f2?q=80&w=1964&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', '800 kcal'),
      ],
    );
  }

  Widget _buildMealCard(String meal, String imageUrl, String calories) {
    return Card(
      color: Colors.black.withOpacity(0.4),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(meal, style: const TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold)),
        subtitle: Text(calories, style: const TextStyle(fontSize: 16, color: Colors.white70)),
        trailing: IconButton(
          icon: const Icon(Icons.add_circle_outline, color: Colors.white70, size: 30),
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
