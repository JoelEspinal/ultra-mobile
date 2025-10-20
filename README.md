

📱 Ultra Mobile App: Gestión de Tareas (Demo)

Este proyecto es una aplicación de demostración de manejo de tareas (To-Do List) desarrollada en Flutter. Su objetivo principal es demostrar la implementación de una Arquitectura Limpia (Clean Architecture) con un enfoque en la inmutabilidad, la gestión avanzada de estados y la persistencia local robusta.

🌟 Breve Descripción

Ultra Mobile permite a los usuarios crear, leer, actualizar y eliminar tareas (Todos). Incluye la gestión de detalles de tareas, como prioridades, fechas de vencimiento y la funcionalidad de adjuntar imágenes, todo ello persistido localmente.

🏗️ Arquitectura y Patrones Utilizados

La aplicación está construida sobre los principios de la Arquitectura Limpia y Clean Code, garantizando una estricta División de Responsabilidades (Separation of Concerns) entre las capas.

Capas

Domain (Dominio): Contiene las Entidades (Todo) y los Contratos de Repositorio (TodoRepository). Es la capa más interna y pura, libre de dependencias de frameworks.

Data (Datos): Implementa la persistencia (con Hive) y define los Modelos de Datos (TodoModel). Aquí se encuentran las implementaciones concretas del Repositorio (TodoRepositoryImpl).

Presentation (Presentación): Responsable de la UI y la gestión del estado.

Patrones de Diseño

Model-View-ViewModel (MVVM): Utilizado en la capa de Presentación para desacoplar la lógica de estado (ViewModel/Cubit) de la interfaz de usuario (View).

Repository Pattern: Aísla la capa de datos de la lógica de negocio.

Adapter Pattern: Se utiliza para mapear (fromEntity, toEntity) datos entre el Dominio (Entidades) y la Data (Modelos Hive).

Gestión de Estado y Funcional

Cubit (o Bloc): Se emplea para la gestión de estados reactiva, manejando la lógica del flujo de datos en la capa de Presentación.

Provider: Utilizado principalmente para la inyección de dependencias y el acceso a los servicios (Repositorios, Cubits) en la jerarquía de widgets.

DartZ (Either): Implementación de la librería dartz para un manejo funcional y explícito de errores, devolviendo Either<Failure, Success> desde la capa de Datos.

✨ Decisiones Técnicas Importantes

Persistencia Local (Hive): Elegido por su rendimiento y su naturaleza de base de datos NoSQL Key-Value, ideal para almacenamiento local simple y rápido.

Inmutabilidad: Uso de la librería freezed para Entidades y Modelos, garantizando que los objetos sean inmutables y facilitando su comparación (equatable).

📦 Dependencias y Librerías (Estabilizadas)

Se presenta la lista de dependencias con versiones ajustadas para resolver conflictos comunes con build_runner (específicamente entre freezed y source_gen).

Motor de generación de código:
build_runner: ^2.7.0

Generación (dev):
freezed: ^4.0.0


Persistencia - Base de datos local:
hive_ce_generator: ^1.10.0
hive_flutter: ^1.1.0

Gestión de estados:
flutter_bloc: ^9.1.1
bloc: ^9.1.0

Funcional - Manejo funcional de errores (Either):

dartz: ^0.10.1

Utilidades - Captura y selección de imágenes:
image_picker: ^1.2.0


Otros
provider: ^6.1.5+1
dio: ^5.9.0 
intl: ^0.20.2
build_runner: ^2.7.0

...

Inyección de dependencias, cliente HTTP, internacionalización.

⚙️ Instrucciones de Instalación y Ejecución

Siga estos pasos para configurar y ejecutar el proyecto:

Obtener Dependencias:

flutter pub get


Generar Código (Observador):
Ejecute este comando para generar automáticamente archivos (.g.dart, .freezed.dart) para Hive, Freezed y JSON.

dart run build_runner watch --delete-conflicting-outputs


Ejecutar Aplicación:
Asegúrese de que los permisos de Cámara/Galería estén configurados en Info.plist (iOS) y AndroidManifest.xml (Android) antes de ejecutar.

flutter run -d <device_id>
