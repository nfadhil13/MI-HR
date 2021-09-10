import 'package:flutter/cupertino.dart';
import 'package:movie_app/provider/provider_state.dart';
import 'package:movie_app/repository/response.dart';
import 'package:movie_app/util/single_event.dart';


abstract class BaseProvider with ChangeNotifier {

  var _currentState = ProviderState.Idle;

  SingleEvent<String>? _errorMessage;


  Future<void> fetch<T>(
      Future<Response<T>> Function() fetchFunction,
      void Function(T data) onSuccess,
      {
        Function? beforeStart,
        void Function(String errorMessage)? onError
      }
      ) async {
    _currentState = ProviderState.Loading;
    beforeStart?.call();
    notifyListeners();
    final result = await fetchFunction();
    result.whenWithResult(
        success: (value) {
          _currentState = ProviderState.Idle;
          onSuccess(value.data);
        },
        error: (value) {
          _currentState = ProviderState.Error;
          onError?.call(value.message);
          _errorMessage = SingleEvent(value.message);
        },
        notAuthorize: (value) {
          _currentState = ProviderState.NotAuthorize;
        }
    );
    print("Current state sebelum notify adalah $currentState");
    notifyListeners();
  }

  ProviderState get currentState {
    return _currentState;
  }

  String? get errorMessage {
    print("error message sebelum dikirim adlaah ${_errorMessage?.peek}");
    return _errorMessage?.data;
  }

}