enum ProviderState {
  Loading,
  Error,
  Idle,
  NotAuthorize
}

extension ProviderStateExtension on ProviderState {

  T? when<T>(
  {
    T? Function()? onLoading,
    T? Function()? onError,
    T? Function()? onIdle,
    T? Function()? onNotAuthorize,
  }
      ) {
      switch(this){
        case ProviderState.Idle:
          return onIdle?.call();
        case ProviderState.Loading:
          return onLoading?.call();
        case ProviderState.Error:
          return onError?.call();
        case ProviderState.NotAuthorize:
          return onNotAuthorize?.call();
      }
  }

}