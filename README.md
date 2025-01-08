# Todo List App con Flutter y Riverpod

Esta es una implementación optimizada del ejemplo clásico de Todo List que se encuentra en la [documentación oficial de Riverpod](https://riverpod.dev/docs/introduction/getting_started), pero con algunas mejoras significativas:

- ✨ Sin uso de Flutter Hooks
- 📝 Código completamente documentado en español
- 🚀 Optimización en la reconstrucción de widgets
- 🎯 Gestión de estado eficiente con Riverpod

## Características

- Crear, editar y eliminar tareas
- Marcar tareas como completadas
- Filtrar tareas por estado (todas, activas, completadas)
- Contador de tareas pendientes
- Interfaz de usuario intuitiva y responsive

## Optimizaciones Implementadas

- Reconstrucción selectiva de widgets solo cuando:
  - Se cambia el filtro de visualización
  - Se completa/descompleta una tarea
  - Se modifica la lista de tareas
- Uso eficiente de `ConsumerWidget` y `ConsumerStatefulWidget`
- Implementación de providers específicos para minimizar rebuilds innecesarios


## Instalación

1. Clona este repositorio:

```bash
git clone https://github.com/[tu-usuario]/todo_list_riverpod_example.git
```

2. Instala las dependencias:

```bash
flutter pub get
```

3. Ejecuta la aplicación:

```bash
flutter run
```

## Contribución

Las contribuciones son bienvenidas. Para cambios importantes:

1. Haz fork del repositorio
2. Crea una nueva rama (`git checkout -b feature/mejora`)
3. Realiza tus cambios
4. Commit tus cambios (`git commit -am 'Agrega nueva funcionalidad'`)
5. Push a la rama (`git push origin feature/mejora`)
6. Crea un Pull Request

## Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles.

## Agradecimientos

- Equipo de Riverpod por la excelente documentación y ejemplo base
- Comunidad de Dart yFlutter por sus contribuciones y feedback

---
⭐️ Si este proyecto te fue útil, no dudes en darle una estrella en GitHub!