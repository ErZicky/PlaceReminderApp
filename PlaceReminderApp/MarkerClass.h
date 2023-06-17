//
//  MarkerClass.h
//  PlaceReminderApp
//
//  Created by zic on 13/06/2023.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface MarkerClass : NSObject <MKAnnotation> {
    
    CLLocationCoordinate2D coordinate;
    NSString *name;
    NSString *desc;
    
}

-(instancetype)initWithElements:(CLLocationCoordinate2D)_coordinate name:(NSString *)_name desc:(NSString *)_desc address:(NSString *)_addr date:(NSDate *)_date;
@property (nonatomic, assign) NSDate* date;
@property (nonatomic, copy) NSString* name;
@property (nonatomic, copy) NSString* desc;
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString* address;
- (NSString *)title;
- (NSString *)subtitle;

@end

NS_ASSUME_NONNULL_END
