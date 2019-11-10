//
//  BLEManager.swift
//  TesteBluetooth
//
//  Created by MCavasin on 09/11/19.
//  Copyright © 2019 Matheus Cavasin. All rights reserved.
//

import Foundation
import CoreBluetooth

class BLEManager: NSObject, CBPeripheralDelegate, CBCentralManagerDelegate {
    
    static let instance = BLEManager()
    override private init() {}
        let peripheralUUID = CBUUID(string: "7d816af5-62ff-4794-8b8f-7c1e60cc5063")
       let peripheralAud = CBUUID(string: "8a5a71a6-8e65-4905-850b-745beeb54449") //adicionar sercico
       let ledCharacteristic = CBUUID(string: "75bfe467-13d8-4ff6-a183-f5ffbb7fd1d7")
       let audioCharacteristic = CBUUID(string: "9f74490f-3c34-47bb-b16e-437b34a4a8f6")
       var valueChar: CBCharacteristic?
       var valueCharAudio: CBCharacteristic?
       var contents: Data?
       let kEndFileFlag = "EOF"
       private var centralManager: CBCentralManager!
       private var peripheral: CBPeripheral!
       private var aaa: CBPeripheral!
       private var characteristics: [CBUUID : CBCharacteristic]!
       
       // Others
       var ledFlag = 0
       
        func setup(){
            
            centralManager = nil
            self.peripheral = nil
            self.aaa = nil
            self.characteristics = nil
            self.valueChar = nil
            self.valueCharAudio = nil
            centralManager = CBCentralManager(delegate: self, queue: nil)
        }

        func centralManager(_ central: CBCentralManager, didDisconnectPeripheral peripheral: CBPeripheral, error: Error?) {
    //         centralManager.scanForPeripherals(withServices: [self.peripheralUUID],
    //                                                     options: nil)
    //        central.
            self.setup()
        }
        
        // funçao para escanear periféricos. Serve também para saber o estado do bluetooth: ligado ou desligado
        func centralManagerDidUpdateState(_ central: CBCentralManager) {
            print("Central state update")
            if central.state != .poweredOn {
                print("Central is not powered on")
            } else {
                print("Central scanning");
                centralManager.scanForPeripherals(withServices: [self.peripheralUUID],
                                                  options: nil)
            }
        }
        
        
        // funcao chamada após iniciar uma conexão, aqui é onde se inicia o descobrimento de dispositivos. Esse descobrimento serve para identificar quais serviços e características estão disponíveis.
        func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
            print("Achei um periferico!", peripheral.services?.first?.uuid)
            // Como essa funçao é chamada após encontrar o dispositivo, podemos para o scan
            self.centralManager.stopScan()

            self.peripheral = peripheral
            self.peripheral.delegate = self

            // Connect!
            self.centralManager.connect(self.peripheral, options: nil)

        }
        
        // Caso a conexão nao tenha sido com o periférico correto
        // Comparando os dois periféricos, saberemos que é o mesmo que encontramos na etapa anteior,
        func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
            if peripheral == self.peripheral {
                print("Connected to your Particle Board")
                // agora inicia-se uma descoberta de serviços
                peripheral.discoverServices([])
            }
        }
        
        // função executada após a descoberta dos serviços
        // Esse é o terceiro momento de verificaçao se é o serviço correto que está conectado. Isso bem útil quando há muitos serviços disponíveis
        func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
            if let services = peripheral.services {
                for service in services {
                    print("UUID IS", service.uuid)
                    if service.uuid == self.peripheralUUID {
                        print("LED service found")
                        //Now kick off discovery of characteristics
                        peripheral.discoverCharacteristics([], for: service)
                        return
                    }
                }
            }
        }
        
        // funçao para lidar com as características
        func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
            if let characteristics = service.characteristics {
                self.characteristics = [CBUUID: CBCharacteristic]()
                for characteristic in characteristics {
                    peripheral.writeValue("77".data(using: .utf8)!, for: characteristic, type: .withResponse)
                    if characteristic.uuid  == self.ledCharacteristic {
                        valueChar = characteristic
                    }
                    if characteristic.uuid == self.audioCharacteristic {
                        valueCharAudio = characteristic
                    }
                }
            }
        }
        
        func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
            print("descobri o valor", characteristic.value)
            peripheral.writeValue("asd".data(using: .utf8)!, for: characteristic, type: .withResponse)
        }
        
        func peripheral(_ peripheral: CBPeripheral, didModifyServices invalidatedServices: [CBService]) {
            print("Mudou os services!")
            self.setup()
        }
            
        func getCharac(_ char: CBUUID) -> CBCharacteristic? {
            guard let service = self.peripheral.services?.first, let chars = service.characteristics else { return nil}
            for char in chars {
                if char.uuid == char { return char}
            }
            return nil
        }
        
    func writeLEDValue(value: String) {
        self.writeLEDValueToChar(withCharacteristic: valueChar!, withValue: (value.data(using: .utf8)!))
    }
    
    func writeAudio(url: String){
        
        self.playAudio(withCharacteristic: valueCharAudio!, withValue: (url.data(using: .utf8)!))
    }
    
        private func writeLEDValueToChar(withCharacteristic characteristic: CBCharacteristic, withValue value: Data) {
            
            // Check if it has the write property
            if characteristic.properties.contains(.write) && peripheral != nil {
                
                peripheral.writeValue(value, for: characteristic, type: .withResponse)

            }
            
        }
        
        private func playAudio(withCharacteristic characteristic: CBCharacteristic, withValue value: Data) {
            
            // Check if it has the write property
            if characteristic.properties.contains(.write) && peripheral != nil {
                
                peripheral.writeValue(value, for: characteristic, type: .withResponse)

            }
            
        }
    
    
}
