//
//  ContasAPagarTableViewController.m
//  Trabalho 6
//
//  Created by Matheus Cassol on 13/04/15.
//  Copyright (c) 2015 Matheus Cassol. All rights reserved.
//

#import "ContasAPagarTableViewController.h"
#import "ListaContas.h"
#import "Conta.h"
#import "TableViewCell.h"

@interface ContasAPagarTableViewController (){
    ListaContas *listaC;
    int selectedIndex;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *trashBtn;

@end

@implementation ContasAPagarTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _trashBtn.enabled = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)viewWillAppear:(BOOL)animated{
    
    _trashBtn.enabled = NO;
    listaC = [ListaContas sharedInstance];
    [[self tableView] reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [listaC countNaoPagas];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contasAPagarCell" forIndexPath:indexPath];
    
    Conta* conta = [[listaC trazContasNaoPagas] objectAtIndex:indexPath.row];
    
    [(TableViewCell*)cell lblTitulo].text = conta.nome;
    
    NSString *valor = [[NSString alloc] initWithFormat:@"R$ %.2f", conta.valor];
    [(TableViewCell*)cell lblValor].text = valor;
    
    [(TableViewCell*)cell lblCategoria].text = conta.categoria;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM"];
    
    NSString *stringFromDate = [formatter stringFromDate:conta.data];
    [(TableViewCell*)cell lblData].text = stringFromDate;
    
    return cell;
}

- (IBAction)trashBtnClick:(id)sender {
    
    _trashBtn.enabled = NO;
    [listaC removeConta:selectedIndex Tela:@"nao paga"];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = (int)indexPath.row;
    _trashBtn.enabled = YES;
}

@end
