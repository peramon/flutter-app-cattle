import 'package:counter_clicks/providers/cattle_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'routes/app_routes.dart';

void main() {
  // runApp(const LivestockApp());
  runApp(AppProviders(child: const LivestockApp()));
}

// Widget principal de la aplicación
class LivestockApp extends StatelessWidget {
  const LivestockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Título de la aplicación (visible en algunas plataformas)
      theme: ThemeData(
        // Define el esquema de colores general de la app
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan.shade400),
      ),
      // Pantalla principal de la aplicación
      // Ruta que se mostrará al iniciar la app
      initialRoute: AppRoutes.home,
      // Mapeo de rutas: nombre de ruta -> pantalla que se debe mostrar
      routes: AppRoutes.routes,
    );
  }
}

// Pantalla principal, de tipo Stateful (puede cambiar de estado)
class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  // Título que será mostrado en la AppBar
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior con el título
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      // Cuerpo de la pantalla
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Texto descriptivo
            // TODO: Crear tema(tipografia, colores)
            const Text('Bienvenido:', style: TextStyle(fontSize: 18.0)),
            // Muestra el número de veces presionador
            // Page de Corral
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.corral);
                  },
                  child: const Text('Ir al corral'),
                ),
                const SizedBox(width: 16),
                // Page de Dashboard
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.dashboard);
                  },
                  child: const Text('Ir al Dashboard'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CattleProvider()),
        // Aquí puedes seguir agregando más providers si necesitas en el futuro
      ],
      child: child,
    );
  }
}
