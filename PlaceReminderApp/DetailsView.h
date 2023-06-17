//
//  DetailsView.h
//  PlaceReminderApp
//
//  Created by zic on 16/06/2023.
//

#import <UIKit/UIKit.h>
#import "MarkerList.h"

NS_ASSUME_NONNULL_BEGIN

@interface DetailsView : UIViewController

@property (strong, nonatomic) MarkerClass *selectedMarker;
@end

NS_ASSUME_NONNULL_END
