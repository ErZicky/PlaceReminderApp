//
//  MapClassViewController.h
//  PlaceReminderApp
//
//  Created by zic on 13/06/2023.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MapClassViewController : UIViewController {
    
    MKMapView *mapview;
    
    
}

@property (nonatomic, retain) IBOutlet MKMapView *mapview;

-(IBAction)SetMap:(id)sender;

-(IBAction)GetLocation:(id)sender;

@end



NS_ASSUME_NONNULL_END
