import 'package:counter_clicks/models/cow.dart';
import 'package:counter_clicks/providers/cattle_provider.dart';
import 'package:counter_clicks/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Segunda pantalla: Corral, permite crear info básica de bovinos.
class CorralScreen extends StatefulWidget {
  const CorralScreen({super.key});

  @override
  State<CorralScreen> createState() => _CorralScreenState();
}

class _CorralScreenState extends State<CorralScreen> {
  final TextEditingController _breedController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();

  // List<Cow> cattleList = [];

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // cattleList = mockCattle;
    // Espera a que se construya el contexto antes de usar Provider
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      bool added = await Provider.of<CattleProvider>(
        context,
        listen: false,
      ).uploadCowAutomatically();

      if (!mounted) return;

      if (added) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Se han añadido 3 toros automáticamente'),
            backgroundColor: Colors.green,
          ),
        );
      }
    });
  }

  void _showAddCowDialog() {
    // Variables locales al dialogo
    // String selectedBreed = 'Holstein';
    String? selectedBreed;
    // String selectedStatus = 'Saludable';
    String? selectedStatus;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Agregar Bovino'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Texfields aqui'
                // TextField(
                //   controller: _breedController,
                //   decoration: const InputDecoration(labelText: 'Raza'),
                // ),
                // Raza (Dropdown)
                DropdownButtonFormField<String>(
                  value: selectedBreed,
                  decoration: const InputDecoration(labelText: 'Raza'),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('Seleccione'),
                    ),
                    ...['Holstein', 'Normando', 'Charolais'].map(
                      (breed) =>
                          DropdownMenuItem(value: breed, child: Text(breed)),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedBreed = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor seleccione una raza';
                    }
                    return null;
                  },
                ),
                // TextField(
                //   controller: _weightController,
                //   decoration: const InputDecoration(labelText: 'Peso'),
                // ),
                // Peso
                TextFormField(
                  controller: _weightController,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  decoration: const InputDecoration(
                    labelText: 'Peso',
                    suffixText: 'kg',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo requerido';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Debe ser un número';
                    }
                    if (double.tryParse(value) == 0) {
                      return 'Debe ser mayor a 0';
                    }
                    return null;
                  },
                ),
                // TextField(
                //   controller: _ageController,
                //   decoration: InputDecoration(labelText: 'Edad'),
                // ),
                // Edad
                TextFormField(
                  controller: _ageController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Edad',
                    suffixText: 'meses',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo requerido';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Debe ser un número entero';
                    }
                    if (double.tryParse(value) == 0) {
                      return 'Debe ser mayor a 0';
                    }
                    return null;
                  },
                ),
                // TextField(
                //   controller: _statusController,
                //   decoration: InputDecoration(labelText: 'Estado'),
                // ),
                DropdownButtonFormField<String>(
                  value: selectedStatus,
                  decoration: const InputDecoration(labelText: 'Estado'),
                  items: [
                    const DropdownMenuItem(
                      value: null,
                      child: Text('Selecciones'),
                    ),
                    ...['Saludable', 'Enfermo'].map(
                      (status) => (DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      )),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedStatus = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) return 'Debe seleccionar un estado';
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                _cleaningForm();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                if (!_formKey.currentState!.validate()) {
                  // Si hay errores, no hace nada (los campos se marcan en rojo automáticamente)
                  return;
                }
                // imprimir datos
                // TODO: reempplazar por logging los prints
                print('Raza: ${_breedController.text}');
                print('Peso: ${_weightController.text}');
                print('Edad: ${_ageController.text}');
                print('Estado: ${_statusController.text}');
                // Campos completados
                // if (selectedBreed.isEmpty ||
                //     _weightController.text.isEmpty ||
                //     _ageController.text.isEmpty ||
                //     selectedStatus.isEmpty) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(
                //       content: Text('Por favor, completa todos los campos'),
                //       backgroundColor: Colors.red,
                //     ),
                //   );
                //   return;
                // }
                // Validar que el peso sea un número válido
                // final weight = double.tryParse(_weightController.text);
                // if (weight == null && weight != 0.0) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(
                //       content: Text(
                //         'El peso deber ser un número valido mayor a cero',
                //       ),
                //       backgroundColor: Colors.red,
                //     ),
                //   );
                //   return;
                // }

                // Validar que la edad sea un entero
                // final age = int.tryParse(_ageController.text);
                // if (age == null) {
                //   ScaffoldMessenger.of(context).showSnackBar(
                //     const SnackBar(
                //       content: Text(
                //         'La edad debe ser un número entero mayor a cero.',
                //       ),
                //       backgroundColor: Colors.red,
                //     ),
                //   );
                //   return;
                // }
                Provider.of<CattleProvider>(context, listen: false).addCow(
                  Cow(
                    breed: selectedBreed!,
                    weight: _weightController.text,
                    age: _ageController.text,
                    status: selectedStatus!,
                  ),
                );
                // setState(() {
                //   cattleList.add({
                //     'breed': selectedBreed!,
                //     'weight': _weightController.text,
                //     'age': _ageController.text,
                //     'status': selectedStatus!,
                //   });
                // });
                _cleaningForm();
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _cleaningForm() {
    _breedController.clear();
    _weightController.clear();
    _ageController.clear();
    _statusController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // Lista de bovinos

    return Scaffold(
      appBar: AppBar(title: const Text('Corral')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 8, // Espacio horizontal entre columnas
                mainAxisSpacing: 8, // Espacio vertical entre filas
                children: [
                  // const Text('Bienvenido al corral!'),
                  // const SizedBox(height: 16),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.pop(context);
                  //   },
                  //   child: const Text('Volver'),
                  // ),
                  // Cards de bovinos
                  // ...cattleList.map(
                  ...Provider.of<CattleProvider>(context).cattle.map(
                    (cow) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              cow.breed!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Peso: ${cow.weight} kg'),
                            Text('Edad: ${cow.age} meses'),
                            Text('Estado: ${cow.status}'),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // Card para agregar nuevos bovinos
                  Card(
                    color: Colors.cyan.shade100,
                    child: InkWell(
                      onTap: _showAddCowDialog, // función que vamos a crear
                      child: const Center(child: Icon(Icons.add, size: 40)),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.dashboard);
              },
              icon: const Icon(Icons.dashboard),
              label: const Text('Ir al Dashboard'),
            ),
          ],
        ),
      ),
    );
  }
}
