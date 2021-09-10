class SingleEvent<T> {
  final T _data;
  var _isConsumed = false;

  SingleEvent(this._data);


  T? get data {
    if(!_isConsumed){
      _isConsumed = true;
      return _data;
    }
    return null;
  }

  T get peek {
    return _data;
  }

}