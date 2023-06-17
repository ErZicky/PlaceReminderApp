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
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detailsViewWillDisappear) name:@"DetailsViewWillDisappear" object:nil]; //creo un listener per la notifica di chiusura dei dettagli
    
   /* int t = list.GetCount;
    
    NSLog(@"%d", t);*/
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [list GetCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
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
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath { //apro la vista dei dettagli passando il Marker cliccato corrispondente
    
    NSInteger reversedIndex = [list GetCount] - indexPath.row - 1;
       
    MarkerClass *selectedMarker = [list GetItem:reversedIndex]; //prendo l'index dell'elemento cliccato tenendo a mente che la lista viene visualizzata al contrario
       
    
    // Apro la storyboard dei dettagli
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"DetailsScreen" bundle:nil];
    UIViewController *detailsViewController = [storyboard instantiateViewControllerWithIdentifier:@"DetailsView"];
    
    
    // passo il MarkerClass cliccato
        DetailsView *destinationViewController = (DetailsView *)detailsViewController;
        
        destinationViewController.selectedMarker = selectedMarker;
    
    
    [self presentViewController:detailsViewController animated:YES completion:nil];
}


 - (void) RecreateTable //aggiorno la tabella dopo che i dettagli vengono chiusi
{
    [self.tableview reloadData];
}

- (void)detailsViewWillDisappear {
    
    [self RecreateTable]; //quando ricevo rilevo la notifica di chiusura dei dettagli aggiorno la tabella in caso sia stato eliminato un marker
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
