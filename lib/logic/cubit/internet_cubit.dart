import "dart:async";

import "package:bloc/bloc.dart";
import "package:blc_tut/constants/enums.dart";
import "package:connectivity_plus/connectivity_plus.dart";
import "package:flutter/foundation.dart";
import "package:meta/meta.dart";

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity connectivity;
  late StreamSubscription connectivityStreamSub;

  InternetCubit({required this.connectivity}) : super(InternetLoading()) {
    monitorInternetConnection();
  }

  StreamSubscription<ConnectivityResult> monitorInternetConnection() {
    return connectivityStreamSub =
      connectivity.onConnectivityChanged.listen((connectivityResult) {
    if (connectivityResult == ConnectivityResult.wifi) {
      emitInternetConnected(ConnectionType.WiFi);
    } else if (connectivityResult == ConnectivityResult.mobile) {
      emitInternetConnected(ConnectionType.Mobile);
    } else if (connectivityResult == ConnectivityResult.none) {
      emitInternetDisconnected();
    }
  });
  }

  void emitInternetConnected(ConnectionType connectionType) =>
      emit(InternetConnected(connectionType: connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  @override
  Future<void> close() {
    connectivityStreamSub.cancel();
    return super.close();
  }
}
