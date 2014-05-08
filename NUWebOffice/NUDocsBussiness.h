//
//  NUDocumentBussiness.h
//  NUWebOffice
//
//  Created by JY on 14-4-24.
//  Copyright (c) 2014年 XLDZ. All rights reserved.
//

#import "NUBussiness.h"

@interface NUDocsBussiness : NUBussiness

+(NUDocsBussiness*)sharedNUDocsBussiness;

-(void)getDocslistFromSPSite;
@end
