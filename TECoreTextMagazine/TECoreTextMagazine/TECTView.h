//
//  TECTView.h
//  TECoreTextMagazine
//
//  Created by Tuấn Nguyễn Anh on 5/10/13.
//  Copyright (c) 2013 Tuấn Nguyễn Anh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TECTView : UIScrollView<UIScrollViewDelegate>
{
    //offset x and y to have a margin
    float frameXOffset;
    float frameYOffset;
    NSMutableArray *frames;
    NSAttributedString* attString;
}

@property (retain, nonatomic) NSAttributedString *attString;
@property (retain, nonatomic) NSMutableArray* frames;
- (void)buildFrames;

@end
