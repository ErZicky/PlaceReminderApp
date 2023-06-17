//
//  ViewController.m
//  PlaceReminderApp
//  comment
//  Daniele Ziaco Matricola: 317310
//

#import "ViewController.h"
#import "MarkerClass.h"
#import "MarkerList.h"
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *TestLabel;
@property (strong, nonatomic) MarkerList* _list;
@property (weak, nonatomic) IBOutlet UITextField *CoordinateText;
@property (weak, nonatomic) IBOutlet UITextField *IdText;
@property (weak, nonatomic) IBOutlet UITextView *DescText;

@property (strong, nonatomic) IBOutlet UILabel *ErrorLabel;
@property (strong, nonatomic) IBOutlet UIView *BackgroundView;

@end

@implementation ViewController

@synthesize _list;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.DescText.delegate = self;

    
    //bordi per la textview
    [[self.DescText layer] setBorderColor:[[UIColor grayColor] CGColor]];
    [[self.DescText layer] setBorderWidth:2.3];
    [[self.DescText layer] setCornerRadius:15];
    
    _list = [MarkerList getinstance];
    
    self.DescText.delegate = self;
    self.CoordinateText.delegate = self;;
    self.IdText.delegate = self;
    // Do any additional setup after loading the view.
}


- (void)textViewDidBeginEditing:(UITextView *)textView {
    textView.text = @"";
}


- (IBAction)SaveMarkerClick:(id)sender {
    
    
    //controllo se ciò che è scritto nella textbox sono coordinate o un indirizzo e agisco di conseguenza per fare in modo di avere sia un indirizzo e delle coordinate per l'elemento aggiunto
    
    NSString *input = _CoordinateText.text;
    
    //uso le espressioni regolari per capire se la stringa è una coordinata o un indirizzo
    NSRegularExpression *coordinateRegex = [NSRegularExpression regularExpressionWithPattern:@"^\\s*-?\\d+(\\.\\d+)?\\s*,\\s*-?\\d+(\\.\\d+)?\\s*$" options:0 error:nil];
    

    NSTextCheckingResult *coordinateMatch = [coordinateRegex firstMatchInString:input options:0 range:NSMakeRange(0, input.length)];
    __block CLLocationCoordinate2D cords;
    __block NSString *addr;
    
    if (coordinateMatch) //se la stringa corrisponde al formato xx.xxxxx, xx.xxxxx sono coordinate
    {

        NSString *coordinatesString = [input stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSArray *coordinatesComponents = [coordinatesString componentsSeparatedByString:@","];
        
        if (coordinatesComponents.count >= 2) {
            double latitude = [coordinatesComponents[0] doubleValue];
            double longitude = [coordinatesComponents[1] doubleValue];
            cords = CLLocationCoordinate2DMake(latitude, longitude);
            
            //converto coordinate in indirizzo
            
            CLLocation *location = [[CLLocation alloc] initWithLatitude:cords.latitude longitude:cords.longitude];
            CLGeocoder *geocoder = [[CLGeocoder alloc] init];
            [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error) {
                if (error) {
                    NSLog(@"Error in reverse geocoding: %@", error.localizedDescription);
                    
                    self->_ErrorLabel.text = @"Qualcosa è andato storto";
                    return;
                }
                
                if (placemarks.count > 0) {
                    CLPlacemark *placemark = placemarks.firstObject;
                    NSString *address = [self formatAddressFromPlacemark:placemark];
                    addr = address;
                    NSLog(addr);
                    
                    //creo marker e lo aggiungo alla lista
                    MarkerClass *_Marker = [[MarkerClass alloc] initWithElements:cords name:_IdText.text desc:_DescText.text address:addr date:[NSDate date]];
                 
                    if(self->_list != nil)
                    {
                        [self._list AddItem:_Marker];
                    }
                    
                    
                    _IdText.text = @"";
                    _DescText.text = @"";
                    _CoordinateText.text = @"";
                    _ErrorLabel.text =@"            ";
                    
                }
            }];
                      
        }
    }
    else
    {
        //else if (addressMatch)
        //è un indirizzo
        
        //converto coordinate in indirizzo
       addr = input;
        NSLog(@"indirizzo scritto: %@", addr);
        
        CLGeocoder *geocoder = [[CLGeocoder alloc] init];
        [geocoder geocodeAddressString:addr completionHandler:^(NSArray<CLPlacemark *> *placemarks, NSError *error) {
            if (error) {
                NSLog(@"Errore nella geocodifica: %@", error.localizedDescription);
                self->_ErrorLabel.text = @"Qualcosa è andato storto";
                return;
            }
            
            if (placemarks.count > 0) {
                CLPlacemark *placemark = placemarks.firstObject;
                CLLocation *location = placemark.location;
                CLLocationCoordinate2D ExtrapoletedCoordinate = location.coordinate;
                cords = ExtrapoletedCoordinate;
                NSLog(@"Latitude: %f, Longitude: %f", cords.latitude, cords.longitude);
                
                
                //creo marker e lo aggiungo alla lista
                MarkerClass *_Marker = [[MarkerClass alloc] initWithElements:cords name:_IdText.text desc:_DescText.text address:addr date:[NSDate date]];

             
                if(_list != nil)
                {
                    [self._list AddItem:_Marker];
                }
                
           
                _IdText.text = @"";
                _DescText.text = @"";
                _CoordinateText.text = @"";
                _ErrorLabel.text =@"            ";
            }
        }];
        
        
    }
    
    
    
    
   

  
    
    

    
}




- (IBAction)ToMapClicked:(id)sender { //apri la mappa
    
    
   UIStoryboard *mapStoryboard = [UIStoryboard storyboardWithName:@"MapView" bundle:nil];
    UIViewController *specificViewController = [mapStoryboard instantiateViewControllerWithIdentifier:@"MapClassViewController"];
       [self presentViewController:specificViewController animated:YES completion:nil];
    
    
    
    
}


- (NSString *)formatAddressFromPlacemark:(CLPlacemark *)placemark { //formatta l'indirizzo partendo dalle coordinate
    NSMutableString *address = [NSMutableString string];
    
    if (placemark.thoroughfare) {
        [address appendString:placemark.thoroughfare];
    }
    
    if (placemark.subThoroughfare) {
        [address appendFormat:@", %@", placemark.subThoroughfare];
    }
    
    if (placemark.locality) {
        [address appendFormat:@", %@", placemark.locality];
    }
    
    if (placemark.postalCode) {
        [address appendFormat:@", %@", placemark.postalCode];
    }
    
    if (placemark.country) {
        [address appendFormat:@", %@", placemark.country];
    }
    
    return [address copy];
}


- (IBAction)unwindToMain:(UIStoryboardSegue *)uiwindSegue{
    
    
    
}



- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    [self.view endEditing:YES];
    
}



@end
