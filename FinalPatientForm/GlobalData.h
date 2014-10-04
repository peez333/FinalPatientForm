//
//  GlobalData.h
//  FinalPatientForm
//
//  Created by Peeyush on 09/09/14.
//  Copyright (c) 2014 sutherland. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GlobalData : NSObject {
    
    NSMutableArray *patientInfoArray;
    NSMutableArray *sectionArray;
    
    NSMutableArray *form2PatientInfoArray;
    NSMutableArray *form2SectionArray;
}
@property(nonatomic,retain)NSMutableArray *patientInfoArray;
@property(nonatomic,retain)NSMutableArray *sectionArray;

@property(nonatomic,retain)NSMutableArray *form2PatientInfoArray;
@property(nonatomic,retain)NSMutableArray *form2SectionArray;
+(GlobalData*)getInstance;

@end
