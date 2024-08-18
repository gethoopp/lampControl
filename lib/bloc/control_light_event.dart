part of 'control_light_bloc.dart';

@immutable
sealed class ControlLightEvent {}


class RequestBluetoothPermission extends ControlLightEvent{}

class StartConnect extends ControlLightEvent{
  final Duration timeout;

  StartConnect({ this.timeout = const Duration(seconds: 4)});
}

class UpdateDevices extends ControlLightEvent{
  final List<BluetoothDevice> devices;

  UpdateDevices(this.devices);
}

class ConnectDevices extends ControlLightEvent{
  final BluetoothDevice bluetoothDevice;
  final BluetoothCharacteristic bluetoothCharacteristic;
  final String message;

  ConnectDevices(this.bluetoothCharacteristic,this.bluetoothDevice,this.message);

}
 