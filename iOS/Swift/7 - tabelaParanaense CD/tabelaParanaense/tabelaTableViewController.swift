//
//  tabelaTableViewController.swift
//  tabelaParanaense
//
//  Created by Fernando Cani on 5/10/15.
//  Copyright (c) 2015 Fernando Cani. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class tabelaTableViewController: UITableViewController, CLLocationManagerDelegate {
    var clubes:     NSMutableArray      = [] //Todas as informações do .txt
    var splitText1: NSArray             = [] //Quebra em \n o .txt
    var splitText2: NSArray             = [] //Quebra em * o \n
    var splitText3: NSArray             = [] //Popula o array de células
    var splitText4: NSMutableArray      = [] //Popula o array de células
    var clubesCell: NSMutableArray      = [] //Array de células
    var clubesList: NSMutableArray      = [] //Array de Nomes dos Clubes
    private var clubeSelected: String   = "" //String para passar a informação para o PFS
    var colocacao: String               = ""//"coritiba.png*Coritiba*26*8*2*1*11\njmalucelli.png*JMalucelli*23*7*2*2*8\noperario.png*Operário PR*20*6*2*3*7\nmaringa.png*Maringá*20*6*2*3*4\nlondrina.png*Londrina*18*5*3*3*6\nparana.png*Paraná*18*5*2*3*4\nfozdoiguacu.png*Foz do Iguaçu*17*5*5*4*0\ncascavel.png*FC Cascavel*14*3*2*3*-1\natleticopr.png*Atlético PR*11*3*1*6*2\nriobranco.png*Rio Branco PR*10*3*1*7*-6\nnacional.png*Nacional PR*4*1*1*9*-17\nprudentopolis.png*Prudentópolis*3*0*3*8*-18"
    
    //CoreData
    let managedObjectContext            = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    let fetchRequest                    = NSFetchRequest(entityName: "TabelaItem")
    let sortDescriptor                  = NSSortDescriptor(key: "posicao", ascending: true, selector: "localizedStandardCompare:")
    //let sortDescriptor                  = NSSortDescriptor(key: "posicao", ascending: true)
    var fetchResults: NSArray           = []
    var tabelaItems                     = [TabelaItem]()
    var resultsCount: NSInteger         = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        populate()
        populateSQL()
        fetchResultsCount()
        populateCell()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubesCell.count
    }
    
    func fetchResultsCount() {
        fetchRequest.returnsObjectsAsFaults = false
        do {
            fetchResults = try managedObjectContext.executeFetchRequest(fetchRequest)
            if (fetchResults.count > 0) {
                resultsCount = fetchResults.count
            } else {
                print("0 results.")
            }
        } catch {
            print(error)
        }
    }
    
    func populate() {
        do {
            let path = NSBundle.mainBundle().pathForResource("Colocação", ofType: "txt")
            let colocacao = try String(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
            print(colocacao)
            //Quebra em |, divisões de clubes
            splitText1 = colocacao.componentsSeparatedByString("\n")
            for valor in 0...(splitText1.count-1) {
                splitText2 = splitText1.objectAtIndex(valor).componentsSeparatedByString("*")
                clubes.addObject(splitText2)
            }
        } catch {
            print(error)
        }
        
        
//        splitText1 = colocacao.componentsSeparatedByString("\n")
//        for valor in 0...(splitText1.count-1) {
//            splitText2 = splitText1.objectAtIndex(valor).componentsSeparatedByString("*")
//            clubes.addObject(splitText2)
//        }
    }
    
    func populateSQL() {
        do {
            fetchResults = try managedObjectContext.executeFetchRequest(fetchRequest)
            if (fetchResults.count == 0) {
                print("Entrooooou!")
                for valor in 0...(clubes.count-1) {
                    splitText3 = clubes[valor] as! NSArray
                    let newItem = NSEntityDescription.insertNewObjectForEntityForName("TabelaItem", inManagedObjectContext: self.managedObjectContext) as! TabelaItem
                    newItem.setValue(String(valor + 1),          forKey: "posicao")
                    newItem.setValue((splitText3[0] as! String), forKey: "imagem")
                    newItem.setValue((splitText3[1] as! String), forKey: "nome")
                    newItem.setValue((splitText3[2] as! String), forKey: "pontos")
                    newItem.setValue((splitText3[3] as! String), forKey: "vitorias")
                    newItem.setValue((splitText3[4] as! String), forKey: "empates")
                    newItem.setValue((splitText3[5] as! String), forKey: "derrotas")
                    newItem.setValue((splitText3[6] as! String), forKey: "saldo")
                    do {
                        try managedObjectContext.save()
                        print(newItem)
                    } catch {
                        print(error)
                    }
                }
            }
        } catch {
            print(error)
        }
    }
    
    func populateCell() {
        for valor in 0...(resultsCount) {
            do {
                let cell: tabelaTableViewCell = tableView.dequeueReusableCellWithIdentifier("myCell") as! tabelaTableViewCell
                if valor == 0 {
                    cell.userInteractionEnabled = false
                    cell.lblPosition.text   = "POS"
                    cell.lblClub.text       = "Clube"
                    cell.lblPoints.text     = "PTS"
                    cell.lblVictories.text  = "V"
                    cell.lblDraw.text       = "E"
                    cell.lblLoses.text      = "D"
                    cell.lblGoals.text      = "SG"
                } else {
                    fetchRequest.sortDescriptors = [sortDescriptor]
                    fetchResults = try managedObjectContext.executeFetchRequest(fetchRequest)
                    tabelaItems = fetchResults as! [TabelaItem]
                    cell.userInteractionEnabled = true
                    if ((valor) > 8) {
                        cell.lblPosition.textColor = UIColor.redColor()
                    } else if ((valor) > 0){
                        cell.lblPosition.textColor = UIColor.blueColor()
                    }
                    if ((valor) > 0) {
                        cell.lblPosition.text = tabelaItems[valor-1].posicao
                        cell.imgShield.image = UIImage(named: (tabelaItems[valor-1].imagem as String))
                    }
                    cell.lblClub.text       = tabelaItems[valor-1].nome
                    cell.lblPoints.text     = tabelaItems[valor-1].pontos
                    cell.lblVictories.text  = tabelaItems[valor-1].vitorias
                    cell.lblDraw.text       = tabelaItems[valor-1].empates
                    cell.lblLoses.text      = tabelaItems[valor-1].derrotas
                    cell.lblGoals.text      = tabelaItems[valor-1].saldo
                    clubesList.addObject(tabelaItems[valor-1].nome)
                }
                clubesCell.addObject(cell)
            } catch {
                print(error)
            }
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return clubesCell[indexPath.row] as! UITableViewCell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.row > 0) {
            clubeSelected = (clubesList[indexPath.row-1] as! String)
            performSegueWithIdentifier("tabelaParaJogadores", sender: self)
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "tabelaParaJogadores") {
            let proximaTela : escalacaoTableViewController! = segue.destinationViewController as! escalacaoTableViewController
            proximaTela.clubeSelecionadoNaTabela = clubeSelected
        }
    }
}