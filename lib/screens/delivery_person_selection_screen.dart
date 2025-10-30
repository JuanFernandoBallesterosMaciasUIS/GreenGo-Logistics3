import 'package:flutter/material.dart';
import 'delivery_person_screen.dart';

class DeliveryPersonSelectionScreen extends StatefulWidget {
  const DeliveryPersonSelectionScreen({super.key});

  @override
  State<DeliveryPersonSelectionScreen> createState() =>
      _DeliveryPersonSelectionScreenState();
}

class _DeliveryPersonSelectionScreenState
    extends State<DeliveryPersonSelectionScreen> {
  // Los tres repartidores disponibles
  static const List<String> deliveryPersons = [
    'Diego López',
    'Juan Ballesteros',
    'Luis Rodríguez',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Selecciona tu perfil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const SizedBox(height: 32),
            // Icono
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: theme.colorScheme.primary.withOpacity(0.1),
              ),
              child: Icon(
                Icons.pedal_bike_rounded,
                size: 48,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '¿Quién eres?',
              style: theme.textTheme.headlineMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Selecciona tu nombre para ver tus entregas',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 40),
            // Lista de repartidores
            Expanded(
              child: ListView.builder(
                itemCount: deliveryPersons.length,
                itemBuilder: (context, index) {
                  final person = deliveryPersons[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _DeliveryPersonCard(
                      name: person,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DeliveryPersonScreen(
                              deliveryPersonName: person,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DeliveryPersonCard extends StatelessWidget {
  final String name;
  final VoidCallback onTap;

  const _DeliveryPersonCard({
    required this.name,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: theme.colorScheme.surface,
          border: Border.all(
            color: theme.brightness == Brightness.light
                ? const Color(0xFFE0E0E0)
                : const Color(0xFF424242),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary.withOpacity(0.2),
              ),
              child: Icon(
                Icons.person_rounded,
                color: theme.colorScheme.primary,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                name,
                style: theme.textTheme.titleMedium,
              ),
            ),
            Icon(
              Icons.arrow_forward_rounded,
              color: theme.colorScheme.primary,
            ),
          ],
        ),
      ),
    );
  }
}
