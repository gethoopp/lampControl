part of 'control_light_bloc.dart';

@immutable
sealed class ControlLightState {}

final class ControlLightInitial extends ControlLightState {}

final class BluetoothLoading extends ControlLightState {}

final class BluetoothFound extends ControlLightState {
  final List<BluetoothDevice> devices;

  BluetoothFound(this.devices, {required List<BluetoothDevice> device});
}

final class DeviceConnected extends ControlLightState {
  final BluetoothDevice device;

  DeviceConnected(this.device);
}

final class SendMessage extends ControlLightState{
  final String message;

  SendMessage(this.message);
}

final class BluetoothErr extends ControlLightState {
  final String error;

  BluetoothErr(this.error);
}
