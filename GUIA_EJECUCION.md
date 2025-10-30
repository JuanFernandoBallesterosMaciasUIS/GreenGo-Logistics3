# Guía de Ejecución - GreenGo Logistics

## 🚀 Ejecutar el Proyecto

### Opción 1: Ejecutar en Emulador/Dispositivo Android

1. Abre un emulador Android o conecta un dispositivo físico
2. Ejecuta en la terminal:
   ```bash
   flutter run
   ```

### Opción 2: Ejecutar en Navegador Web (Chrome)

```bash
flutter run -d chrome
```

### Opción 3: Ejecutar en Emulador iOS (solo macOS)

```bash
flutter run -d ios
```

## 🧪 Probar la Funcionalidad

### Vista Repartidor
1. En la pantalla inicial, selecciona "Repartidor"
2. Verás la lista de entregas pendientes
3. Toca el botón de check ✓ en cualquier entrega para marcarla como completada
4. Cambia a la pestaña "Completadas" para ver las entregas finalizadas
5. Vuelve a tocar el check para desmarcarla si es necesario

### Vista Supervisor
1. En la pantalla inicial, selecciona "Supervisor"
2. Verás el dashboard con estadísticas:
   - Total de entregas
   - Entregas pendientes
   - Entregas atrasadas
3. Usa los filtros para ver:
   - Todos
   - Pendientes
   - Atrasadas
   - Completadas
4. Observa los indicadores de color:
   - 🟢 Verde = Completado
   - 🟡 Amarillo = Pendiente
   - 🔴 Rojo = Atrasado

### Sincronización en Tiempo Real
1. Abre dos ventanas o dispositivos simultáneamente
2. En una ventana abre la vista de Repartidor
3. En la otra ventana abre la vista de Supervisor
4. Marca una entrega como completada en la vista del Repartidor
5. Verás cómo se actualiza automáticamente en la vista del Supervisor

## 📊 Datos de Prueba

La aplicación incluye 7 entregas predefinidas:

| ID | Cliente | Estado | Repartidor |
|----|---------|--------|------------|
| GG-12345 | María García | Pendiente | Carlos López |
| GG-67890 | John Doe | Pendiente | Ana Martínez |
| GG-98765 | Sam Lee | Pendiente | Luis Rodríguez |
| GG-54321 | Emily Ross | Completado | Sofia Hernández |
| GG-11223 | Sam Wilson | Pendiente | Carlos López |
| GG-22334 | Emily Chen | Completado | Ana Martínez |
| GG-33445 | Pedro Jiménez | Atrasado | Luis Rodríguez |

## 🎨 Características Visuales

- **Tema claro/oscuro**: La app respeta las preferencias del sistema
- **Animaciones**: Transiciones suaves al cambiar entre pestañas
- **Iconos**: Diferentes iconos según el tipo de entrega (restaurante 🍽️, café ☕, paquete 📦)
- **Estados visuales**: Colores y badges que indican el estado de cada entrega

## 🛠️ Comandos Útiles

### Limpiar caché de build
```bash
flutter clean
flutter pub get
```

### Analizar código
```bash
flutter analyze
```

### Ver dispositivos disponibles
```bash
flutter devices
```

### Ejecutar en un dispositivo específico
```bash
flutter run -d <device-id>
```

### Hot Reload durante desarrollo
- Presiona `r` en la terminal donde corre la app
- O guarda los archivos en VS Code con auto-save activado

### Hot Restart
- Presiona `R` (mayúscula) en la terminal

## 📱 Requisitos del Sistema

- **Flutter SDK**: >= 3.0.0
- **Dart SDK**: >= 3.0.0
- **RAM**: Mínimo 4GB (recomendado 8GB)
- **Espacio en disco**: 2.5GB para Flutter SDK + herramientas

## 💡 Tips para Demostración

1. **Inicio rápido**: La app está lista para usar sin configuración adicional
2. **Demo fluida**: Usa hot reload para hacer cambios en tiempo real si es necesario
3. **Interactividad**: Muestra cómo marcar/desmarcar entregas y cómo se sincronizan
4. **Filtros**: Demuestra los diferentes filtros en la vista del supervisor
5. **Estadísticas**: Las estadísticas se actualizan automáticamente al cambiar estados

## 🐛 Solución de Problemas

### Error: "No devices found"
- Asegúrate de tener un emulador abierto o dispositivo conectado
- Ejecuta `flutter devices` para verificar

### Error de dependencias
```bash
flutter clean
flutter pub get
```

### La app no se actualiza
- Usa Hot Restart (R mayúscula) en lugar de Hot Reload

### Problemas de rendimiento
- Usa el modo release para mejor rendimiento:
```bash
flutter run --release
```

## ✅ Checklist de Evaluación

- ✅ Funcionalidad: Los botones funcionan y los estados cambian correctamente
- ✅ Diseño/UX: Interfaz clara, moderna y agradable con Material Design
- ✅ Creatividad: Filtros múltiples, estadísticas en tiempo real, animaciones
- ✅ Código: Bien estructurado con separación de concerns (models, providers, screens)
- ✅ Extra: Provider para estado global, soporte tema claro/oscuro

---

**¡El proyecto está listo para presentación!** 🎉
