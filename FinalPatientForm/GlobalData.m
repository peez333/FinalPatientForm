//
//  GlobalData.m
//  FinalPatientForm
//
//  Created by Peeyush on 09/09/14.
//  Copyright (c) 2014 sutherland. All rights reserved.
//

#import "GlobalData.h"

@implementation GlobalData
@synthesize patientInfoArray, sectionArray;
@synthesize form2PatientInfoArray, form2SectionArray;

static GlobalData *instance =nil;
+(GlobalData *)getInstance
{
    
    @synchronized(self)
    {
        if(instance==nil)
        {
            
            instance= [GlobalData new];
        }
    }
    return instance;
}

- (id)init {
    if (self = [super init]) {
        [self parseJsonForm1File];
        [self parseJsonForm2File];
    }
    return self;
}

- (void) parseJsonForm1File {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Form1" ofType:@"json"];
    NSData *fieldsData = [NSData dataWithContentsOfFile:path];
    NSMutableDictionary *jsonFileContentList = [NSJSONSerialization JSONObjectWithData:fieldsData options:(NSJSONReadingOptions)0 error:NULL];
    //  NSLog(@"JsonFileContentList: %@", jsonFileContentList);
    
    NSMutableDictionary *dict = [jsonFileContentList objectForKey:@"QNS"];
    self.sectionArray = [dict objectForKey:@"section"];
    self.patientInfoArray = [[NSMutableArray alloc] init];
    for (int i=0; i<[sectionArray count]; i++) {
        NSMutableDictionary *dict1 = [sectionArray objectAtIndex:i];
        [self.patientInfoArray addObject:[dict1 objectForKey:@"info"]];
    }
}

- (void) parseJsonForm2File {
    
    NSString *form2Path = [[NSBundle mainBundle] pathForResource:@"Form2" ofType:@"json"];
    NSData *form2FieldsData = [NSData dataWithContentsOfFile:form2Path];
    NSMutableDictionary *jsonForm2FileContentList = [NSJSONSerialization JSONObjectWithData:form2FieldsData options:(NSJSONReadingOptions)0 error:NULL];
    
    NSMutableDictionary *form2Dict = [jsonForm2FileContentList objectForKey:@"QNS"];
    self.form2SectionArray = [form2Dict objectForKey:@"section"];
    self.form2PatientInfoArray = [[NSMutableArray alloc] init];
    for(int i=0;i<[self.form2SectionArray count];i++) {
        NSMutableDictionary *form2Dict2 = [self.form2SectionArray objectAtIndex:i];
        [self.form2PatientInfoArray addObject:[form2Dict2 objectForKey:@"cell"]];
    }
    NSLog(@"Form2PatientInfoArray:%@", self.form2PatientInfoArray);
    
//    NSLog(@"Form2PatientInfoArray1:%@", [self.form2PatientInfoArray objectAtIndex:0]);
//    
//    NSMutableArray *infoArr = [self.form2PatientInfoArray objectAtIndex:0];
//    NSMutableDictionary *infoDict = [infoArr objectAtIndex:0];
//    NSLog(@"InfoDict:%@", [infoDict objectForKey:@"title"]);
}

@end
