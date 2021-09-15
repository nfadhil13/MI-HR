import 'package:get/get.dart';
import 'package:movie_app/util/single_event.dart';
import 'package:movie_app/repository/response.dart';
import '../provider/provider_state.dart';

abstract class BaseController extends GetxController {




  var currentState = ProviderState.Idle.obs;

  SingleEvent<String>? _errorMessage;


  Future<void> fetch<T>(
      Future<Resource<T>> Function() fetchFunction,
      void Function(T data) onSuccess,
      {
        Function? beforeStart,
        void Function(String errorMessage)? onError
      }
      ) async {
    currentState.value = ProviderState.Loading;
    beforeStart?.call();
    update();
    final result = await fetchFunction();
    result.whenWithResult(
        success: (value) {
          currentState.value = ProviderState.Idle;
          onSuccess(value.data);
        },
        error: (value) {
          currentState.value = ProviderState.Error;
          onError?.call(value.message);
          _errorMessage = SingleEvent(value.message);
        },
        notAuthorize: (value) {
          currentState.value = ProviderState.NotAuthorize;
        }
    );
  }


  String? get errorMessage {
    return _errorMessage?.data;
  }

}