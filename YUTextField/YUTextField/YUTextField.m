

//
//  YUTextField.m
//  YUTextField
//
//  Created by yuzhx on 15/4/28.
//  Copyright (c) 2015年 BruceYu. All rights reserved.
//

#import "YUTextField.h"

@interface YUTextField()<UITextFieldDelegate>
@end

@implementation YUTextField

-(void)awakeFromNib
{
    [super awakeFromNib];
     self.delegate = self;
}


#define MAX_LENTH 3
#define limited 2
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    NSString * aString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    int flag = 0;
    for (NSInteger i = aString.length - 1; i >= 0; i--) {
        if ([aString characterAtIndex:i] == '.') {
            if (flag > limited) {
                textField.text = [aString stringByReplacingCharactersInRange:range withString:string];
                textField.text = [aString substringToIndex:MAX_LENTH + flag];
                return NO;
            }
            break;
        }
        flag++;
    }
    
    NSInteger ff = (flag>2 ? 0:(flag?(flag+1):0));
    if ([aString length] >= MAX_LENTH + ff) {
        if (!(range.location == MAX_LENTH && ![string isEqualToString:@"."])) {
            ff = [string isEqualToString:@"."]?(ff?(ff+1):1):(ff);
            textField.text = [aString substringToIndex:MAX_LENTH + ff];
        }
        return NO;
    }
    
    
    if ([self isDecimal:aString] || [string length] == 0 || ([string isEqualToString:@"."] && [textField.text rangeOfString:@"."].location == NSNotFound)) {
        return YES;
    }
    return NO;
}

-(BOOL)isDecimal:(NSString*)num
{
    BOOL ret = NO;
    NSString *regex = @"^(([0-9]+\\.[0-9]*[1-9][0-9]*)|([0-9]*[1-9][0-9]*\\.[0-9]+)|([0-9]*[1-9][0-9]*))$";
    if (num) {
        NSPredicate * pred  = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        ret = [pred evaluateWithObject:num];
    }
    return ret;
}

@end
