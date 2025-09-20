enum HomeOption {
  env, internationalitation, extensions;

  String get title{
    switch(this){
      case HomeOption.env:
        return 'Variables entorno';
      case HomeOption.internationalitation:
        return 'Internacionalización';
      case HomeOption.extensions:
        return 'Extensiones';
    }
  }
}