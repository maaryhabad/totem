//
//  PrincipalTableVC.swift
//  totem
//
//  Created by José Guilherme Bestel on 29/10/19.
//  Copyright © 2019 Mariana Beilune Abad. All rights reserved.
//

import UIKit

struct cellData{
    var opened :Bool
    var title :String
    var sectionData :[String]
}

class PrincipalTableVC: UITableViewController {
    
    var tableViewData :[cellData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Definir a XIB como célula desta table
        let nibName = UINib(nibName: "ContatoTVCell", bundle: nil)
        self.tableView.register(nibName, forCellReuseIdentifier: "contatoCell")
        self.tableView.dataSource = self
        
        //Large title
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        //Left Button
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "+", style: .done, target: self, action: #selector(self.action(sender:)))
        
        tableViewData = [cellData(opened: false, title: "Title1", sectionData: ["cell1","cell2","cell3"]),
                         cellData(opened: false, title: "Title2", sectionData: ["cell1","cell2","cell3"]),
                         cellData(opened: false, title: "Title3", sectionData: ["cell1","cell2","cell3"]),
                         cellData(opened: false, title: "Title4", sectionData: ["cell1","cell2","cell3"])]
    }
    
    
    @objc func action(sender: UIBarButtonItem) {
        print("hjxdbsdhjbv")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tableViewData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableViewData[section].opened == true{
            return tableViewData[section].sectionData.count + 1
        }else{
            return 1
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "contatoCell", for: indexPath) as! ContatoTVCell
        cell.nome.text = "Elvin Sharvill"
        cell.imagem.image = UIImage(named: "contatoElvin")
        cell.totemIcon.image = UIImage(named: "TotemTrueIcon")
//        cell.separatorInset = UIEdgeInsets.zero
//        cell.layoutMargins = UIEdgeInsets.zero

        
        return cell
        
//        let dataIndex = indexPath.row - 1
//        if  indexPath.row == 0{
//            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
//            cell.textLabel?.text = tableViewData[indexPath.section].title
//            return cell
//
//
//        }else{
//            //Use differente cell identifier
//            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {return UITableViewCell()}
//            cell.textLabel?.text = tableViewData[indexPath.section].sectionData[dataIndex]
//            return cell
//        }

    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            if tableViewData[indexPath.section].opened == true{
                tableViewData[indexPath.section].opened =  false
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }else{
                tableViewData[indexPath.section].opened =  true
                let sections = IndexSet.init(integer: indexPath.section)
                tableView.reloadSections(sections, with: .none)
            }
        }
    }
        
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
