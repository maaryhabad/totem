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
    var contatos: [Usuario]?
    var contatosID: [String]?
    var nome: String?
    var id: String?
    var sentimento: String?
    
    init(imagem: String, contatos: [Usuario]?, contatosID: [String]?, nome: String, sentimento: String?) {
        self.imagem = imagem
        self.contatos = contatos
        self.contatosID = contatosID
        self.nome = nome
        self.sentimento = sentimento
    }
    
    init(id: String) {
        self.id = id
        var usrFirebase = DAOFirebase.retornaUsuario(id: id)
        self.imagem = usrFirebase?.imagem
        self.contatos = usrFirebase?.contatos
        self.contatosID = usrFirebase?.contatosID
        self.nome = usrFirebase?.nome
        self.sentimento = usrFirebase?.sentimento
    }
    
    
    func mapToDictionary() -> [String: Any] {
        
        var usuarioData: [String:Any] = [:]
        
        usuarioData["imagem"] = self.imagem
//        usuarioData["contatos"] = self.contatos
        usuarioData["nome"] = self.nome
        usuarioData["contatosID"] = self.contatosID
        usuarioData["sentimento"] = self.sentimento
        
        return usuarioData
    }
    
    static func mapToObject(usuarioData: [String: Any]) -> Usuario {

        let nome: String = usuarioData["nome"] as! String
        let imagem: String = usuarioData["imagem"] as! String
        let contatosID: [String] = (usuarioData["contatos"] as? [String]) ?? []
        let contatos = [Usuario]()
        let sentimento: String = usuarioData["sentimento"] as! String
      
        
        let usuario = Usuario(imagem: imagem, contatos: contatos, contatosID: contatosID, nome: nome, sentimento: sentimento)
        print(usuario)
        return usuario
    }
    
    static func populaContatos(contatosID: [String]?, completionHandler: @escaping ( [Usuario] )->() ) {
        
        guard let IDList = contatosID else {return}
        
        let dispatchGroup = DispatchGroup()
        
        var contatos = [Usuario]()
        
        for contato in IDList {
            dispatchGroup.enter()

            
            DAOFirebase.retornaUsuario(id: contato) { usuario in

                contatos.append(usuario)
                dispatchGroup.leave()

            }
        }
        
        dispatchGroup.notify(queue: .main) {
           completionHandler(contatos)
        }
        
    
    }
    
    
    
}


