class ResponseModel<T> {
  bool loadedData = true;

  T fromJson(Map<String, dynamic> json) {
    return base;
  }

  T get base => this as T;
}
