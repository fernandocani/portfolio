//
//  QuizzGameViewController.m
//  Quizz
//
//  Created by Fernando Cani on 3/18/15.
//  Copyright (c) 2015 Fernando Cani. All rights reserved.
//

#import "QuizzGameViewController.h"
#include <stdlib.h> //rand

#define UIColorFromRGB(rgbValue) \
    [UIColor   colorWithRed:    ((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
                        green:  ((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
                        blue:   ((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
                        alpha:1.0]

@interface QuizzGameViewController () {
    //Tempo
    float       timer;
    //Score
    int         score;
    //Questoes
    int         questao;
    int         countParaEsgotarAsPerguntas;
    int         totalDePerguntas;
    NSString    *perguntas;
    NSString    *respostas;
    NSArray     *arrayPerguntas;
    NSMutableArray *indicePerguntas;
    int         questaoSorteada;
    NSArray     *arrayRespostas;
    NSArray     *indiceRespostas;
    NSString    *perguntaSelected;
    NSString    *respostaSelected;
}



@property (strong, nonatomic) IBOutlet UILabel          *lblTempo;
@property (strong, nonatomic) IBOutlet UILabel          *lblPerdeu;
@property (strong, nonatomic) IBOutlet UIProgressView   *pvTempo;
@property (strong, nonatomic) IBOutlet UILabel          *lblQuestion;
@property (strong, nonatomic) IBOutlet UILabel          *lblScore;
@property (strong, nonatomic) IBOutlet UIButton         *btnAnwser1;
@property (strong, nonatomic) IBOutlet UIButton         *btnAnwser2;
@property (strong, nonatomic) IBOutlet UIButton         *btnAnwser3;
@property (strong, nonatomic) IBOutlet UIButton         *btnAnwser4;
@property (strong, nonatomic) IBOutlet UIButton         *btnSair;

@end

@implementation QuizzGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([_perguntaEscolhidaPickerView  isEqual: @"Conhecimentos Gerais"]) {
        perguntaSelected = @"Perguntas - Conhecimentos Gerais";
        respostaSelected = @"Respostas - Conhecimentos Gerais";
    } else if ([_perguntaEscolhidaPickerView  isEqual: @"Arquivo X"]) {
        perguntaSelected = @"Perguntas - Arquivo X";
        respostaSelected = @"Respostas - Arquivo X";
    } else if ([_perguntaEscolhidaPickerView  isEqual: @"Coritiba F.C."]) {
        perguntaSelected = @"Perguntas - Coritiba";
        respostaSelected = @"Respostas - Coritiba";
    } else {
        perguntaSelected = @"Perguntas - Conhecimentos Gerais";
        respostaSelected = @"Respostas - Conhecimentos Gerais";
    }
    
    _btnAnwser1.tag = 1;
    _btnAnwser2.tag = 2;
    _btnAnwser3.tag = 3;
    _btnAnwser4.tag = 4;
    [_btnSair setTintColor:[UIColor blackColor]];
    [_lblPerdeu setHidden:YES];
    //Tempo
    timer = 10.0;
    [self lblTempo].text = [NSString stringWithFormat:@"Tempo %f", timer];
    //Score
    score = 0;
    [self lblScore].text = [NSString stringWithFormat:@"Score: %d", score];
    //Questoes
    questao = 0;
    NSError *error;
    NSBundle *bundle = [NSBundle mainBundle];
    NSArray *filesPerguntas = @[perguntaSelected];//@"Perguntas - Coritiba"];
    NSArray *filesRespostas = @[respostaSelected];
    NSString *pathPerguntas = [bundle pathForResource:[filesPerguntas objectAtIndex:questao] ofType:@".txt"];
    NSString *pathRespostas = [bundle pathForResource:[filesRespostas objectAtIndex:questao] ofType:@".txt"];
    perguntas = [[NSString alloc] initWithContentsOfFile:pathPerguntas encoding:NSUTF8StringEncoding error:&error];
    respostas = [[NSString alloc] initWithContentsOfFile:pathRespostas encoding:NSUTF8StringEncoding error:&error];
    arrayPerguntas = [perguntas  componentsSeparatedByString:@"\n"];
    arrayRespostas = [respostas  componentsSeparatedByString:@"\n"];
    
    indicePerguntas = [[NSMutableArray alloc] init];
    //Array/Dictionary não aceitam tipos primitivos (int, float, bool, nsuinteger...), somente objetos.
    NSUInteger random;
    while ([indicePerguntas count] < (int)arrayPerguntas.count) {
        random = arc4random()%(int)arrayPerguntas.count;
        if (![indicePerguntas containsObject:[NSNumber numberWithUnsignedInteger:random]]) {
            [indicePerguntas addObject:[NSNumber numberWithUnsignedInteger:random]];
        }
    }
    totalDePerguntas = -1 + (int)indicePerguntas.count;
    countParaEsgotarAsPerguntas = 0;
    [self popularInformacoes];
}

- (void)popularInformacoes {
    
    [[_btnAnwser1 titleLabel] adjustsFontSizeToFitWidth];
    [[_btnAnwser2 titleLabel] adjustsFontSizeToFitWidth];
    [[_btnAnwser3 titleLabel] adjustsFontSizeToFitWidth];
    [[_btnAnwser4 titleLabel] adjustsFontSizeToFitWidth];
    
    questaoSorteada = [indicePerguntas[totalDePerguntas - countParaEsgotarAsPerguntas] intValue];
    NSLog(@"%d", totalDePerguntas);
    NSLog(@"%d", countParaEsgotarAsPerguntas);
    NSLog(@"%d", totalDePerguntas-countParaEsgotarAsPerguntas);
    NSLog(@"%d", questaoSorteada);
    countParaEsgotarAsPerguntas++;
    if (countParaEsgotarAsPerguntas == totalDePerguntas) {
        [self deuRuim];
        return;
    }
    
    //questaoSorteada = (int)arc4random_uniform((int)arrayPerguntas.count);
    
    [self lblQuestion].text = [arrayPerguntas objectAtIndex:questaoSorteada];
    [_lblQuestion setTintColor:[UIColor whiteColor]];
    [_lblQuestion setBackgroundColor:[UIColor blueColor]];
    indiceRespostas = [[arrayRespostas objectAtIndexedSubscript:questaoSorteada]  componentsSeparatedByString:@"*"];
    
    NSMutableArray *sortedArray = [[NSMutableArray alloc] init];
    //Array/Dictinary não aceitam tipos primitivos (int, float, bool, nsuinteger...), somente objetos.
    NSUInteger random;
    while ([sortedArray count] < 4) {
        random = arc4random()%4;
        if (![sortedArray containsObject:[NSNumber numberWithUnsignedInteger:random]]) {
            [sortedArray addObject:[NSNumber numberWithUnsignedInteger:random]];
        }
    }
    NSUInteger index0 = [sortedArray[0] unsignedIntegerValue];
    NSUInteger index1 = [sortedArray[1] unsignedIntegerValue];
    NSUInteger index2 = [sortedArray[2] unsignedIntegerValue];
    NSUInteger index3 = [sortedArray[3] unsignedIntegerValue];
    
    [_btnAnwser1 setTitle:[indiceRespostas objectAtIndex:index0] forState:UIControlStateNormal];
    [_btnAnwser2 setTitle:[indiceRespostas objectAtIndex:index1] forState:UIControlStateNormal];
    [_btnAnwser3 setTitle:[indiceRespostas objectAtIndex:index2] forState:UIControlStateNormal];
    [_btnAnwser4 setTitle:[indiceRespostas objectAtIndex:index3] forState:UIControlStateNormal];
    [_btnAnwser1 setBackgroundColor:nil];
    [_btnAnwser2 setBackgroundColor:nil];
    [_btnAnwser3 setBackgroundColor:nil];
    [_btnAnwser4 setBackgroundColor:nil];
}

- (void)atualizarInformacoes {
    [self lblTempo].text = [NSString stringWithFormat:@"Tempo %f", timer];
    [self lblQuestion].text = @"";
    [self lblScore].text = [NSString stringWithFormat:@"Score: %d", score];
    [_btnAnwser1 setTitle:@"" forState:UIControlStateNormal];
    [_btnAnwser2 setTitle:@"" forState:UIControlStateNormal];
    [_btnAnwser3 setTitle:@"" forState:UIControlStateNormal];
    [_btnAnwser4 setTitle:@"" forState:UIControlStateNormal];
    [self popularInformacoes];
}

- (IBAction)btnResposta:(id)sender {
    if ([indiceRespostas indexOfObject:((UIButton*)sender).titleLabel.text] == 0) {
        score = score + 10;
        [sender setBackgroundColor:[UIColor blueColor]];
    } else {
        score = score - 10;
        [sender setBackgroundColor:[UIColor redColor]];
    }
    if (score < 0) {
        [self deuRuim];
        return;
    }
    [self atualizarInformacoes];
}

- (IBAction)btnSair:(id)sender {
    if (score > 0) {
        UIAlertController   *alertController = [UIAlertController alertControllerWithTitle:@"Sair"
                                                                                   message:@"Deseja realmente sair? Todos os dados não salvos serão perdidos."
                                                                            preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction       *actionCancel = [UIAlertAction actionWithTitle:@"Cancelar"
                                                                     style:UIAlertActionStyleCancel
                                                                   handler:nil];
        UIAlertAction       *actionOk = [UIAlertAction actionWithTitle:@"Ok"
                                                                 style:UIAlertActionStyleDefault
                                                               handler:^(UIAlertAction * action){
                                                                        [self dismissViewControllerAnimated:YES completion:nil];
                                                                        }];
        [alertController addAction:actionCancel];
        [alertController addAction:actionOk];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}

/*
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

}
*/

- (void)deuRuim {
    [_btnAnwser1 setHidden:YES];
    [_btnAnwser2 setHidden:YES];
    [_btnAnwser3 setHidden:YES];
    [_btnAnwser4 setHidden:YES];
    [_lblQuestion setHidden:YES];
    [_lblScore setHidden:YES];
    [[self view] setBackgroundColor:[UIColor blackColor]];
    
    [_btnSair setBackgroundImage:nil forState:UIControlStateNormal];//[_btnSair setBackgroundColor:[UIColor whiteColor]];
    [_btnSair setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_lblPerdeu setHidden:NO];
}
@end