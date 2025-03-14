# 📌 Formularios App

**Formularios App** es una aplicación desarrollada en **Flutter** que permite a los usuarios gestionar información personal y direcciones mediante formularios interactivos. Los datos se almacenan en **Firebase Realtime Database**, y la autenticación se maneja con **Firebase Authentication**.

---

## 🚀 **Características principales**

- 📌 **Gestión de direcciones:** Los usuarios pueden agregar, visualizar y eliminar direcciones.
- 🔑 **Autenticación con Firebase:** Los usuarios pueden iniciar sesión y registrar una cuenta.
- ☁️ **Almacenamiento en Firebase Realtime Database:** Los datos se guardan y sincronizan en tiempo real.
- 🏗 **Arquitectura basada en Clean Architecture y BLoC:** Separa claramente la lógica de negocio, los datos y la interfaz de usuario.
- 🛠 **Pruebas unitarias y mock de Firebase:** Uso de `mockito` para pruebas automatizadas.

---

## 📥 **Instalación y configuración**

### **1️⃣ Requisitos previos**

Antes de comenzar, asegúrate de tener instalado:

- **Flutter** (`>= 3.0`)
- **Dart** (`>= 2.17`)
- **Firebase CLI** (`firebase-tools`)
- **Cuenta de Firebase** con un proyecto creado.

### **2️⃣ Clonar el repositorio**

```bash
git clone https://github.com/nikolasibaUQ/formularios_app.git
cd formularios_app
```

### **3️⃣ Instalar dependencias y generar código**

Ejecuta los siguientes comandos en la terminal:

```bash
flutter clean
flutter pub get
dart run build_runner build --delete-conflicting-outputs
```

---

## 📂 **Estructura del Proyecto**

El proyecto sigue la arquitectura **Clean Architecture** con **BLoC** para la gestión del estado.

```plaintext
📂 lib/
 ┣ 📂 core/              # Código base reutilizable (Either, Failure, etc.)
 ┣ 📂 features/
 ┃ ┣ 📂 home/
 ┃ ┃ ┣ 📂 data/         # DataSources, implementaciones de Repositorios
 ┃ ┃ ┣ 📂 domain/       # Entidades y repositorios
 ┃ ┃ ┣ 📂 presentation/ # UI y BLoC
 ┃ ┃ ┗ 📂 widgets/      # Componentes reutilizables
 ┃ ┗ 📂 register/       # Módulo de creación de usuarios
 ┗ 📂 shared/           # Estilos, colores y utilidades generales
```

---

## 📌 **Uso de la Aplicación**

### **1️⃣ Registro e Inicio de Sesión**

- Al abrir la app, los usuarios pueden registrarse con su **correo y contraseña**.
- Luego, pueden iniciar sesión con sus credenciales.

### **2️⃣ Agregar una Dirección**

- En la pantalla de direcciones, presiona el botón **"Agregar Dirección"**.
- Llena el formulario con los datos requeridos.
- Guarda la dirección y se almacenará en Firebase.

### **3️⃣ Eliminar una Dirección**

- Cada dirección tiene un ícono de 🗑 **basura**.
- Al tocarlo, se eliminará la dirección de Firebase.

---

## 🔥 **Pruebas**

Ejecuta las pruebas unitarias con:

```bash
flutter test
```

Se han implementado pruebas con `mockito` para simular Firebase y evitar dependencias reales.

---

## 📌 **Tecnologías utilizadas**

- **Flutter** 🏗 (Framework principal)
- **Dart** 💻 (Lenguaje de programación)
- **Firebase Authentication** 🔐 (Inicio de sesión)
- **Firebase Realtime Database** ☁️ (Almacenamiento en la nube)
- **Bloc** 🏛 (Gestión del estado)
- **Mockito** 🧪 (Pruebas unitarias)

---

## 🛠 **Contribuir**

Si deseas contribuir:

1. Haz un fork del repositorio.
2. Crea una rama con tu mejora (`git checkout -b feature/nueva-mejora`).
3. Realiza los cambios y haz un commit (`git commit -m "Agregada nueva funcionalidad"`).
4. Sube los cambios (`git push origin feature/nueva-mejora`).
5. Crea un **Pull Request**.

---

## 📜 **Licencia**

Este proyecto está bajo la licencia MIT. Consulta el archivo `LICENSE` para más detalles.

---

## 👨‍💻 **Autor**

📌 Desarrollado por **Nicolas Ricardo Ibanez Puertas**  
🔗 Contacto: [nikolasiba23@gmail.com](mailto:nikolasiba23@gmail.com)

---

🚀 **¡Gracias por usar Formularios App!** 🚀

