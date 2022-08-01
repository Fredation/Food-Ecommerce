T? routeArgsToType<T>(ts) {
  if (ts == null) return null;
  try {
    T tmp = ts;
    return tmp;
  } catch (e) {
    throw Exception(e);
  }
}
