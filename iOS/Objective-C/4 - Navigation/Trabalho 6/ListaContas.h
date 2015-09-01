//
//  ListaContas.h
//  Trabalho 6
//
//  Created by Matheus Cassol on 09/04/15.
//  Copyright (c) 2015 Matheus Cassol. All rights reserved.
//

@class Conta;

#import <Foundation/Foundation.h>

@interface ListaContas : NSObject

+(ListaContas *)sharedInstance;


-(void)addConta:(Conta *) C;
-(NSArray *)trazContasPagas;
-(NSArray *)trazContasNaoPagas;
-(NSArray *)trazContasVencidas;
-(NSUInteger)countPagas;
-(NSUInteger)countNaoPagas;
-(NSUInteger)countVencidas;
-(void)removeConta:(int) i Tela:(NSString *)tela;
-(instancetype)initWithData;

@end
