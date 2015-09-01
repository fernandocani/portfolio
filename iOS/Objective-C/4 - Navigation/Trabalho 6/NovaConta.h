//
//  NovaConta.h
//  Trabalho 6
//
//  Created by Ronald Campanari on 4/12/15.
//  Copyright (c) 2015 Ronald Campanari. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NovaConta : UIViewController <UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIPickerView *categorias;
@property (weak, nonatomic) IBOutlet UIDatePicker *vencimento;
@property (weak, nonatomic) IBOutlet UISwitch *estadoConta;
@property (weak, nonatomic) IBOutlet UITextField *textFieldNome;
@property (weak, nonatomic) IBOutlet UITextField *textFieldValor;
@property (weak, nonatomic) IBOutlet UIButton *buttonCategoria;
@property (weak, nonatomic) IBOutlet UIButton *buttonVencimento;

@end
