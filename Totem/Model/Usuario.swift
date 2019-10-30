//
//  Usuario.swift
//  Tarantino
//
//  Created by Mariana Beilune Abad on 18/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import Foundation

class Usuario {
    var capaTotem: String
    var contatos: [Int]!
    var nomeDoUsuario: String
    var idUsuario: Int
    
    init(capaTotem: String, contatos: [Int]!, nomeDoUsuario: String, idUsuario: Int) {
        self.capaTotem = capaTotem
        self.contatos = contatos
        self.nomeDoUsuario = nomeDoUsuario
        self.idUsuario = idUsuario
    }
    
    
    func generateID() {
        let identifier = UUID()
    }
}
