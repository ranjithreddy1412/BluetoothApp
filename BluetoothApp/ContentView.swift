//
//  ContentView.swift
//  BluetoothApp
//
//  Created by ranjith kumar reddy b perkampally on 4/13/25.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    
    @StateObject var bluetoothManager = BluetoothManager()
    
    var body: some View {
        VStack {
            Text("Bluetooth Devices")
                .font(.title)
                .padding()
            
            List(bluetoothManager.discoveredDevices, id: \.identifier) { device in
                HStack {
                    Text(device.name ?? "Unnamed Device")
                    Spacer()
                    Button("Connect") {
                        bluetoothManager.connectToDevice(peripheral: device)
                    }
                }
            }
            
            if let connectedPeripheral = bluetoothManager.connectedPeripheral {
                Text("Connected to: \(connectedPeripheral.name ?? "Unknown")")
                    .padding()
            }
            
            Button("Stop Scanning") {
                bluetoothManager.stopScan()
            }
            .padding()
        }
        .onAppear {
            bluetoothManager.centralManagerDidUpdateState(bluetoothManager.centralManager)
        }
    }
}
#Preview {
    ContentView()
}
