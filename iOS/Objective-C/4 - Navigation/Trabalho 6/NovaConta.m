//
//  NovaConta.m
//  Trabalho 6
//
//  Created by Ronald Campanari on 4/12/15.
//  Copyright (c) 2015 Ronald Campanari. All rights reserved.
//

#import "NovaConta.h"
#import "Conta.h"
#import "ListaContas.h"

@interface NovaConta ()  {
    NSMutableArray *categs;
    BOOL categorySelected, dateSelected;
    ListaContas *lista;
    NSString *title;
}

@end

@implementation NovaConta

- (void)viewDidLoad {
    [super viewDidLoad];

    _vencimento.alpha = 0;
    _categorias.alpha = 0;
    
    categorySelected = NO;
    dateSelected = NO;
    
    //self.buttonCategoria.layer.borderWidth = 2.0f;
    //self.buttonCategoria.layer.cornerRadius = 4.0f;
    //self.buttonCategoria.backgroundColor = [UIColor clearColor];
    
    //self.buttonVencimento.layer.borderWidth = 2.0f;
    //self.buttonVencimento.layer.cornerRadius = 4.0f;
    //self.buttonVencimento.backgroundColor = [UIColor clearColor];
    
    [_textFieldNome setDelegate:self];
    [_textFieldValor setDelegate:self];
    
    [_categorias setDelegate:self];
    [_categorias setDataSource:self];
    
    categs = [[NSMutableArray alloc] init];
    
    [categs addObject:@"Alimentação"];
    [categs addObject:@"Casa"];
    [categs addObject:@"Carro"];
    [categs addObject:@"Diversos"];
    
    [self.view addSubview:_categorias];
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [_textFieldNome resignFirstResponder];
    [_textFieldValor resignFirstResponder];
    return YES;
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView  {
    
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    return [categs count];
}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSString *rowTitle = [categs objectAtIndex:row];
    
    return rowTitle;
    
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    NSInteger index = [pickerView selectedRowInComponent:0];
    title = [[pickerView delegate] pickerView:pickerView titleForRow:index forComponent:0];
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)buttonCategoria:(id)sender {
    if(!dateSelected){

//        if(self.buttonCategoria.backgroundColor == [UIColor clearColor]){
//            self.buttonCategoria.backgroundColor = [UIColor grayColor];
//        }else{
//            self.buttonCategoria.backgroundColor = [UIColor clearColor];
//        }
        
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.6];
        CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0, 10);
        _categorias.transform = transfrom;
        _categorias.alpha = _categorias.alpha * (-1) + 1;
        [UIView commitAnimations];
        
    }
    
    if(_categorias.alpha == 1)
        categorySelected = YES;
    else{
        categorySelected = NO;
        [_buttonCategoria setTitle:[title description] forState:UIControlStateNormal];
    }

}
- (IBAction)buttonVencimento:(id)sender {
    if(!categorySelected){
    
//    if(self.buttonVencimento.backgroundColor == [UIColor clearColor]){
//        self.buttonVencimento.backgroundColor = [UIColor grayColor];
//    }else{
//        self.buttonVencimento.backgroundColor = [UIColor clearColor];
//    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.6];
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0, 10);
    _vencimento.transform = transfrom;
    _vencimento.alpha = _vencimento.alpha * (-1) + 1;
    [UIView commitAnimations];
       
    }
    
    if(_vencimento.alpha == 1){
        dateSelected = YES;
    }    else  {
        dateSelected = NO;
        NSLog(@"%@", [[_vencimento date] description]);
        NSString *dia = [[[[_vencimento date] description] substringFromIndex:8] substringToIndex:2];
        NSString *mes = [[[[_vencimento date] description] substringFromIndex:5] substringToIndex:2];
        NSString *ano = [[[_vencimento date] description] substringToIndex:4];
        [_buttonVencimento setTitle:[NSString stringWithFormat:@"%@/%@/%@", dia, mes, ano] forState:UIControlStateNormal];
    }
    
}
- (IBAction)buttonSave:(id)sender {
    
    lista = [ListaContas sharedInstance];
    Conta *novaConta = [[Conta alloc] init];
    novaConta.nome = _textFieldNome.text;
    novaConta.valor = [_textFieldValor.text floatValue];
    if ([_estadoConta isOn]) {
        novaConta.paga = YES;
    } else{
        novaConta.paga = NO;
    }
    novaConta.categoria = title.description;
    novaConta.data = _vencimento.date;
    
    [lista addConta:novaConta];
    [self.presentingViewController dismissViewControllerAnimated:YES
                                                      completion:nil];
    
    
}

@end
