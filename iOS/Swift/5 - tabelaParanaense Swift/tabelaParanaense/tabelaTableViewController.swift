//
//  tabelaTableViewController.swift
//  tabelaParanaense
//
//  Created by Fernando Cani on 5/10/15.
//  Copyright (c) 2015 Fernando Cani. All rights reserved.
//

import UIKit
import CoreLocation


class tabelaTableViewController: UITableViewController, CLLocationManagerDelegate {
    var clubes:     NSMutableArray      = [] //Todas as informações do .txt
    var splitText1: NSArray             = [] //Quebra em \n o .txt
    var splitText2: NSArray             = [] //Quebra em * o \n
    var splitText3: NSArray             = [] //Popula o array de células
    var clubesCell: NSMutableArray      = [] //Array de células
    var clubesList: NSMutableArray      = [] //Array de Nomes dos Clubes
    private var clubeSelected: String   = "" //String para passar a informação para o PFS
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        populate()
        populateCell()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return splitText1.count
    }
    
    func populate() {
        let path = NSBundle.mainBundle().pathForResource("Colocação", ofType: "txt")
        var colocacao = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)
        splitText1 = colocacao!.componentsSeparatedByString("\n")
        for valor in 0...(splitText1.count-1) {
            splitText2 = splitText1.objectAtIndex(valor).componentsSeparatedByString("*")
            clubes.addObject(splitText2)
        }
    }
    
    func populateCell() {
        for valor in 0...(clubes.count-1) {
            let cell: tabelaTableViewCell = tableView.dequeueReusableCellWithIdentifier("myCell") as! tabelaTableViewCell
            if (valor == 0) {
                cell.userInteractionEnabled = false
            }
            splitText3 = clubes[valor] as! NSArray
            cell.lblPosition.text = (splitText3[0] as! String)
            if ((valor) > 8) {
                cell.lblPosition.textColor = UIColor.redColor()
            } else if ((valor) > 0){
                cell.lblPosition.textColor = UIColor.blueColor()
            }
            if ((valor) > 0) {
                cell.imgShield.image = UIImage(named: (splitText3[1] as! String))
            }
            cell.lblClub.text       = (splitText3[2] as! String)
            clubesList.addObject(cell.lblClub.text!)
            cell.lblPoints.text     = (splitText3[3] as! String)
            cell.lblVictories.text  = (splitText3[4] as! String)
            cell.lblDraw.text       = (splitText3[5] as! String)
            cell.lblLoses.text      = (splitText3[6] as! String)
            cell.lblGoals.text      = (splitText3[7] as! String)
            clubesCell.addObject(cell)
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return clubesCell[indexPath.row] as! UITableViewCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (indexPath.row > 0) {
            clubeSelected = (clubesList[indexPath.row] as! String)
            performSegueWithIdentifier("tabelaParaJogadores", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "tabelaParaJogadores") {
            var proximaTela : escalacaoTableViewController! = segue.destinationViewController as! escalacaoTableViewController
            proximaTela.clubeSelecionadoNaTabela = clubeSelected
        }
    }
}