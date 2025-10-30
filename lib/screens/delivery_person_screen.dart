import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/delivery_provider.dart';
import '../models/delivery.dart';
import '../config/theme.dart';
import 'package:intl/intl.dart';

class DeliveryPersonScreen extends StatefulWidget {
  final String deliveryPersonName;

  const DeliveryPersonScreen({
    super.key,
    required this.deliveryPersonName,
  });

  @override
  State<DeliveryPersonScreen> createState() => _DeliveryPersonScreenState();
}

class _DeliveryPersonScreenState extends State<DeliveryPersonScreen> {
  bool _showPending = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<DeliveryProvider>();

    // Filtrar entregas solo del repartidor seleccionado
    final personDeliveries =
        provider.getDeliveriesForPerson(widget.deliveryPersonName);

    final displayDeliveries = _showPending
        ? personDeliveries
            .where((d) => d.status == DeliveryStatus.pending)
            .toList()
        : personDeliveries
            .where((d) => d.status == DeliveryStatus.completed)
            .toList();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Entregas de ${widget.deliveryPersonName}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              setState(() {});
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Segmented buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                color: theme.brightness == Brightness.light
                    ? Colors.grey[200]
                    : Colors.grey[800],
              ),
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  Expanded(
                    child: _SegmentButton(
                      text: 'Pendientes',
                      isSelected: _showPending,
                      onTap: () => setState(() => _showPending = true),
                    ),
                  ),
                  Expanded(
                    child: _SegmentButton(
                      text: 'Completadas',
                      isSelected: !_showPending,
                      onTap: () => setState(() => _showPending = false),
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Lista de entregas
          Expanded(
            child: displayDeliveries.isEmpty
                ? _EmptyState(isPending: _showPending)
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: displayDeliveries.length,
                    itemBuilder: (context, index) {
                      final delivery = displayDeliveries[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _DeliveryCard(
                          delivery: delivery,
                          onComplete: () {
                            provider.toggleDeliveryStatus(delivery.id);
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onTap;

  const _SegmentButton({
    required this.text,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected ? theme.colorScheme.surface : Colors.transparent,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: isSelected
                ? theme.textTheme.bodyMedium?.color
                : theme.textTheme.bodyMedium?.color?.withOpacity(0.5),
          ),
        ),
      ),
    );
  }
}

class _DeliveryCard extends StatelessWidget {
  final Delivery delivery;
  final VoidCallback onComplete;

  const _DeliveryCard({
    required this.delivery,
    required this.onComplete,
  });

  IconData _getCategoryIcon() {
    switch (delivery.category) {
      case 'restaurant':
        return Icons.restaurant_menu_rounded;
      case 'cafe':
        return Icons.local_cafe_rounded;
      case 'package':
        return Icons.inventory_2_rounded;
      default:
        return Icons.shopping_bag_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCompleted = delivery.status == DeliveryStatus.completed;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isCompleted
            ? theme.colorScheme.surface.withOpacity(0.7)
            : theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icono de categoría
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: isCompleted
                  ? AppTheme.primary.withOpacity(0.2)
                  : theme.brightness == Brightness.light
                      ? Colors.grey[100]
                      : Colors.grey[800],
            ),
            child: Icon(
              _getCategoryIcon(),
              color: isCompleted ? AppTheme.primary : theme.iconTheme.color,
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          // Información del pedido
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pedido #${delivery.id} - ${delivery.customerName}',
                  style: theme.textTheme.titleMedium?.copyWith(
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                    color: isCompleted
                        ? theme.textTheme.bodyMedium?.color?.withOpacity(0.5)
                        : null,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isCompleted && delivery.completedAt != null
                      ? 'Entregada a las ${DateFormat('h:mm a').format(delivery.completedAt!)}'
                      : 'Entrega antes de ${DateFormat('h:mm a').format(delivery.deadline)}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Asignado a: ${delivery.deliveryPerson}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    style: theme.textTheme.bodySmall?.copyWith(
                      color:
                          theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                      decoration:
                          isCompleted ? TextDecoration.lineThrough : null,
                    ),
                    children: [
                      TextSpan(text: 'De: ${delivery.fromLocation}\n'),
                      const TextSpan(text: 'A: '),
                      TextSpan(
                        text: delivery.toLocation,
                        style: const TextStyle(
                          color: AppTheme.accentBlue,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // Botón de completar
          GestureDetector(
            onTap: onComplete,
            child: Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted ? AppTheme.primary : Colors.grey[300],
                border: Border.all(
                  color: isCompleted ? AppTheme.primary : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.check_rounded,
                color: isCompleted ? Colors.white : Colors.grey[600],
                size: 28,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final bool isPending;

  const _EmptyState({required this.isPending});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.primary.withOpacity(0.1),
              ),
              child: Icon(
                Icons.pedal_bike_rounded,
                size: 64,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              isPending ? '¡Todo listo!' : 'Sin entregas completadas',
              style: theme.textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              isPending
                  ? 'No hay entregas pendientes en este momento. ¡Tómate un descanso!'
                  : 'Aún no has completado ninguna entrega hoy.',
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
