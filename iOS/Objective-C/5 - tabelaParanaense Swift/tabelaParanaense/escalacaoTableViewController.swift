//
//  escalacaoTableViewController.swift
//  tabelaParanaense
//
//  Created by Fernando Cani on 5/10/15.
//  Copyright (c) 2015 Fernando Cani. All rights reserved.
//

import UIKit
import Foundation

class escalacaoTableViewController: UITableViewController {
    
    @IBOutlet var lblClubeSelecionado: UINavigationItem!
    
    var clubeSelecionadoNaTabela: String?        //Indica qual clube foi selecionado
    var clubeSelecionado:  NSMutableArray   = [] //Array com o clube
    var splitText1: NSArray                 = [] //Pega todo o txt e quebra entre os clubes
    var splitText2: NSArray                 = [] //Pega o clube e quebra em \n
    var splitText3: NSArray                 = [] //Pega o \n e quebra em *
    var splitText4: NSArray                 = [] //Pega o indice 0 do clube e joga no Title da Navgation
    var splitText5: NSArray                 = [] //Pega o o resto dos indices do clube e joga cada um na sua célula respectiva
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        populate()
        //Nome da Tabela | NC
        splitText4                  = clubeSelecionado[0]   as! NSArray
        lblClubeSelecionado.title   = (splitText4[0]        as! String)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubeSelecionado.count - 1
    }
    
    func populate() {
        let path = NSBundle.mainBundle().pathForResource("Escalação", ofType: "txt")
        var escalacao = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
        //Quebra em |, divisões de clubes
        splitText1 = escalacao.componentsSeparatedByString("|")
        for valor in 0...(splitText1.count-1) {
            //Varre o TXT para ver se contém a String do clubeSelecionadoNaTabela, que veio de PFS
            var string = splitText1[valor] as! String
            if ((string.rangeOfString(clubeSelecionadoNaTabela!)) != nil) {
                splitText2 = splitText1.objectAtIndex(valor).componentsSeparatedByString("\n")
                for valor in 0...(splitText2.count-1) {
                    splitText3 = splitText2.objectAtIndex(valor).componentsSeparatedByString("*")
                    clubeSelecionado.addObject(splitText3)
                }
                break
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: escalacaoTableViewCell = tableView.dequeueReusableCellWithIdentifier("myCell2", forIndexPath: indexPath) as! escalacaoTableViewCell
        splitText5 = clubeSelecionado[indexPath.row + 1] as! NSArray
        cell.lblPlayerName.text     = (splitText5[0] as! String)
        cell.imgPlayer.image        = UIImage(named: (splitText5[1] as! String))
        cell.lblPlayerPosition.text = (splitText5[2] as! String)
        cell.lblPlayerNumber.text   = (splitText5[3] as! String)
        return cell
    }
}