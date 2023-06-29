//
//  MapClassViewController.m
//  PlaceReminderApp
//
//  Created by zic on 13/06/2023.
//

#import "MapClassViewController.h"
#import "MarkerList.h"
#import <CoreLocation/CoreLocation.h>
#import "DetailsView.h"
@interface MapClassViewController ()

@property (strong, nonatomic) MarkerList* list;

@end

@implementation MapClassViewController

@synthesize mapview;    
@synthesize  list;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    list = [MarkerList getinstance];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(MarkerWasDeleted) name:@"MarkerEliminated" object:nil]; //creo un listener per la notifica di eliminazione marker
    
    mapview.delegate = self;
    
    //impostazioni iniziali della mappa
    MKCoordinateRegion region = { {0.0, 0.0}, {0.0, 0.0}};
    region.center.latitude = 44.801485;
    region.center.longitude = 10.3279036;
    region.span.longitudeDelta = 0.1f;
    region.span.latitudeDelta = 0.1f;
    [mapview setRegion:region animated:YES];
    
    
    
    [self CreateAnnotations];
 

}


- (void) CreateAnnotations
{
    // elimino pins già presenti prima di crearne di nuovi
    NSArray *allAnnotations = mapview.annotations;


    [mapview removeAnnotations:allAnnotations];
    
    
    
    //creo i nuovi pins
    int NumberOfMarkers = [list GetCount];
    for(int i = 0; i<NumberOfMarkers; i++ )
    {
        
        [mapview addAnnotation: [list GetItem:i]];
    }
    
}


-(IBAction)SetMap:(id)sender{

}

/*-(IBAction)GetLocation:(id)sender{ funzione scartata per ottenere la posizione dell'utente in quanto non funzionante
    
    
    mapview.showsUserLocation = YES;
}*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (voidƒ)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation isKindOfClass:[MarkerClass class]]) {
        static NSString *identifier = @"MarkerAnnotation";
        MKPinAnnotationView *pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
        if (pinView == nil) {
            pinView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
            pinView.canShowCallout = YES;
            pinView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        } else {
            pinView.annotation = annotation;
        }
        
        return pinView;
    }
    
    return nil;
}


- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control { //intercetto l'azione di cliccare la "i" nel pin e aggiungo DetailsView al navigation controller programmaticamente
    if ([view.annotation isKindOfClass:[MarkerClass class]]) {
        
        MarkerClass *marker = (MarkerClass *)view.annotation; //ottengo il MarkerClass associato a quel pin e il suo index
        
        NSInteger selectedindex = [list GetMarkerIndex:marker];
        
        
        UIViewController *detailsViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailsView"];
        DetailsView *DSV = (DetailsView *)detailsViewController;
        [DSV setSelectedMarkerIndex:selectedindex]; //tramite il suo setter passo l'index del marker corrispondente al pin a detailsview
        
        [self.navigationController pushViewController:detailsViewController animated:YES]; //effettuo il push della schermata dei dettagli sullo stack
        
        
    }
}



- (void)MarkerWasDeleted {
    
    [self CreateAnnotations]; //quando ricevo la notifica di eliminazione di un marker aggiorno la tabella
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
