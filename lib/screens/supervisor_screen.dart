import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/delivery_provider.dart';
import '../models/delivery.dart';
import '../config/theme.dart';

enum FilterType {
  all,
  pending,
  overdue,
  completed,
}

class SupervisorScreen extends StatefulWidget {
  const SupervisorScreen({super.key});

  @override
  State<SupervisorScreen> createState() => _SupervisorScreenState();
}

class _SupervisorScreenState extends State<SupervisorScreen> {
  FilterType _selectedFilter = FilterType.all;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<DeliveryProvider>();

    List<Delivery> filteredDeliveries;
    switch (_selectedFilter) {
      case FilterType.pending:
        filteredDeliveries =
            provider.pendingDeliveries.where((d) => !d.isOverdue).toList();
        break;
      case FilterType.overdue:
        filteredDeliveries = provider.overdueDeliveries;
        break;
      case FilterType.completed:
        filteredDeliveries = provider.completedDeliveries;
        break;
      case FilterType.all:
      default:
        filteredDeliveries = provider.allDeliveries;
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Entregas en vivo'),
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
          // Stats Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final isSmallScreen = constraints.maxWidth < 400;
                final cardWidth = isSmallScreen
                    ? (constraints.maxWidth - 36) / 2
                    : (constraints.maxWidth - 48) / 4;

                return Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: [
                    SizedBox(
                      width: cardWidth,
                      child: _StatCard(
                        label: 'Total',
                        value: provider.totalDeliveries.toString(),
                        color: theme.textTheme.bodyMedium?.color,
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: _StatCard(
                        label: 'Pendientes',
                        value: provider.pendingCount.toString(),
                        color: AppTheme.accent,
                        borderColor: AppTheme.accent,
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: _StatCard(
                        label: 'Atrasadas',
                        value: provider.overdueCount.toString(),
                        color: AppTheme.alert,
                        borderColor: AppTheme.alert,
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: _StatCard(
                        label: 'Completadas',
                        value: provider.completedCount.toString(),
                        color: AppTheme.primary,
                        borderColor: AppTheme.primary,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          // Progress Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Progreso de entregas',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: AppTheme.primary.withOpacity(0.1),
                      ),
                      child: Text(
                        '${provider.completionPercentage.toStringAsFixed(0)}%',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: AppTheme.primary,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: provider.completionPercentage / 100,
                    minHeight: 8,
                    backgroundColor: theme.brightness == Brightness.light
                        ? Colors.grey[200]
                        : Colors.grey[800],
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppTheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '${provider.completedCount} de ${provider.totalDeliveries} entregas completadas',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          // Filter chips
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _FilterChip(
                  label: 'Todos',
                  isSelected: _selectedFilter == FilterType.all,
                  onTap: () => setState(() => _selectedFilter = FilterType.all),
                ),
                const SizedBox(width: 12),
                _FilterChip(
                  label: 'Pendientes',
                  isSelected: _selectedFilter == FilterType.pending,
                  indicatorColor: AppTheme.accent,
                  onTap: () =>
                      setState(() => _selectedFilter = FilterType.pending),
                ),
                const SizedBox(width: 12),
                _FilterChip(
                  label: 'Atrasadas',
                  isSelected: _selectedFilter == FilterType.overdue,
                  indicatorColor: AppTheme.alert,
                  onTap: () =>
                      setState(() => _selectedFilter = FilterType.overdue),
                ),
                const SizedBox(width: 12),
                _FilterChip(
                  label: 'Completadas',
                  isSelected: _selectedFilter == FilterType.completed,
                  indicatorColor: AppTheme.primary,
                  onTap: () =>
                      setState(() => _selectedFilter = FilterType.completed),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // Delivery list
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredDeliveries.length,
              itemBuilder: (context, index) {
                final delivery = filteredDeliveries[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _SupervisorDeliveryCard(delivery: delivery),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color? color;
  final Color? borderColor;

  const _StatCard({
    required this.label,
    required this.value,
    this.color,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.surface,
        border: Border.all(
          color: borderColor ??
              (theme.brightness == Brightness.light
                  ? const Color(0xFFE0E0E0)
                  : const Color(0xFF424242)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: color?.withOpacity(0.8) ??
                  theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Color? indicatorColor;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    this.indicatorColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isSelected
              ? theme.colorScheme.primary
              : theme.colorScheme.surface,
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : (theme.brightness == Brightness.light
                    ? const Color(0xFFE0E0E0)
                    : const Color(0xFF424242)),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (indicatorColor != null && !isSelected) ...[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: indicatorColor,
                ),
              ),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SupervisorDeliveryCard extends StatelessWidget {
  final Delivery delivery;

  const _SupervisorDeliveryCard({required this.delivery});

  Color _getStatusColor() {
    if (delivery.status == DeliveryStatus.completed) {
      return AppTheme.primary;
    } else if (delivery.isOverdue) {
      return AppTheme.alert;
    } else {
      return AppTheme.accent;
    }
  }

  IconData _getStatusIcon() {
    if (delivery.status == DeliveryStatus.completed) {
      return Icons.check_circle_rounded;
    } else if (delivery.isOverdue) {
      return Icons.warning_rounded;
    } else {
      return Icons.schedule_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = _getStatusColor();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: theme.colorScheme.surface,
        border: Border.all(
          color: statusColor.withOpacity(0.3),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Indicador de color a la izquierda
            Container(
              width: 4,
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 12),
            // Icono de estado
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: statusColor.withOpacity(0.1),
              ),
              child: Icon(
                _getStatusIcon(),
                color: statusColor,
                size: 28,
              ),
            ),
            const SizedBox(width: 12),
            // Información del pedido
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Pedido #${delivery.id}',
                    style: theme.textTheme.titleMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Asignado a: ${delivery.deliveryPerson}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color:
                          theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    delivery.toLocation,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color:
                          theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Estado
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  delivery.statusText,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
