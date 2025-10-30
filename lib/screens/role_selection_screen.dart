import 'package:flutter/material.dart';
import 'delivery_person_selection_screen.dart';
import 'supervisor_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _titleController;
  late AnimationController _deliveryCardController;
  late AnimationController _supervisorCardController;

  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<Offset> _titleSlide;
  late Animation<double> _titleOpacity;
  late Animation<Offset> _deliveryCardSlide;
  late Animation<double> _deliveryCardOpacity;
  late Animation<Offset> _supervisorCardSlide;
  late Animation<double> _supervisorCardOpacity;

  @override
  void initState() {
    super.initState();

    // Animación del logo
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _logoScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeIn),
    );

    // Animación del título
    _titleController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _titleSlide =
        Tween<Offset>(begin: const Offset(0, -0.5), end: Offset.zero).animate(
      CurvedAnimation(parent: _titleController, curve: Curves.easeOutCubic),
    );
    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _titleController, curve: Curves.easeIn),
    );

    // Animación de la tarjeta de repartidor
    _deliveryCardController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _deliveryCardSlide =
        Tween<Offset>(begin: const Offset(-1.0, 0), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _deliveryCardController, curve: Curves.easeOutCubic),
    );
    _deliveryCardOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _deliveryCardController, curve: Curves.easeIn),
    );

    // Animación de la tarjeta de supervisor
    _supervisorCardController = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _supervisorCardSlide =
        Tween<Offset>(begin: const Offset(1.0, 0), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _supervisorCardController, curve: Curves.easeOutCubic),
    );
    _supervisorCardOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _supervisorCardController, curve: Curves.easeIn),
    );

    // Iniciar animaciones en cascada
    _logoController.forward().then((_) {
      _titleController.forward().then((_) {
        _deliveryCardController.forward();
        Future.delayed(const Duration(milliseconds: 150), () {
          _supervisorCardController.forward();
        });
      });
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _titleController.dispose();
    _deliveryCardController.dispose();
    _supervisorCardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            children: [
              const SizedBox(height: 32),
              // Logo con animación de escala y opacidad
              ScaleTransition(
                scale: _logoScale,
                child: FadeTransition(
                  opacity: _logoOpacity,
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: theme.colorScheme.primary.withOpacity(0.1),
                    ),
                    child: Icon(
                      Icons.local_shipping_rounded,
                      size: 48,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Título con animación de deslizamiento
              SlideTransition(
                position: _titleSlide,
                child: FadeTransition(
                  opacity: _titleOpacity,
                  child: Column(
                    children: [
                      Text(
                        'GreenGo Logistics',
                        style: theme.textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Entregas urbanas sostenibles, impulsadas por ti.',
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.textTheme.bodyMedium?.color
                              ?.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              // Título de selección
              Text(
                'Selecciona tu rol',
                style: theme.textTheme.titleLarge,
              ),
              const SizedBox(height: 24),
              // Botón Repartidor con animación
              SlideTransition(
                position: _deliveryCardSlide,
                child: FadeTransition(
                  opacity: _deliveryCardOpacity,
                  child: _RoleCard(
                    icon: Icons.pedal_bike_rounded,
                    title: 'Repartidor',
                    description:
                        'Gestiona tus entregas y consulta tus ganancias.',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const DeliveryPersonSelectionScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Botón Supervisor con animación
              SlideTransition(
                position: _supervisorCardSlide,
                child: FadeTransition(
                  opacity: _supervisorCardOpacity,
                  child: _RoleCard(
                    icon: Icons.analytics_rounded,
                    title: 'Supervisor',
                    description:
                        'Supervisa todas las entregas en vivo y gestiona el equipo.',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SupervisorScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final VoidCallback onTap;

  const _RoleCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: theme.brightness == Brightness.light
                ? const Color(0xFFE0E0E0)
                : const Color(0xFF424242),
          ),
          color: theme.colorScheme.surface,
        ),
        child: Column(
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary.withOpacity(0.1),
              ),
              child: Icon(
                icon,
                size: 32,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.textTheme.bodySmall?.color?.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
