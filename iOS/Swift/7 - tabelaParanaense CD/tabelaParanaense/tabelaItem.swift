//
//  tabelaItem.swift
//  tabelaParanaense
//
//  Created by Fernando Cani on 7/6/15.
//  Copyright © 2015 Fernando Cani. All rights reserved.
//

import Foundation
import CoreData

class TabelaItem: NSManagedObject {
    
    @NSManaged var posicao: String
    @NSManaged var nome:    String
    @NSManaged var imagem:  String
    @NSManaged var pontos:  String
    @NSManaged var vitorias:String
    @NSManaged var empates: String
    @NSManaged var derrotas:String
    @NSManaged var saldo:   String
    
}