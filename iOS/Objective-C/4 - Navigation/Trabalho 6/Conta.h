//
//  Conta.h
//  Trabalho 6
//
//  Created by Matheus Cassol on 09/04/15.
//  Copyright (c) 2015 Matheus Cassol. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Conta : NSObject

@property NSString *nome;
@property float valor;
@property NSString  *categoria;
@property NSDate *data;
@property BOOL paga;
@property BOOL vencida;

@end
