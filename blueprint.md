# Blueprint: UbicanID Tiendas

## Visión General

Esta aplicación para Android, llamada "UbicanID Tiendas", servirá como una herramienta interna para registrar y administrar los puntos de venta que distribuyen plaquitas de identificación UbicanID. La aplicación contará con una base de datos local SQLite para asegurar que los datos estén siempre disponibles sin necesidad de conexión a internet.

El diseño seguirá los lineamientos de Material 3, ofreciendo una interfaz de usuario moderna, limpia e intuitiva, con una paleta de colores distintiva de la marca.

## Arquitectura y Diseño

- **Arquitectura:** Se implementará un patrón MVVM (Model-View-ViewModel) utilizando el paquete `provider` para la gestión del estado. Esto separará la lógica de negocio de la interfaz de usuario, facilitando la mantenibilidad y escalabilidad del código.
- **Base de Datos:** Se usará `sqflite` para crear y manejar una base de datos SQLite local.
- **UI/UX:**
    - **Framework:** Flutter.
    - **Diseño:** Material 3.
    - **Paleta de Colores:** Blanco (fondo), Azul #2F80ED (primario), y tonos de Gris (acentos, texto secundario).
    - **Tipografía:** Se usará `google_fonts` para una apariencia de texto limpia y moderna.

## Características Implementadas

### Versión Inicial

- **Configuración del Proyecto:**
    - Identificador de la aplicación: `com.tiendas.ubicanid`.
    - Nombre de la aplicación: `UbicanID Tiendas`.
- **Base de Datos:**
    - Modelo `PointOfSale` para representar los puntos de venta.
    - Clase `DatabaseHelper` para gestionar las operaciones CRUD en la base de datos SQLite.
- **Gestión de Estado:**
    - `PointOfSaleProvider` para manejar la lógica de la aplicación y notificar a la UI sobre los cambios.
- **Interfaz de Usuario:**
    - **Pantalla Principal:** Muestra una lista de tarjetas con la información de cada negocio, un campo de búsqueda y un botón flotante para agregar nuevos registros.
    - **Pantalla de Formulario (Agregar/Editar):** Un formulario para crear o modificar los datos de un punto de venta.
    - **Pantalla de Detalles:** Muestra toda la información de un punto de venta con opciones para editar o eliminar.

## Plan de Implementación Actual

1.  **Configurar el entorno del proyecto:**
    - Actualizar `android/app/build.gradle.kts` con el `applicationId`.
    - Actualizar `android/app/src/main/AndroidManifest.xml` con el `android:label`.
    - Añadir las dependencias necesarias a `pubspec.yaml`: `sqflite`, `path_provider`, `provider`, `intl`, y `google_fonts`.

2.  **Crear la capa de Datos:**
    - Definir la clase `PointOfSale` en `lib/models/point_of_sale.dart`.
    - Implementar el `DatabaseHelper` en `lib/database_helper.dart` para manejar la base de datos.

3.  **Crear la capa de Lógica de Negocio (ViewModel):**
    - Crear `PointOfSaleProvider` en `lib/providers/point_of_sale_provider.dart` para gestionar el estado de los puntos de venta.

4.  **Construir la Interfaz de Usuario (Vistas):**
    - Modificar `lib/main.dart` para configurar el tema de Material 3, el `ChangeNotifierProvider` y las rutas iniciales.
    - Crear la pantalla principal `lib/screens/home_screen.dart`.
    - Crear las pantallas de detalles y de formulario (`lib/screens/detail_screen.dart` y `lib/screens/add_edit_screen.dart`).
    - Diseñar los widgets reutilizables, como las tarjetas de negocio (`lib/widgets/point_of_sale_card.dart`).

5.  **Puesta en Marcha y Pruebas:**
    - Realizar la carga inicial de datos.
    - Probar las funciones de agregar, editar, eliminar y buscar.
    - Formatear y analizar el código para asegurar la calidad.
