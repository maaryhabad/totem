//
//  ContatosViewController.swift
//  totem
//
//  Created by Mariana Beilune Abad on 30/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import UIKit

class ContatosViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addBottomSheetView()
    }
    
    
    //Adicionar a view
    func addBottomSheetView() {
        // 1- Init bottomSheetVC
        let bottomSheetVC = BottomSheetViewController()

        // 2- Add bottomSheetVC as a child view
        self.addChild(bottomSheetVC)
        self.view.addSubview(bottomSheetVC.view)
        bottomSheetVC.didMove(toParent: self)

        // 3- Adjust bottomSheet frame and initial position.
        let height = view.frame.height
        let width  = view.frame.width
        bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY, width: width, height: height)
    }
    
    @IBAction func gravarUsuario(_ sender: Any) {
        var usuarios: [Usuario] = []
//        
//        for usuario in Model.instance.usuarios {
//            usuarios.append(usuario)
//            DAOFirebase.criarUsuario(usuario: usuario)
//        }
//        
        print(usuarios)
        
    }
    
    @IBAction func retornaUsuario(_sender: Any) {
        print("clicounoBotão")
        
        //Aqui no bloco(closure) define o que acontece no CompletionHandler do retornaUsuario
        DAOFirebase.retornaUsuario(id: "UxzcHc7lR2YmGY0n4OEf") { u in
            var usuario: Usuario
            usuario = u
            print(usuario)
        }
    }
    
    @IBAction func criarTotem(_sender: Any) {
        var totems: [Totem] = []
        
        for totem in Model.instance.totens! {
            totems.append(totem)
            DAOFirebase.criarTotem(totem: totem)
        }
        print(totems)
    }
    
    @IBAction func retornaTotem(_sender: Any) {
       
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
