import 'package:counter_clicks/providers/cattle_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:counter_clicks/data/mock_data_cattle.dart';

class DashboardScreen extends StatelessWidget {
  // final List<Cow> catleList;

  // const DashboardScreen({super.key, required this.catleList});
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Contar el número total de animales
    // int total = catleList.length;

    // // Contar cuántos hay por raza
    // Map<String, int> breedCounts = {};
    // for (var cow in catleList) {
    //   String breed = cow.breed;
    //   breedCounts[breed] = (breedCounts[breed] ?? 0) + 1;
    // }

    return Scaffold(
      appBar: AppBar(title: const Text('DASHBOARD')),
      body: Center(
        child: Consumer<CattleProvider>(
          builder: (context, provider, child) {
            final cattleList = provider.cattle;

            // Contar el número total de animales
            int total = cattleList.length;

            // Contar por raza
            Map<String, int> breedCounts = {};
            for (var cow in cattleList) {
              String breed = cow.breed;
              breedCounts[breed] = (breedCounts[breed] ?? 0) + 1;
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Bienvenido al dashboard'),
                const SizedBox(height: 16),
                Text(
                  'Número total de animales: $total',
                  style: const TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Cantidad por raza:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                ...breedCounts.entries.map(
                  (entry) => Text(
                    '${entry.key}: ${entry.value}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
