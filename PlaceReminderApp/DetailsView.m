//
//  DetailsView.m
//  PlaceReminderApp
//
//  Created by zic on 16/06/2023.
//

#import "DetailsView.h"
#import "MarkerList.h"

@interface DetailsView ()
@property (strong, nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong, nonatomic) IBOutlet UILabel *DescLabel;
@property (strong, nonatomic) IBOutlet UILabel *addrLabel;
@property (strong, nonatomic) IBOutlet UIImageView *BinImage;
@property (strong, nonatomic) IBOutlet UILabel *CordsLabel;
@property (strong, nonatomic) MarkerList* list;

@end

@implementation DetailsView

@synthesize selectedMarker;
@synthesize list;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    list = [MarkerList getinstance];
    _TitleLabel.text = selectedMarker.name;
    _DescLabel.text = selectedMarker.desc;
    _addrLabel.text = selectedMarker.address;
    NSString *coordinates = [NSString stringWithFormat:@"%f, %f", selectedMarker.coordinate.latitude, selectedMarker.coordinate.longitude];
    _CordsLabel.text = coordinates;
    
    
    //bordi per le label
    [[self.DescLabel layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.DescLabel layer] setBorderWidth:2.1];
    [[self.DescLabel layer] setCornerRadius:15];
    
    [[self.addrLabel layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.addrLabel layer] setBorderWidth:2.3];
    [[self.addrLabel layer] setCornerRadius:15];
    
    [[self.CordsLabel layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.CordsLabel layer] setBorderWidth:2.3];
    [[self.CordsLabel layer] setCornerRadius:15];
    
    
    
    
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)DeleteClick:(id)sender {
    
    [self showDeletedAlert];
    
}

- (void) DeleteMarker {
    
    
    
    [list DeleteItem:[list GetMarkerIndex:selectedMarker]];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"MarkerEliminated" object:nil]; //mando una notifica che ho eliminato un marker
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)showDeletedAlert {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Attention:"
                                                                             message:@"Marker Deleted"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self DeleteMarker];
    }];
    
    [alertController addAction:okAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
