# Flutter Challenge — “Soluciona un problema real”

## Contexto del reto

La empresa ficticia **GreenGo Logistics** es una startup que coordina *repartidores en bicicleta* para entregas sostenibles en la ciudad.  
Actualmente enfrentan el siguiente problema:

- Los repartidores deben reportar manualmente cuando entregan un pedido.
- Los supervisores no tienen una forma rápida de ver qué entregas siguen pendientes o cuáles ya se completaron.

---

## Reto para los estudiantes

Diseñar y construir en Flutter una app sencilla (*prototipo*) que permita:

- Que un repartidor vea su lista de entregas pendientes.
- Marcar un pedido como “entregado” con un solo toque.
- Que un supervisor pueda ver en tiempo real el progreso de todas las entregas.

---

## Requisitos mínimos (base técnica)

Cada grupo debe entregar un prototipo funcional que incluya:

| Requisito         | Descripción                                                                                                                                                 |
|-------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **UI básica**     | Pantallas para repartidor y supervisor (pueden usar ListView, Checkbox, Cards, etc.)                                                                        |
| **Datos simulados** | Se permite usar una lista local (`List<Map<String, dynamic>>`) o provider/cubit simple para manejar estado.                                               |
| **Interacción real** | Cuando el repartidor marca una entrega, debe reflejarse visualmente (por ejemplo, con un ícono verde o tachado).                                         |
| **Diseño visual** | Se valorará uso de ThemeData, íconos, y colores consistentes.                                                                                               |
| **Creatividad extra (opcional)** | Integrar algo visual divertido, por ejemplo un Rive de bicicleta en movimiento o una barra de progreso animada.                               |

- **No se exige backend**. Si alguien quiere usar Firebase o simularlo con almacenamiento en memoria, puede hacerlo.

#### Opcional (para subir nota / destacar):

- Uso de **Rive** o animaciones de Flutter (`AnimatedContainer`, `Hero`, etc.).
- Implementar modo supervisor que vea la lista global (por ejemplo, con un **TabBar**).
- Guardar temporalmente el estado (para simular persistencia con **SharedPreferences** o un local Map).
- Mostrar porcentaje de entregas completadas.

---

## Evaluación (100 pts totales)

| Categoría                    | Peso    | Qué se evalúa                                                                        |
|------------------------------|---------|--------------------------------------------------------------------------------------|
| **Funcionalidad**            | 40 pts  | La app hace lo que promete. Los botones funcionan y los estados cambian correctamente.|
| **Diseño / UX**              | 25 pts  | Interfaz clara, moderna y agradable. Uso correcto de Material Design.                 |
| **Creatividad / Innovación** | 20 pts  | Soluciones originales (animaciones, interacción, gamificación, etc.)                  |
| **Código y estructura**      | 15 pts  | Orden, claridad, nombres correctos, uso de widgets bien organizados.                 |

---

## Dinámica

**Inicio (5 min):**
- Explicas el contexto y entregas el enunciado impreso o en pantalla.
- Cada grupo elige si crea el prototipo para repartidor o supervisor (o ambos si alcanzan).

**Desarrollo (45 min):**
- Los estudiantes diseñan y codifican su solución.
- Pueden usar cualquier paquete de Flutter (*provider*, *bloc*, *rive*, etc.) pero deben hacerlo desde cero.

**Demo final (10 min):**
- Cada grupo muestra su app en el emulador o navegador.
- Se da feedback inmediato según los criterios de arriba.

---

## Sugerencias para los equipos

- Planifiquen antes de codear. Decidan qué pantallas van a tener y dibujen un boceto rápido.
- Divídanse tareas: uno diseña UI, otro maneja estado, otro prepara animaciones.
- Iteren rápido: es mejor algo simple que funcione a algo complejo sin terminar.
- Agreguen personalidad: colores, logo, nombres de ciclistas, barra de progreso, etc.

---

## Premio 🎁

**Giftcard Amazon $50** por equipo, es dividible.
