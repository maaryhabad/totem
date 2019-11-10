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
    var flagTotemImg: String //Se este ctt tem ou ñ meu totem
    var totemIDUsuario: String
    var totemIDContato: String?
    var totem :Totem?
    
    init(contato: Usuario) {
        self.nome = contato.nome!
        self.imagem = contato.imagem!
        self.flagTotemImg = "TotemFalseIcon"
        self.totemIDUsuario = ""
        self.totemIDContato = ""
        self.totem = nil
        
        //Pegar totem usuario
        for totem in Model.instance.totens! {
            if totem.idPossuinte == contato.id {
                self.flagTotemImg = "TotemTrueIcon"
                self.totemIDUsuario = totem.id!
            }
        }
        
        //Pegar totem contato
        DAOFirebase.buscarTotem(idPossuinte: Model.instance.usuario.id!, idCriador: contato.id!){ id in
            self.totemIDContato = id
            print("Totem id: \(id)")
            if(id != ""){
                DAOFirebase.realTimeTotem(id: id){ totem in
                    self.totem = totem
                }
            }
        }
    }
    
}
