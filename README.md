# GreenGo Logistics - Aplicación Flutter

## 📱 Descripción

GreenGo Logistics es una aplicación de gestión de entregas sostenibles desarrollada en Flutter. Permite a los repartidores en bicicleta gestionar sus entregas y a los supervisores monitorear el progreso en tiempo real.

## ✨ Características

### Vista Repartidor
- ✅ Lista de entregas pendientes y completadas
- ✅ Marcar entregas como completadas con un solo toque
- ✅ Información detallada de cada pedido (origen, destino, cliente, hora límite)
- ✅ Interfaz con segmented buttons para filtrar pendientes/completadas
- ✅ Estados vacíos informativos

### Vista Supervisor
- ✅ Dashboard con estadísticas en tiempo real (Total, Pendientes, Atrasadas)
- ✅ Lista completa de todas las entregas con estados visuales
- ✅ Filtros por estado: Todos, Pendientes, Atrasadas, Completadas
- ✅ Indicadores de color para identificar rápidamente el estado
- ✅ Actualización en tiempo real mediante Provider

## 🎨 Diseño

El diseño sigue la propuesta original con:
- **Colores:**
  - Primary: `#4CAF50` (Verde)
  - Accent: `#FFC107` (Amarillo)
  - Alert: `#F44336` (Rojo)
  - Accent Blue: `#2196F3` (Azul)
- **Material Design 3** con soporte para modo claro y oscuro
- **Fuente:** Manrope (simulada con la fuente del sistema)
- **Bordes redondeados** y diseño moderno

## 🏗️ Arquitectura

```
lib/
├── config/
│   └── theme.dart              # Configuración de temas claro/oscuro
├── models/
│   └── delivery.dart           # Modelo de datos Delivery
├── providers/
│   └── delivery_provider.dart  # Gestión de estado con Provider
├── screens/
│   ├── role_selection_screen.dart    # Pantalla de selección de rol
│   ├── delivery_person_screen.dart   # Vista del repartidor
│   └── supervisor_screen.dart        # Vista del supervisor
└── main.dart                   # Punto de entrada de la aplicación
```

## 🚀 Instalación y Ejecución

### Requisitos previos
- Flutter SDK (>=3.0.0)
- Dart SDK
- Android Studio / VS Code con extensiones de Flutter
- Emulador Android o iOS / Dispositivo físico

### Pasos de instalación

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/JuanFernandoBallesterosMaciasUIS/GreenGo-Logistics3.git
   cd GreenGo-Logistics3
   ```

2. **Instalar dependencias**
   ```bash
   flutter pub get
   ```

3. **Ejecutar la aplicación**
   ```bash
   flutter run
   ```

   O para web:
   ```bash
   flutter run -d chrome
   ```

## 📦 Dependencias

- `provider: ^6.1.1` - Gestión de estado
- `intl: ^0.19.0` - Formateo de fechas y horas
- `cupertino_icons: ^1.0.2` - Iconos de iOS

## 🎯 Cumplimiento de Requisitos

### Requisitos Mínimos ✅
- ✅ **UI básica:** Pantallas para repartidor y supervisor con ListView, Cards, Icons
- ✅ **Datos simulados:** Lista local con datos de prueba gestionados con Provider
- ✅ **Interacción real:** Marcar entregas se refleja visualmente en tiempo real
- ✅ **Diseño visual:** ThemeData personalizado, colores consistentes, iconos Material

### Extras Implementados 🌟
- ✅ Modo supervisor con estadísticas en tiempo real
- ✅ Sistema de filtros en vista supervisor (Todos, Pendientes, Atrasadas, Completadas)
- ✅ Segmented buttons en vista repartidor
- ✅ Porcentaje de entregas completadas (en el provider)
- ✅ Gestión de estado reactiva con Provider
- ✅ Soporte para tema claro y oscuro
- ✅ Diseño responsive y moderno

## 🔄 Gestión de Estado

La aplicación utiliza **Provider** para la gestión de estado, permitiendo:
- Sincronización en tiempo real entre vistas
- Cambios reactivos cuando se marca una entrega como completada
- Cálculos automáticos de estadísticas
- Separación clara entre lógica de negocio y UI

## 📊 Datos de Prueba

La aplicación incluye 7 entregas de prueba con diferentes estados:
- 4 entregas pendientes
- 3 entregas completadas
- 1 entrega atrasada

Cada entrega tiene:
- ID único
- Cliente
- Repartidor asignado
- Ubicaciones de origen y destino
- Hora límite de entrega
- Categoría (restaurante, café, paquete)
- Estado (pendiente, completado, atrasado)

## 👥 Equipo

Proyecto desarrollado para el reto de Flutter de GreenGo Logistics

## 📄 Licencia

© 2024 GreenGo Logistics. Todos los derechos reservados.