// ignore: depend_on_referenced_packages
// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'control_light_event.dart';
part 'control_light_state.dart';

class ControlLightBloc extends Bloc<ControlLightEvent, ControlLightState> {
  ControlLightBloc() : super(ControlLightInitial()) {
    on<ControlLightEvent>((event, emit) async {
      if (event is RequestBluetoothPermission) {
        emit(BluetoothLoading());

        await Future.delayed(Duration(seconds: 2));
        try {
          if (await FlutterBluePlus.isSupported == false) {
            emit(BluetoothErr("Tidak Didukung"));
            return;
          }

          // Start listening for adapter state
          FlutterBluePlus.adapterState.listen((state) {
            if (state == BluetoothAdapterState.on) {
              add(StartConnect(
                  timeout: Duration(seconds: 5))); // Adjust timeout as needed
            } else if (Platform.isAndroid) {
              FlutterBluePlus.startScan();
            } else {
              emit(BluetoothErr("Tidak Didukung"));
            }
          });
        } catch (e) {
          emit(BluetoothErr(e.toString()));
        }
      }

      if (event is StartConnect) {
        emit(BluetoothLoading());

        try {
          FlutterBluePlus.startScan(timeout: event.timeout);

          await Future.delayed(event.timeout);

          var resultsScan = await FlutterBluePlus.scanResults.first;
          List<BluetoothDevice> devices = [];

          for (ScanResult result in resultsScan) {
            if (!devices.contains(result.device)) {
              devices.add(result.device);
            }
          }

          // Jika tidak ada perangkat yang ditemukan
          if (devices.isEmpty) {
            emit(BluetoothErr("Tidak Ditemukan"));
            return;
          } else {
            add(UpdateDevices(devices));
          }

          await Future.delayed(Duration(seconds: 5));
          FlutterBluePlus.stopScan();
        } catch (e) {
          emit(BluetoothErr(e.toString()));
        }
      }

      if (event is ConnectDevices) {
        try {
          await event.bluetoothDevice.connect();
          emit(DeviceConnected(event.bluetoothDevice));
          //Memastikan bLuetooth Terhubung
          
          //Memastikan Discoveries 
          List<BluetoothService> services = await event.bluetoothDevice.discoverServices();
          BluetoothCharacteristic? targetCharachteristic;

          String seviceUUID = "7680574d-9dd8-4b9d-90bd-5005ead7e6aa";
          String characteristicUUID = "e1599746-2e38-41a6-a6be-3e634a75e897" ;

          //Memastikan ServiceUUID dan charactericstic UUID SAMA
          for (BluetoothService service in services) {
            if (service.uuid.toString() == seviceUUID) {
              for (BluetoothCharacteristic characteristic in service.characteristics) {
                if (characteristic.characteristicUuid.toString() == characteristicUUID) {
                  targetCharachteristic = characteristic;
                }
              }
            }
          }

          if (targetCharachteristic == null) {
            emit(BluetoothErr("Device Tidak Ada Yang Cocok"));
          }
          
          //Mengirim Pesan Lewat Koneksi Bluetooth angellllll cyuk
          event.bluetoothCharacteristic.write(utf8.encode(event.message));
          emit(SendMessage(event.message));
        } catch (e) {
          emit(BluetoothErr(e.toString()));
        }
      }

      if (event is UpdateDevices) {
        emit(BluetoothFound(event.devices, device: event.devices));
      }

      if (event is Reconect){
        
        StartConnect();
        

      }
    });
  }
}
