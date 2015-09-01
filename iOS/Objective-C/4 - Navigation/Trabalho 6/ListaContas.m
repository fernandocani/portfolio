//
//  ListaContas.m
//  Trabalho 6
//
//  Created by Matheus Cassol on 09/04/15.
//  Copyright (c) 2015 Matheus Cassol. All rights reserved.
//

#import "ListaContas.h"
#import "Conta.h"

@implementation ListaContas{
    NSMutableArray* contasPagas;
    NSMutableArray* contasNaoPagas;
    NSMutableArray* contasVencidas;
    
}

+(ListaContas *)sharedInstance{
    
    static ListaContas *_sharedInstance = nil;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{_sharedInstance = [[ListaContas alloc] initWithData];});
    
    return _sharedInstance;
}



-(instancetype)initWithData{
    self = [super init];
    if (self) {
        [self populate:@"contas.txt"];
    }
    return self;
}

//-(void)addContaPaga:(Conta*)C{
//    
//    [contasPagas addObject:C];
//    NSString *paga;
//    if (C.paga) {
//        paga = @"YES";
//    } else {
//        paga = @"NO";
//    }
//    [self writeATEndOfFile:[NSString stringWithFormat:@"%@|%f|%d|%@|%@\n", C.nome, C.valor, C.parcelas, C.data, paga] file:@"pagas.txt"];
//}
//
//-(void)addContaNaoPaga:(Conta *)C{
//    
//    [contasNaoPagas addObject:C];
//    NSString *paga;
//    if (C.paga) {
//        paga = @"YES";
//    } else {
//        paga = @"NO";
//    }
//    [self writeATEndOfFile:[NSString stringWithFormat:@"%@|%f|%d|%@|%@\n", C.nome, C.valor, C.parcelas, C.data, paga] file:@"pagar.txt"];
//}
//
//-(void)addContaVencida:(Conta *)C{
//    
//    [contasVencidas addObject:C];
//    NSString *paga;
//    if (C.paga) {
//        paga = @"YES";
//    } else {
//        paga = @"NO";
//    }
//    
//    [self writeATEndOfFile:[NSString stringWithFormat:@"%@|%f|%d|%@|%@\n", C.nome, C.valor, C.parcelas, C.data, paga] file:@"vencidas.txt"];
//}


-(void)addConta:(Conta *) C{
    NSString *paga;
    NSString *vencida;
    if (C.paga) {
        paga = @"YES";
        vencida = @"NO";
        [contasPagas addObject:C];
    } else {
        paga = @"NO";
        NSComparisonResult result = [C.data compare:[NSDate date]];
        switch (result) {
            case NSOrderedAscending:
                vencida = @"YES";
                [contasVencidas addObject:C];
                break;
            case NSOrderedDescending:
                vencida = @"NO";
                [contasNaoPagas addObject:C];
                break;
            case NSOrderedSame:
                vencida = @"NO";
                [contasNaoPagas addObject:C];
                break;
            default:
                break;
        }
    }
    [self writeATEndOfFile:[NSString stringWithFormat:@"%@|%f|%@|%@|%@|%@\n", C.nome, C.valor, C.categoria, C.data, paga, vencida] file:@"contas.txt"];

}


-(NSArray *)trazContasPagas{
    return contasPagas;
}

-(NSArray *)trazContasNaoPagas{
    return contasNaoPagas;
}

-(NSArray *)trazContasVencidas{
    return contasVencidas;
}

-(NSUInteger)countPagas{
    return contasPagas.count;
}

-(NSUInteger)countNaoPagas{
    return contasNaoPagas.count;
}

-(NSUInteger)countVencidas{
    return contasVencidas.count;
}



-(void)removeConta:(int)i Tela:(NSString*) tela{
    NSString *fileName = [self setFileName:@"contas.txt"];
    if([[NSFileManager defaultManager] fileExistsAtPath:fileName])
    {
        [[NSFileManager defaultManager] removeItemAtPath:fileName error:nil];
    }
    if ([tela isEqualToString:@"paga"]) {
        [contasPagas removeObjectAtIndex:i];
    } else if ([tela isEqualToString:@"nao paga"]){
        [contasNaoPagas removeObjectAtIndex:i];
    } else if ([tela isEqualToString:@"vencida"]){
        [contasVencidas removeObjectAtIndex:i];
    }
    [self escreveArray:contasPagas];
    [self escreveArray:contasNaoPagas];
    [self escreveArray:contasVencidas];
}


-(void)escreveArray:(NSArray *) myArray{
    
    for (Conta *thisConta in myArray) {
        NSString *paga;
        NSString *vencida;
        if (thisConta.paga) {
            paga = @"YES";
        } else{
            paga = @"NO";
        }
        if (thisConta.vencida) {
            vencida = @"YES";
        } else{
            vencida = @"NO";
        }
        [self writeATEndOfFile:[NSString stringWithFormat:@"%@|%f|%@|%@|%@|%@\n", thisConta.nome, thisConta.valor, thisConta.categoria, thisConta.data, paga, vencida] file:@"contas.txt"];
    }
}


-(void)writeATEndOfFile:(NSString *)appendedStr file:(NSString *)file
{
    NSString * fileName = [self setFileName:file];
    
    NSString *writedStr = [[NSString alloc]initWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
    if (writedStr != nil){
        writedStr = [writedStr stringByAppendingFormat:@"%@", appendedStr];
    } else{
        writedStr = appendedStr;
    }
    
    
    if([[NSFileManager defaultManager] fileExistsAtPath:fileName])
    {
        [[NSFileManager defaultManager] removeItemAtPath:fileName error:nil];
    }
    [writedStr writeToFile:fileName
                atomically:YES
                  encoding:NSStringEncodingConversionAllowLossy
                     error:nil];
    
}

-(void)populate:(NSString *)file {
    contasPagas = [[NSMutableArray alloc]init];
    contasNaoPagas = [[NSMutableArray alloc]init];
    contasVencidas = [[NSMutableArray alloc] init];
    NSString * fileName = [self setFileName:file];
    
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:fileName]){
        NSString *readStr = [[NSString alloc] initWithContentsOfFile:fileName encoding:NSUTF8StringEncoding error:nil];
        NSArray *lines = [readStr componentsSeparatedByString:@"\n"];
        for(int i = 0; i < lines.count - 1; i++) {
            NSArray *conta = [lines[i] componentsSeparatedByString:@"|"];
            Conta *thisConta = [[Conta alloc] init];
            thisConta.nome = conta[0];
            thisConta.valor = [conta [1] floatValue];
            thisConta.categoria = conta [2];
            
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss ZZZZ"];
            [thisConta  setData:[dateFormat dateFromString:(NSString*)conta[3]]];

            if ([conta [4] isEqualToString:@"YES"]){
                thisConta.paga = YES;
            } else{
                thisConta.paga = NO;
            }
            if ([conta [5] isEqualToString:@"YES"]){
                thisConta.vencida = YES;
            } else{
                thisConta.vencida = NO;
            }
            if (thisConta.paga) {
                [contasPagas addObject:thisConta];
            } else {
                if (thisConta.vencida) {
                    [contasVencidas addObject:thisConta];
                } else{
                    [contasNaoPagas addObject:thisConta];
                }
            }
        }
    }
}

-(NSString *)setFileName:(NSString *)file{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@/%@",
                          documentsDirectory, file];
    return fileName;
}



@end
