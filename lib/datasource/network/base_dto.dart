abstract class BaseDto<T> {

  T fromJson();

  String toEncodedJson();

}