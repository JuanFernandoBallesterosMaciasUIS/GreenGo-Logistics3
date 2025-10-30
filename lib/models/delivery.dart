enum DeliveryStatus {
  pending,
  completed,
  overdue,
}

class Delivery {
  final String id;
  final String customerName;
  final String deliveryPerson;
  final String fromLocation;
  final String toLocation;
  final DateTime deadline;
  final String category; // 'restaurant', 'cafe', 'package', etc.
  DeliveryStatus status;
  DateTime? completedAt;

  Delivery({
    required this.id,
    required this.customerName,
    required this.deliveryPerson,
    required this.fromLocation,
    required this.toLocation,
    required this.deadline,
    required this.category,
    this.status = DeliveryStatus.pending,
    this.completedAt,
  });

  bool get isOverdue {
    if (status == DeliveryStatus.completed) return false;
    return DateTime.now().isAfter(deadline);
  }

  bool get isPending {
    return status == DeliveryStatus.pending && !isOverdue;
  }

  String get statusText {
    if (status == DeliveryStatus.completed) {
      return 'Completado';
    } else if (isOverdue) {
      final difference = DateTime.now().difference(deadline);
      return 'Retrasado ${difference.inMinutes} min';
    } else {
      final difference = deadline.difference(DateTime.now());
      return 'Entrega en ${difference.inMinutes} min';
    }
  }

  String get categoryIcon {
    switch (category) {
      case 'restaurant':
        return 'restaurant_menu';
      case 'cafe':
        return 'local_cafe';
      case 'package':
        return 'package_2';
      default:
        return 'shopping_bag';
    }
  }

  void markAsCompleted() {
    status = DeliveryStatus.completed;
    completedAt = DateTime.now();
  }

  Delivery copyWith({
    String? id,
    String? customerName,
    String? deliveryPerson,
    String? fromLocation,
    String? toLocation,
    DateTime? deadline,
    String? category,
    DeliveryStatus? status,
    DateTime? completedAt,
  }) {
    return Delivery(
      id: id ?? this.id,
      customerName: customerName ?? this.customerName,
      deliveryPerson: deliveryPerson ?? this.deliveryPerson,
      fromLocation: fromLocation ?? this.fromLocation,
      toLocation: toLocation ?? this.toLocation,
      deadline: deadline ?? this.deadline,
      category: category ?? this.category,
      status: status ?? this.status,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}
