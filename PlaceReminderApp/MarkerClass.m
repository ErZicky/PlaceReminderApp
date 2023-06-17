//
//  MarkerClass.m
//  PlaceReminderApp
//
//  Created by zic on 13/06/2023.
//  questa classe definisce il singolo marker

#import "MarkerClass.h"

@implementation MarkerClass

@synthesize name;
@synthesize date;
@synthesize desc;
@synthesize coordinate;
@synthesize address;


-(instancetype)initWithElements:(CLLocationCoordinate2D)_coordinate name:(NSString *)_name desc:(NSString *)_desc address:(NSString *)_addr date:(NSDate *)_date
{
    self.coordinate = _coordinate;
    self.name = _name;
    self.desc = _desc;
    self.address = _addr;
    self.date = _date;
    return self;
    
    

}

//funzioni necessarie per far apparire il testo nel pin
- (NSString *)title {
    return self.name;
}

- (NSString *)subtitle {
    return self.desc;
}


@end
