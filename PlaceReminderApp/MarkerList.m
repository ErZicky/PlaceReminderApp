//
//  MarkerList.m
//  PlaceReminderApp
//
//  Created by zic on 13/06/2023.
//  questa classe definisce la lista di marker

#import "MarkerList.h"


@implementation MarkerList

@synthesize markerList;

-(instancetype)init{
    
    markerList = [NSMutableArray array];
    return self;
}

+(instancetype)getinstance{ //usata per ottenere il singleton
    
        static MarkerList *sharedInstance = nil;
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            sharedInstance = [[MarkerList alloc] init];
        });
        return sharedInstance;
}

-(MarkerClass *) GetItem:(int)_index
{
    
    return [markerList objectAtIndex:_index];
    
}


-(int)GetMarkerIndex:(MarkerClass *)_marker
{
    return [self.markerList indexOfObject:_marker];
}


-(int)GetCount{
    
    return markerList.count;
    
    
}


-(void)AddItem:(MarkerClass *)_item
{
    if(markerList != nil)
    {
        [markerList addObject:_item];
    }
    else
    {
        NSLog(@"nullo");
    }
    
    
}

-(void)DeleteItem:(int)_index
{
    
    [markerList removeObjectAtIndex:_index];
}



@end
