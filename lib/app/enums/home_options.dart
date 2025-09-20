enum HomeOption {
  dio,
  env,
  internationalitation,
  extensions;

  String get title {
    switch (this) {
      case HomeOption.dio:
        return 'Prueba DIO HTTP';
      case HomeOption.env:
        return 'Variables entorno';
      case HomeOption.internationalitation:
        return 'Internacionalización';
      case HomeOption.extensions:
        return 'Extensiones';
    }
  }
}
