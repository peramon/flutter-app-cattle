import 'package:flutter/material.dart';
import 'counter_controller.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  final CounterController _controller = CounterController();

  // Mostrar mensaje cuando el contador no puede disminuir
  void _showSnackMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('No puedes ingresar números inferiores a 0'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  // Confirmación antes de reiniciar
  void _showDialogReboot() {
    if (_controller.canDecrement()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Reinicio'),
            content: const Text('¿Seguro que deseas setear el contador?'),
            actionsAlignment: MainAxisAlignment.spaceBetween,
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  setState(() => _controller.reset());
                  Navigator.of(context).pop();
                },
                child: const Text('Confirmar'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contador de Bovinos'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ingrese la cantidad de bovinos:',
              style: TextStyle(fontSize: 18.0),
            ),
            Text(
              '${_controller.counter}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/corral');
                  },
                  child: const Text('Ir al corral'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/dashboard');
                  },
                  child: const Text('Ir al Dashboard'),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() => _controller.increment());
            },
            tooltip: 'Incrementar',
            heroTag: 'increment',
            child: const Icon(Icons.touch_app),
          ),
          const SizedBox(width: 16),
          FloatingActionButton(
            onPressed: () {
              if (_controller.canDecrement()) {
                setState(() => _controller.decrement());
              } else {
                _showSnackMessage(context);
              }
            },
            tooltip: 'Decrementar',
            heroTag: 'decrement',
            child: const Icon(Icons.remove_circle),
          ),
          const SizedBox(width: 24),
          _controller.canDecrement()
              ? FloatingActionButton(
                  onPressed: _showDialogReboot,
                  tooltip: 'Reiniciar',
                  heroTag: 'reboot',
                  child: const Icon(Icons.restart_alt),
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}
