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
        
        formatter.dateFormat = "HH:mm:ssdd-MM-yyyy"
        
        result = formatter.string(from: date)
        return result
    }

    
}
