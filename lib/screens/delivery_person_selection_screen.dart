import 'package:flutter/material.dart';
import 'delivery_person_screen.dart';

class DeliveryPersonSelectionScreen extends StatefulWidget {
  const DeliveryPersonSelectionScreen({super.key});

  @override
  State<DeliveryPersonSelectionScreen> createState() =>
      _DeliveryPersonSelectionScreenState();
}

class _DeliveryPersonSelectionScreenState
    extends State<DeliveryPersonSelectionScreen> with TickerProviderStateMixin {
  // Los tres repartidores disponibles
  static const List<String> deliveryPersons = [
    'Diego López',
    'Juan Ballesteros',
    'Luis Rodríguez',
  ];

  late AnimationController _headerAnimationController;
  late Animation<double> _headerFadeAnimation;
  late Animation<Offset> _headerSlideAnimation;

  @override
  void initState() {
    super.initState();
    _headerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _headerFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _headerAnimationController, curve: Curves.easeInOut),
    );

    _headerSlideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.5), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _headerAnimationController, curve: Curves.easeOutCubic),
    );

    _headerAnimationController.forward();
  }

  @override
  void dispose() {
    _headerAnimationController.dispose();
    super.dispose();
  }

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
            // Header animado
            SlideTransition(
              position: _headerSlideAnimation,
              child: FadeTransition(
                opacity: _headerFadeAnimation,
                child: Column(
                  children: [
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
                        color:
                            theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            // Lista de repartidores con animación escalonada
            Expanded(
              child: ListView.builder(
                itemCount: deliveryPersons.length,
                itemBuilder: (context, index) {
                  final person = deliveryPersons[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _DeliveryPersonCard(
                      name: person,
                      index: index,
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

class _DeliveryPersonCard extends StatefulWidget {
  final String name;
  final int index;
  final VoidCallback onTap;

  const _DeliveryPersonCard({
    required this.name,
    required this.index,
    required this.onTap,
  });

  @override
  State<_DeliveryPersonCard> createState() => _DeliveryPersonCardState();
}

class _DeliveryPersonCardState extends State<_DeliveryPersonCard>
    with TickerProviderStateMixin {
  late AnimationController _entryAnimationController;
  late AnimationController _hoverAnimationController;
  late Animation<double> _entryFadeAnimation;
  late Animation<Offset> _entrySlideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Animación de entrada escalonada
    _entryAnimationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _entryFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _entryAnimationController, curve: Curves.easeInOut),
    );

    _entrySlideAnimation =
        Tween<Offset>(begin: const Offset(0.5, 0), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _entryAnimationController, curve: Curves.easeOutCubic),
    );

    // Animación de hover
    _hoverAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
          parent: _hoverAnimationController, curve: Curves.easeInOut),
    );

    // Iniciar animación de entrada con delay escalonado
    Future.delayed(Duration(milliseconds: widget.index * 150), () {
      if (mounted) {
        _entryAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _entryAnimationController.dispose();
    _hoverAnimationController.dispose();
    super.dispose();
  }

  void _onHoverEnter() {
    _hoverAnimationController.forward();
  }

  void _onHoverExit() {
    _hoverAnimationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SlideTransition(
      position: _entrySlideAnimation,
      child: FadeTransition(
        opacity: _entryFadeAnimation,
        child: ScaleTransition(
          scale: _scaleAnimation,
          child: MouseRegion(
            onEnter: (_) => _onHoverEnter(),
            onExit: (_) => _onHoverExit(),
            child: GestureDetector(
              onTap: widget.onTap,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
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
                      color: _hoverAnimationController.isAnimating
                          ? theme.colorScheme.primary.withOpacity(0.2)
                          : Colors.black.withOpacity(0.05),
                      blurRadius:
                          _hoverAnimationController.isAnimating ? 12 : 4,
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
                        widget.name,
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
            ),
          ),
        ),
      ),
    );
  }
}
