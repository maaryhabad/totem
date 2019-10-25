//
//  Usuario.swift
//  Tarantino
//
//  Created by Mariana Beilune Abad on 18/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import Foundation
import CloudKit

class Usuario {
    var capaTotem: CKAsset
    var contatos: [Usuario]!
    var nomeDoUsuario: String
    
    init(capaTotem: CKAsset, contatos: [Usuario]!, nomeDoUsuario: String) {
        self.capaTotem = capaTotem
        self.contatos = contatos
        self.nomeDoUsuario = nomeDoUsuario
    }
    
}
