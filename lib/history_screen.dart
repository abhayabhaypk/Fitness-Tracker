
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class HistoryScreen extends StatelessWidget {
  final Map<String, int> stepHistory;

  const HistoryScreen({super.key, required this.stepHistory});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Activity History'),
        backgroundColor: const Color(0xFF2C2C2C),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            alignment: BarChartAlignment.spaceAround,
            maxY: 20000, // Adjust this based on expected max steps
            barTouchData: BarTouchData(
              enabled: false,
            ),
            titlesData: FlTitlesData(
              show: true,
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    final titles = stepHistory.keys.toList();
                    if (value.toInt() < titles.length) {
                      return Text(titles[value.toInt()], style: const TextStyle(color: Colors.white, fontSize: 10));
                    }
                    return Container();
                  },
                  reservedSize: 16,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (double value, TitleMeta meta) {
                    if (value % 5000 == 0) {
                      return Text(value.toInt().toString(), style: const TextStyle(color: Colors.white, fontSize: 10));
                    }
                    return Container();
                  },
                  reservedSize: 28,
                ),
              ),
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(
              show: false,
            ),
            barGroups: stepHistory.entries.map((entry) {
              final index = stepHistory.keys.toList().indexOf(entry.key);
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: entry.value.toDouble(),
                    color: Colors.lightBlueAccent,
                    width: 16,
                  )
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
