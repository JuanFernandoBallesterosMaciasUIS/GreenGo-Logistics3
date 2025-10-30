import 'package:flutter/material.dart';
import '../models/delivery.dart';

class DeliveryProvider with ChangeNotifier {
  final List<Delivery> _deliveries = [
    Delivery(
      id: 'GG-12345',
      customerName: 'María García',
      deliveryPerson: 'Carlos López',
      fromLocation: 'Restaurante Andrés Carne de Res',
      toLocation: 'Carrera 7 # 24-89, Bogotá',
      deadline: DateTime.now().add(const Duration(minutes: 30)),
      category: 'restaurant',
    ),
    Delivery(
      id: 'GG-67890',
      customerName: 'John Doe',
      deliveryPerson: 'Ana Martínez',
      fromLocation: 'Café Paradiso',
      toLocation: 'Calle 72 # 10-20, Bogotá',
      deadline: DateTime.now().add(const Duration(minutes: 45)),
      category: 'cafe',
    ),
    Delivery(
      id: 'GG-98765',
      customerName: 'Sam Lee',
      deliveryPerson: 'Luis Rodríguez',
      fromLocation: 'Librería Nacional',
      toLocation: 'Carrera 15 # 88-45, Bogotá',
      deadline: DateTime.now().add(const Duration(minutes: 60)),
      category: 'package',
    ),
    Delivery(
      id: 'GG-54321',
      customerName: 'Emily Ross',
      deliveryPerson: 'Sofia Hernández',
      fromLocation: 'Supermercado Éxito',
      toLocation: 'Avenida El Dorado # 68-40, Bogotá',
      deadline: DateTime.now().subtract(const Duration(minutes: 15)),
      category: 'package',
      status: DeliveryStatus.completed,
      completedAt: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
    Delivery(
      id: 'GG-11223',
      customerName: 'Sam Wilson',
      deliveryPerson: 'Carlos López',
      fromLocation: 'Tienda D1',
      toLocation: 'Avenida El Dorado # 68-40, Barrios Unidos, Bogotá',
      deadline: DateTime.now().add(const Duration(minutes: 75)),
      category: 'package',
    ),
    Delivery(
      id: 'GG-22334',
      customerName: 'Emily Chen',
      deliveryPerson: 'Ana Martínez',
      fromLocation: 'Restaurante Wok',
      toLocation: 'Calle 85 # 13-45, Usaquén, Bogotá',
      deadline: DateTime.now().subtract(const Duration(minutes: 30)),
      category: 'restaurant',
      status: DeliveryStatus.completed,
      completedAt: DateTime.now().subtract(const Duration(minutes: 30)),
    ),
    Delivery(
      id: 'GG-33445',
      customerName: 'Pedro Jiménez',
      deliveryPerson: 'Luis Rodríguez',
      fromLocation: 'Pizza Hot',
      toLocation: 'Carrera 11 # 93-12, Bogotá',
      deadline: DateTime.now().subtract(const Duration(minutes: 5)),
      category: 'restaurant',
    ),
  ];

  List<Delivery> get allDeliveries => List.unmodifiable(_deliveries);

  List<Delivery> get pendingDeliveries => _deliveries
      .where((d) => d.status == DeliveryStatus.pending)
      .toList();

  List<Delivery> get completedDeliveries => _deliveries
      .where((d) => d.status == DeliveryStatus.completed)
      .toList();

  List<Delivery> get overdueDeliveries => _deliveries
      .where((d) => d.isOverdue && d.status == DeliveryStatus.pending)
      .toList();

  int get totalDeliveries => _deliveries.length;
  int get pendingCount => pendingDeliveries.length;
  int get completedCount => completedDeliveries.length;
  int get overdueCount => overdueDeliveries.length;

  double get completionPercentage {
    if (_deliveries.isEmpty) return 0.0;
    return (completedCount / totalDeliveries) * 100;
  }

  List<Delivery> getDeliveriesForPerson(String personName) {
    return _deliveries
        .where((d) => d.deliveryPerson == personName)
        .toList();
  }

  void markDeliveryAsCompleted(String deliveryId) {
    final index = _deliveries.indexWhere((d) => d.id == deliveryId);
    if (index != -1 && _deliveries[index].status != DeliveryStatus.completed) {
      _deliveries[index].markAsCompleted();
      notifyListeners();
    }
  }

  void toggleDeliveryStatus(String deliveryId) {
    final index = _deliveries.indexWhere((d) => d.id == deliveryId);
    if (index != -1) {
      if (_deliveries[index].status == DeliveryStatus.completed) {
        _deliveries[index] = _deliveries[index].copyWith(
          status: DeliveryStatus.pending,
          completedAt: null,
        );
      } else {
        _deliveries[index].markAsCompleted();
      }
      notifyListeners();
    }
  }
}
