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
    var nome: String?
    var id: String?
    
    init(imagem: String, contatos: [Usuario]?, nome: String) {
        self.imagem = imagem
        self.contatos = contatos
        self.nome = nome
        self.id = DAOFirebase.criarUsuario(usuario: self)
        
    }
    
    init(id: String) {
        self.id = id
        //DAOFirebase load usuario/....
    }
    
    
    func mapToDictionary() -> [String: Any] {
        
        var usuarioData: [String:Any] = [:]
        
        usuarioData["imagem"] = self.imagem
        usuarioData["contatos"] = self.contatos //fazer função que pega id e retorna usuários
        usuarioData["nome"] = self.nome
        
        return usuarioData
    }
    
//    static func mapToObject(usuarioData: [String: Any]) -> Usuario {
//
//        let nome: String = usuarioData["nome"] as! String
//        let imagem: String = usuarioData["imagem"] as! String
//        let contatos: [String] = usuarioData as! [String]
//
//        let usuario = Usuario(imagem: imagem, contatos: contatos, nome: nome)
//
//        return usuario
//    }
    
    //fazer os maps
    
    
    //fazer static func que: manda o ID e retorna o Usuario.
}
