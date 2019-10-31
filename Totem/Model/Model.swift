//
//  Model.swift
//  Tarantino
//
//  Created by Mariana Beilune Abad on 18/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import Foundation

class Model {
    static let instance = Model()
    
    private init() {
        
    }
    
    let sentimento = ["cansado", "legal", "feliz", "bravo", "custom"]
    var usuarios : [Usuario] = [
        Usuario(capaTotem: "Catalina.jpg", contatos: [00002, 00003], nomeDoUsuario: "Catalina", idUsuario: 00001),
        Usuario(capaTotem: "Alberto.jpg", contatos: [00001, 00003], nomeDoUsuario: "Alberto", idUsuario: 00002),
        Usuario(capaTotem: "Carlos.jpg", contatos: [00001, 00002], nomeDoUsuario: "Carlos", idUsuario: 00003)
    ]
}
