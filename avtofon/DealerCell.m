//
//  DealerCell.m
//  avtofon
//
//  Created by naceka on 02.09.11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DealerCell.h"


@implementation DealerCell

@synthesize title, recomend, subtitle;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc
{
    [super dealloc];
}

@end
