class Error {
  Map<String, String>? errors;

  Error({this.errors});

  Error.fromJson(Map<String, dynamic>? json) {
    if (json != null) {
      errors = json.map((key, value) => MapEntry(key, value.toString()));
    }
  }
}
