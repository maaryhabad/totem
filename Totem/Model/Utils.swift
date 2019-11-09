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

    // fazer função que pega string e retorna um Usuario
    // fazer função que pega string e retorna uma lista de usuários
    // fazer função que pega string e retorna um sentimento
    // fazer função que pega string e retorna uma lista de mensagens
    
    
}
