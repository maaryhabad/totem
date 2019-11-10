//
//  Utils.swift
//  totem
//
//  Created by Mariana Beilune Abad on 30/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import Foundation
class Utils {
 
    static func pegarDataAtual() -> String {
        var result = ""
        let date = Date()
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)

        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyyMMddHHmmss"
        
        result = formatter.string(from: date)
        return result
    }
    
    static func convertStringtoDate(data: String) -> Date {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyyMMddHHmmss"
        let date = dateFormatter.date(from: data)
        return date!
    }
    
    static func toTimeString(segundos :Int) -> String{
        var m = segundos / 60 as! Int
        var s = segundos - (segundos * m)
        
        var mString = NSString(format: "00", m)
        var sString = NSString(format: "00", s)
        var tempo = "\(m):\(s)"
        return tempo
    }
    
    static func getDateString(date :String) -> String{
        
        let startMes = date.index(date.startIndex, offsetBy: 4)
        let endMes = date.index(date.endIndex, offsetBy: -8)
        let rangeMes = startMes..<endMes
        let mes = String(date[rangeMes])
        
        let startDia = date.index(date.startIndex, offsetBy: 6)
        let endDia = date.index(date.endIndex, offsetBy: -6)
        let rangeDia = startDia..<endDia
        let dia = String(date[rangeDia])
        
        return "\(dia)/\(mes)"
    }

    // fazer função que pega string e retorna um Usuario
    // fazer função que pega string e retorna uma lista de usuários
    // fazer função que pega string e retorna um sentimento
    // fazer função que pega string e retorna uma lista de mensagens
    
    
}
