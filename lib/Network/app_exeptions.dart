class AppExceptions implements Exception {
  final String message;
  final String prefix;

  AppExceptions(
    this.message,
    this.prefix,
  );

  @override
  String toString() {
    return '$prefix$message';
  }
}

class FetchDataException extends AppExceptions {
  FetchDataException([String message = 'Error during communicationn'])
      : super(message, "Error during communicationn");
}

class BadRequestException extends AppExceptions {
  BadRequestException([String message = 'Invalid Request'])
      : super(message, "Invalid Request");
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException([String message = 'Unauthorised Request'])
      : super(message, "Unauthorised Request");
}

class InvalidInputException extends AppExceptions {
  InvalidInputException([String message = 'Invalid Input'])
      : super(message, "Invalid Input");
}
