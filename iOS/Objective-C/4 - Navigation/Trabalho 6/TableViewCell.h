//
//  TableViewCell.h
//  Trabalho 6
//
//  Created by Matheus Cassol on 13/04/15.
//  Copyright (c) 2015 Matheus Cassol. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *lblTitulo;
@property (weak, nonatomic) IBOutlet UILabel *lblValor;
@property (weak, nonatomic) IBOutlet UILabel *lblCategoria;
@property (weak, nonatomic) IBOutlet UILabel *lblData;

@end