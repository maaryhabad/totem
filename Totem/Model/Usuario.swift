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
    
    init(imagem: String, contatos: [Usuario]?, contatosID: [String]?, nome: String) {
        self.imagem = imagem
        self.contatos = contatos
        self.contatosID = contatosID
        self.nome = nome
        
    }
    
    init(id: String) {
        self.id = id
    }
    
    
    func mapToDictionary() -> [String: Any] {
        
        var usuarioData: [String:Any] = [:]
        
        usuarioData["imagem"] = self.imagem
        usuarioData["contatos"] = self.contatos
        usuarioData["nome"] = self.nome
        usuarioData["contatosID"] = self.contatosID
        
        return usuarioData
    }
    
    static func mapToObject(usuarioData: [String: Any]) -> Usuario {

        let nome: String = usuarioData["nome"] as! String
        let imagem: String = usuarioData["imagem"] as! String
        let contatosID: [String] = (usuarioData["contatos"] as? [String]) ?? []
        let contatos = [Usuario]()
        
      
        
        let usuario = Usuario(imagem: imagem, contatos: contatos, contatosID: contatosID, nome: nome)
        print(usuario)
        return usuario
    }
    
    static func populaContatos(contatosID: [String]?, completionHandler: @escaping ([Usuario])->()) {
        
        guard let IDList = contatosID else {return}
        
        let dispatchGroup = DispatchGroup()
        
        var contatos = [Usuario]()
        
        for contato in IDList {
            dispatchGroup.enter()

            
            DAOFirebase.retornaUsuario(id: contato, comContatos: false) {
                    usuario in

                contatos.append(usuario)
                dispatchGroup.leave()

            }
        }
        
        dispatchGroup.notify(queue: .main) {
           completionHandler(contatos)
        }
        
    
    }
    
    
    
}
