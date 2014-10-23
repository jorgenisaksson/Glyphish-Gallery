//
//  Icon.m
//  Icon Gallery
//
//  Created by Jörgen Isaksson on 2014-03-16.
//  Copyright (c) 2014 Bitfield AB. All rights reserved.
//

#import "Icon.h"

@implementation Icon

#pragma mark - Extras

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.variants = [NSMutableArray array];
        self.title = nil;
    }
    return self;
}

- (void)setBasePath:(NSString *)aBasePath
{
    _basePath = aBasePath;
    _filePath = aBasePath;
    
    // check for variants
    NSString *base = [aBasePath stringByDeletingPathExtension];
    NSString *baseFolder = [base stringByDeletingLastPathComponent];
    NSString *selectedFolder = [NSString stringWithFormat:@"%@ Selected", baseFolder];
        
    NSString *selectedBase = [[selectedFolder stringByAppendingPathComponent:[base lastPathComponent]] stringByDeletingPathExtension];
    NSString *baseRetina = [[NSString stringWithFormat:@"%@@2x", base] stringByAppendingPathExtension:[aBasePath pathExtension]];
    NSString *baseRetinaHD = [[NSString stringWithFormat:@"%@@3x", base] stringByAppendingPathExtension:[aBasePath pathExtension]];
    
    NSString *selectedPath = [[NSString stringWithFormat:@"%@-selected", selectedBase] stringByAppendingPathExtension:[aBasePath pathExtension]];
    NSString *selectedRetinaPath = [[NSString stringWithFormat:@"%@-selected@2x", selectedBase] stringByAppendingPathExtension:[aBasePath pathExtension]];
    NSString *selectedRetinaHDPath = [[NSString stringWithFormat:@"%@-selected@3x", selectedBase] stringByAppendingPathExtension:[aBasePath pathExtension]];
    
    [self.variants removeAllObjects];
    
    NSString *title = [self.filePath.lastPathComponent stringByDeletingPathExtension];
    title = [title stringByReplacingOccurrencesOfString:@"-" withString:@" "];
    self.title = title;
    
    Icon *anIcon = [[Icon alloc] init];
    anIcon.filePath = aBasePath;
    [self.variants addObject:anIcon];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:baseRetina]) {
        anIcon = [[Icon alloc] init];
        anIcon.filePath = baseRetina;
        [self.variants addObject:anIcon];
    }

    if ([[NSFileManager defaultManager] fileExistsAtPath:baseRetinaHD]) {
        anIcon = [[Icon alloc] init];
        anIcon.filePath = baseRetinaHD;
        [self.variants addObject:anIcon];
    }

    if ([[NSFileManager defaultManager] fileExistsAtPath:selectedPath]) {
        anIcon = [[Icon alloc] init];
        anIcon.filePath = selectedPath;
        [self.variants addObject:anIcon];
    }

    if ([[NSFileManager defaultManager] fileExistsAtPath:selectedRetinaPath]) {
        anIcon = [[Icon alloc] init];
        anIcon.filePath = selectedRetinaPath;
        [self.variants addObject:anIcon];
    }

    if ([[NSFileManager defaultManager] fileExistsAtPath:selectedRetinaHDPath]) {
        anIcon = [[Icon alloc] init];
        anIcon.filePath = selectedRetinaHDPath;
        [self.variants addObject:anIcon];
    }
}

- (NSString *)imageUID;
{
    return self.filePath;
}

- (NSString *)imageTitle
{
    NSString *title =  [self.filePath.lastPathComponent stringByDeletingPathExtension];
    title = [title stringByReplacingOccurrencesOfString:@"-" withString:@" "];
    
    return title;
}

- (NSString *)imageRepresentationType;
{
    return IKImageBrowserPathRepresentationType;
}

- (id)imageRepresentation;
{
    return self.filePath;
}

@end
