//
//  PrincipalViewController.swift
//  totem
//
//  Created by José Guilherme Bestel on 29/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import UIKit

class PrincipalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var contaInfosView: UIView!
    @IBOutlet var contaView: UIView!
    @IBOutlet var bgView: UIView!
    @IBOutlet var humorTituloView: UIView!
    @IBOutlet var humoresView: UIView!
    @IBOutlet var detalhesView: UIView!
    
    @IBOutlet var felizView: UIView!
    @IBOutlet var confianteView: UIView!
    @IBOutlet var tranquiloView: UIView!
    @IBOutlet var cansadoView: UIView!
    @IBOutlet var irritadoView: UIView!
    
    @IBOutlet var felizImg: UIImageView!
    @IBOutlet var confianteImg: UIImageView!
    @IBOutlet var tranquiloImg: UIImageView!
    @IBOutlet var cansadoImg: UIImageView!
    @IBOutlet var irritadoImg: UIImageView!
    
    @IBOutlet var contaInfoView: GradientView!
    
    var emocoesView :[UIView] = []
    var emocoesImg :[UIImageView?] = []
    
    
    var selectIndexMsg = -1
    var selectIndexEmocao = -1
    var cardContaIsOpen = Bool(true)
    
    @IBOutlet var table: UITableView!{
        didSet{
            let nibName = UINib(nibName: "ContatoTVCell", bundle: nil)
            table.register(nibName, forCellReuseIdentifier: "contatoCell")
            table.dataSource = self
            table.allowsSelection = true
            table.delegate = self
        }
        
    }
    @IBOutlet var tableMensagens: UITableView!{
        didSet{
            let nibName = UINib(nibName: "MensagemTVCell", bundle: nil)
            tableMensagens.register(nibName, forCellReuseIdentifier: "mensagemCell")
            tableMensagens.dataSource = self
            tableMensagens.allowsSelection = true
            tableMensagens.delegate = self
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Large title
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        //Left Button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "+", style: .done, target: self, action: #selector(self.action(sender:)))
        
        //Shadow in card
        contaInfosView.layer.applySketchShadow(color: UIColor.black, alpha: Float(0.09), x: CGFloat(2.0), y: CGFloat(2.0), blur: CGFloat(10.0), spread: CGFloat(0.0))
        
        //View de mensagens oculta
        detalhesView.isHidden = true
        
        //Emoções
        self.emocoesImg = [self.felizImg, self.confianteImg, self.tranquiloImg, self.cansadoImg, self.irritadoImg]
        self.emocoesView = [self.felizView, self.confianteView, self.tranquiloView, self.cansadoView, self.irritadoView]
        
        //Gesture emocoes
        felizView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector(("someAction:"))))
        confianteView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector(("someAction:"))))
        tranquiloView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector(("someAction:"))))
        cansadoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector(("someAction:"))))
        irritadoView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: Selector(("someAction:"))))
    }
    
    //Função para click numa emoção
    @objc func someAction(_ sender: UITapGestureRecognizer){
        
        let nmView = sender.view?.restorationIdentifier
        var selectedView :Int = -1
        
        if(nmView == "Feliz"){
            selectedView = 0
        }else if(nmView ==  "Confiante"){
            selectedView = 1
        }else if(nmView ==  "Tranquilo"){
            selectedView = 2
        }else if(nmView ==  "Cansado"){
            selectedView = 3
        }else if(nmView ==  "Irritado"){
            selectedView = 4
        }
        
        if(selectedView == self.selectIndexEmocao){
            self.selectIndexEmocao = -1
            self.mudarCardConta(selectedView: -1)
            
        }else{
            self.selectIndexEmocao = selectedView
            self.mudarCardConta(selectedView: selectedView)
        }
    }
    
    func mudarCardConta(selectedView :Int){
        //Foreach nos icons e deixar preto apenas o selecionado
        for index in 0..<self.emocoesView.count{
            let view = self.emocoesView[index]
            let identifier = view.restorationIdentifier
            
            let imgView = self.emocoesImg[index]
            
            if(index == selectedView){
                imgView!.image = UIImage(named: "\(identifier!)Selecionado")
            }else{
                imgView!.image = UIImage(named: identifier!)
            }
        }
        
        //Mudar a cor do card
        let amareloX = #colorLiteral(red: 0.9930667281, green: 0.9711793065, blue: 0, alpha: 1)
        let amareloY = #colorLiteral(red: 0.8069227141, green: 0.605541353, blue: 0.001397269817, alpha: 1)
        
        let azulX = #colorLiteral(red: 0.2394615939, green: 0.5985017667, blue: 1, alpha: 1)
        let azulY = #colorLiteral(red: 0.2802936715, green: 0.3074454975, blue: 0.7883472621, alpha: 1)
        
        let verdeX = #colorLiteral(red: 0.2432119415, green: 1, blue: 0.349971955, alpha: 1)
        let verdeY = #colorLiteral(red: 0.1078010393, green: 0.7889236992, blue: 0, alpha: 1)
        
        let roxoX = #colorLiteral(red: 0.7977316976, green: 0.3991055914, blue: 0.6926496238, alpha: 1)
        let roxoY = #colorLiteral(red: 0.5898076296, green: 0.2702057064, blue: 0.6506463289, alpha: 1)
        
        let vermelhoX = #colorLiteral(red: 0.9810246825, green: 0.5891146064, blue: 0.2307883501, alpha: 1)
        let vermelhoY = #colorLiteral(red: 0.9276855588, green: 0.2729465365, blue: 0.3393034637, alpha: 1)
        
        switch selectedView {
        case 0:
            self.contaInfoView.changeColors(x: amareloX, y: amareloY)
        case 1:
            self.contaInfoView.changeColors(x: azulX, y: azulY)
        case 2:
            self.contaInfoView.changeColors(x: verdeX, y: verdeY)
        case 3:
            self.contaInfoView.changeColors(x: roxoX, y: roxoY)
        case 4:
            self.contaInfoView.changeColors(x: vermelhoX, y: vermelhoY)
        default:
            self.contaInfoView.changeColors(x: UIColor.white, y: UIColor.white)
        }
//        let gradient: CAGradientLayer = CAGradientLayer()
//
//        gradient.colors = [UIColor.blue.cgColor, UIColor.red.cgColor]
//        gradient.locations = [0.0 , 1.0]
//        gradient.startPoint = CGPoint(x: 0.0, y: 1.0)
//        gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
//        gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.contaInfoView.frame.size.height)

        
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("numberOfSections -> \(String(describing: tableView.restorationIdentifier))")
        if(tableView.restorationIdentifier == "tableGravacoes"){
            return 1
        }
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection -> \(String(describing: tableView.restorationIdentifier))")
        if(tableView.restorationIdentifier == "tableGravacoes"){
        return 5
        }
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt -> \(String(describing: tableView.restorationIdentifier))")
        if(tableView.restorationIdentifier == "tableGravacoes"){
            let cell = tableView.dequeueReusableCell(withIdentifier: "mensagemCell", for: indexPath) as! MensagemTVCell
            
            cell.nomeLabel.text = "ELVIN"
            cell.dataLabel.text = "quinta-feira"
            cell.tempoLabel.text = "00:53"
            cell.isNew()
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "contatoCell", for: indexPath) as! ContatoTVCell
        cell.nome.text = "Elvin Sharvill"
        cell.imagem.image = UIImage(named: "contatoElvin")
        cell.totemIcon.image = UIImage(named: "TotemTrueIcon")

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt -> \(String(describing: tableView.restorationIdentifier))")
        
        if(tableView.restorationIdentifier == "tableGravacoes"){
            let cell = tableView.cellForRow(at: indexPath) as! MensagemTVCell
            
            if( self.selectIndexMsg != indexPath.row){
                self.selectIndexMsg = indexPath.row
                cell.detalhesGravacaoView.isHidden = false
            }else{
                self.selectIndexMsg = -1
                cell.detalhesGravacaoView.isHidden = true
            }
            
            let _ = self.tableView(tableView, heightForRowAt: indexPath)
            tableView.beginUpdates()
            tableView.endUpdates()
        }else{
            self.openCloseContaView()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print("heightForRowAt -> \(String(describing: tableView.restorationIdentifier))")
        if(tableView.restorationIdentifier == "tableGravacoes"){
            if(selectIndexMsg == indexPath.row){
                return 150.0
            }else{
                if(selectIndexMsg != -1){
                    if tableView.cellForRow(at: indexPath) is MensagemTVCell{
                        let cell = tableView.cellForRow(at: indexPath) as! MensagemTVCell
                        cell.detalhesGravacaoView.isHidden = true
                    }
                    
                }
                return 55.0
            }
        }
        
        return 80.0
    }
    
    
    //Definir para qual tela irá no +
    //TODO: Fazer uma  segue@objc
    @objc func action(sender: UIBarButtonItem) {
        print("hjxdbsdhjbv")
    }
    
    func fadeAnimationView(view :UIView, isHidden :Bool){
        UIView.animate(withDuration: 0.33, animations: {
            if(isHidden){
                view.alpha = 0.0
            }else{
                view.alpha = 1.0
            }
            view.isHidden = isHidden
        })
    }
    
    
    
    
    
    
    @IBAction func returnContatos(_ sender: Any) {
        self.selectIndexMsg = -1
        self.tableView(self.tableMensagens, heightForRowAt: self.tableMensagens.indexPathForSelectedRow!)
        let cell = self.tableMensagens.cellForRow(at: self.tableMensagens.indexPathForSelectedRow!) as! MensagemTVCell
        cell.detalhesGravacaoView.isHidden = true
        self.tableMensagens.beginUpdates()
        self.tableMensagens.endUpdates()
        self.openCloseContaView()
    }
    
    
    func openCloseContaView() {

        var multi :CGFloat
        var alpha :CGFloat
        var flagHidden :Bool
        
        //Identificar a constraint correta e aplicar a alternância da porcentagem
        for constr in bgView.constraints{
            if(constr.identifier == "propHeightContaView"){
                if constr.multiplier > CGFloat(0.40){
                    multi = CGFloat(0.27)
                    alpha = 0.0
                    flagHidden = true
                    self.cardContaIsOpen = false
                }else{
                    multi = CGFloat(0.45)
                    alpha = 1.0
                    flagHidden = false
                    self.cardContaIsOpen = true
                }
                
                if(flagHidden){
                    //1 humor dps contaView
                    self.efectHumor(alpha: alpha, flagHidden: flagHidden, multi: multi, constr :constr)
//                    detalhesView.isHidden = false
                    self.fadeAnimationView(view: detalhesView, isHidden: false)
                    table.isHidden = true
                }else{
                    //1 contaView dps humor
                    self.efectContaView(alpha: alpha, flagHidden: flagHidden, multi: multi, constr :constr)
//                    detalhesView.isHidden = true
                    self.fadeAnimationView(view: detalhesView, isHidden: true)
                    table.isHidden = false
                }
            }
        }
    }
    

    func efectHumor(alpha :CGFloat, flagHidden :Bool, multi  :CGFloat, constr :NSLayoutConstraint){
        UIView.animate(withDuration: 0.2,
                        delay: 0.0,
                        options: .curveEaseIn,
                        animations: {
                            if(flagHidden){
                                self.efectContaView(alpha: alpha, flagHidden: flagHidden, multi: multi, constr :constr)
                            }
                            
                            self.humorTituloView.alpha = alpha
                            self.humoresView.alpha = alpha
        }, completion: {(finished:Bool) in
        
        })
    }
    
    func efectContaView(alpha :CGFloat, flagHidden :Bool, multi  :CGFloat, constr :NSLayoutConstraint){
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.0,
                       options: .curveEaseIn,
                       animations: {
                         let newConstraint = constr.constraintWithMultiplier(multi)
                        newConstraint.identifier = constr.identifier
                        self.bgView.removeConstraint(constr)
                        self.bgView.addConstraint(newConstraint)
                        
                        self.bgView.layoutIfNeeded()
        }, completion: {(finished:Bool) in
            if(!flagHidden){
                self.efectHumor(alpha: alpha, flagHidden: flagHidden, multi: multi, constr :constr)
            }
        })
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
