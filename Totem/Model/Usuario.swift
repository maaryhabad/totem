//
//  Usuario.swift
//  Tarantino
//
//  Created by Mariana Beilune Abad on 18/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import Foundation

class Usuario {
    var imagem: String?
    var iconeTotem: String?
    var contatos: [Usuario]?
    var contatosID: [String]?
    var nome: String?
    var id: String?
    var sentimento: String?
    
    init(id: String, imagem: String, iconeTotem: String, contatos: [Usuario]?, contatosID: [String]?, nome: String, sentimento: String?) {
        self.id = id
        self.imagem = imagem
        self.iconeTotem = iconeTotem
        self.contatos = contatos
        self.contatosID = contatosID
        self.nome = nome
        self.sentimento = sentimento
    }
    
    init(id: String) {
//        self.id = id
//        DAOFirebase.retornaUsuario(id: id)
//        DAOFirebase.retornaUsuario(userId: id){}
//        self.imagem = usrFirebase?.imagem
//        self.contatos = usrFirebase?.contatos
//        self.contatosID = usrFirebase?.contatosID
//        self.nome = usrFirebase?.nome
//        self.sentimento = usrFirebase?.sentimento
    }
    
    
    func mapToDictionary() -> [String: Any] {
        
        var usuarioData: [String:Any] = [:]
        
        usuarioData["imagem"] = self.imagem
        usuarioData["iconeTotem"] = self.iconeTotem
//        usuarioData["contatos"] = self.contatos
        usuarioData["nome"] = self.nome
        usuarioData["contatosID"] = self.contatosID
        usuarioData["sentimento"] = self.sentimento
        
        return usuarioData
    }
    
    static func mapToObject(usuarioData: [String: Any], id :String) -> Usuario {

        let nome: String = usuarioData["nome"] as! String
        let imagem: String = usuarioData["imagem"] as! String
        let iconeTotem: String = usuarioData["iconeTotem"] as! String
        let contatosID: [String] = (usuarioData["contatosID"] as? [String]) ?? []
        let contatos = [Usuario]()
        let sentimento: String = usuarioData["sentimento"] as! String
      
        
        let usuario = Usuario(id: id, imagem: imagem, iconeTotem: iconeTotem, contatos: contatos, contatosID: contatosID, nome: nome, sentimento: sentimento)
        return usuario
    }
    
    static func populaContatos(contatosID: [String]?, completionHandler: @escaping ( [Usuario] )->() ) {
        
        guard let IDList = contatosID else {return}
        
        let dispatchGroup = DispatchGroup()
        
        var contatos = [Usuario]()
        
        for contato in IDList {
            if(contato != Model.instance.usuarioId){
                dispatchGroup.enter()
                
                DAOFirebase.retornaUsuario(userId: contato) { usuario in
                    contatos.append(usuario)
                    dispatchGroup.leave()
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
           completionHandler(contatos)
        }
        
    
    }
    
    
    
}


