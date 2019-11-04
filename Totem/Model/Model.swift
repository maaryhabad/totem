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
        Usuario(imagem: "Carlos.jpg", contatos: [], contatosID: ["Nj6h8ER0ZjIVHJsc9R3B","p4hxNQr9FAGXSLnrlTmn"], nome: "Carlos"),
        Usuario(imagem: "Alberto.jpg", contatos: [], contatosID: [], nome: "Alberto"),
        Usuario(imagem: "Catalina.jpg", contatos: [], contatosID: [], nome: "Catalina")

//        Usuario(imagem: "Catalina.jpg", contatos: nil, nome: "Catalina"),
//        Usuario(imagem: "Alberto.jpg", contatos: nil, nomeDoUsuario: "Alberto", idUsuario: 00002),
//        Usuario(imagem: "Carlos.jpg", contatos: [00001, 00002], nomeDoUsuario: "Carlos", idUsuario: 00003)
    ]
    
    
    var totems : [Totem] = [
        Totem(criador: nil, possuinte: nil, mensagens: nil, nome: "C2", sentimento: nil), //está com o Alberto
        Totem(criador: nil, possuinte: nil, mensagens: nil, nome: "C3", sentimento: nil) //está com a Catalina
        
//        Totem(criador: "UxzcHc7lR2YmGY0n4OEf", possuinte: "fAa4dnL8mmu8d1SgsD5u", mensagens: nil, nome: "C2", sentimento: nil), //está com o Alberto
//        Totem(criador: "UxzcHc7lR2YmGY0n4OEf", possuinte: "FWjbIyLklcHtlitiDwYx", mensagens: nil, nome: "C3", sentimento: nil) //está com a Catalina
    ]
//
//    var mensagens : [Mensagem] = [
//        Mensagem(audio: "audio01.m4a", datadeEnvio: "qualquer", de: usuarios[0], para: totems[0], salvo: true, visualizado: true)
//    ]
}

//criar os totens
//editar a lista de totens (no firebase, adicionar id no lugar de nil) - criador e possuinte
//criar as mensagens
