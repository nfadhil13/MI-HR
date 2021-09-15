abstract class Resource<T> {
  void whenWithResult(
  {
    Function(Success<T>)? success,
    Function(Error)? error,
    Function(NotAuthorize)? notAuthorize
  }
      ) {
    if (this is Success<T>) {
      return success == null ? DoNothing<T>() : success(this as Success<T>);
    } else if (this is Error) {
      return error == null ? DoNothing<T>() : error(this as Error<T>);
    } else if (this is NotAuthorize) {
      return notAuthorize == null ? DoNothing<T>() : notAuthorize(this as NotAuthorize);
    }else {
      throw new Exception('Unhendled part, could be anything');
    }
  }
}

class Success<T> extends Resource<T> {
  final T data;

  Success({required this.data});
}

class Error<T> extends Resource<T> {
  final String message;

  Error({ required this.message});
}

class NotAuthorize<T> extends Resource<T> {
  NotAuthorize();
}

class DoNothing<T> extends Resource<T> {
  DoNothing();
}