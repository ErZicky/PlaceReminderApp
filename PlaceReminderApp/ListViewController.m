//
//  ListViewController.m
//  PlaceReminderApp
//
//  Created by zic on 14/06/2023.
//

#import "ListViewController.h"
#import "MarkerList.h"
#import "MarkerClass.h"
#import "DetailsView.h"

@interface ListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableview;
@property (strong, nonatomic) MarkerList* list;
@end

@implementation ListViewController
@synthesize  list;
@synthesize tableview;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    list = [MarkerList getinstance];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MarkerWasDeleted) name:@"MarkerEliminated" object:nil]; //creo un listener per la notifica di eliminazione marker
    
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [list GetCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath { //creo le celle
    static NSString *cellIdentifier = @"MarkerCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    
    NSInteger reversedIndex = [list GetCount] - indexPath.row - 1; //flippo la lista per avere l'ultimo elemento aggiunto in cima
    MarkerClass *marker = [list GetItem:reversedIndex];
    cell.textLabel.text = marker.name;
    cell.detailTextLabel.text = [self stringFromDate:marker.date];
    
    return cell;
}

- (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd-MM-yyyy HH:mm"];
    return [dateFormatter stringFromDate:date];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath { //aggiungo DetailsView al navigation controller programmaticamente
    
    NSInteger reversedIndex = [list GetCount] - indexPath.row - 1;
       
       
    
    // Apro la schermata dei dettagli
    UIViewController *detailsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsView"];
    
    
    
    DetailsView *DSV = (DetailsView *)detailsViewController;
    [DSV setSelectedMarkerIndex:reversedIndex]; //tramite il suo setter passo l'index del marker corrispondente alla cella a detailsview
    
    [self.navigationController pushViewController:detailsViewController animated:YES]; //effettuo il push della schermata dei dettagli sullo stack
}


/*- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{ //preparo il segue
    
    if([[segue identifier] isEqual:@"DetailsView"])
    {
        DetailsView *DSV = [segue destinationViewController];
        [DSV setSelectedMarkerIndex:indexselected];
    }
    
}*/


 - (void) RecreateTable //aggiorno la tabella dopo che i dettagli vengono chiusi
{
    [self.tableview reloadData];
}

- (void)MarkerWasDeleted {
    
    [self RecreateTable]; //quando ricevo la notifica di eliminazione di un marker aggiorno la tabella
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
