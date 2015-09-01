//
//  ContasVencidasTableViewController.m
//  Trabalho 6
//
//  Created by Matheus Cassol on 13/04/15.
//  Copyright (c) 2015 Matheus Cassol. All rights reserved.
//

#import "ContasVencidasTableViewController.h"
#import "ListaContas.h"
#import "Conta.h"
#import "TableViewCell.h"

@interface ContasVencidasTableViewController (){
    ListaContas *listaC;
    int selectedIndex;
}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *btnTrash;

@end

@implementation ContasVencidasTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}
-(void)viewWillAppear:(BOOL)animated{
    _btnTrash.enabled = NO;
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
    return [listaC countVencidas];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contasVencidasCell" forIndexPath:indexPath];
    
    Conta* conta = [[listaC trazContasVencidas] objectAtIndex:indexPath.row];
    
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
    
    _btnTrash.enabled = NO;
    [listaC removeConta:selectedIndex Tela:@"vencida"];
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    selectedIndex = (int)indexPath.row;
    _btnTrash.enabled = YES;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
