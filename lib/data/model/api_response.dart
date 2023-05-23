class ApiResponse<T> {
  final int? status;
  final String? message;
  final bool? success;
  final T? data;

  ApiResponse({
    this.status,
    this.message,
    this.success,
    this.data,
  });

  @override
  String toString() {
    return 'ApiResponse{'
        'status: $status, '
        'message: $message, '
        'success: $success, '
        'data: $data'
        '}';
  }
}
