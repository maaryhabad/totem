//
//  ContatoDomain.swift
//  totem
//
//  Created by Mariana Beilune Abad on 07/11/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import Foundation

class ContatoDomain {
    var imagem: String
    var nome: String
    var flagTotemImg: String
    var totemIDUsuario: String
    var totemIDContato: String?
    
    init(contato: Usuario) {
        self.nome = contato.nome!
        self.imagem = contato.imagem!
        self.flagTotemImg = ""
        self.totemIDUsuario = ""
        self.totemIDContato = ""
        
        //Pegar totem contato
        for totem in Model.instance.totens! {
            if totem.idPossuinte == contato.id {
                self.flagTotemImg = "TotemTrueIcon"
                self.totemIDContato = totem.id
            } else {
                self.flagTotemImg = "TotemFalseIcon"
            }
        }
        
        //Pegar totem usuario
        for totem in Model.instance.totens! {
            if totem.idPossuinte == contato.id {
                totemIDUsuario = totem.id!
            }
        }
    }
    
}
