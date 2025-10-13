class ToDoErrorHandle implements Exception{
  final String message;
  ToDoErrorHandle(this.message);
  @override
  String toString() =>message;
}