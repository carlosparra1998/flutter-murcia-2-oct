abstract class ResponseModel<T> {
  T fromJson(Map<String, dynamic> json) {
    return base;
  }

  T get base => this as T;
}
