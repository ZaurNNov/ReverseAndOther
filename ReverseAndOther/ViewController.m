//
//  ViewController.m
//  ReverseAndOther
//
//  Created by Zaur Giyasov on 18/09/2018.
//  Copyright © 2018 Zaur Giyasov. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startAction];
}

-(void)startAction {
    self.textField.placeholder = @"введите сюда строку";
}

- (IBAction)clearButtonAction:(UIButton *)sender {
    self.resultLabel.text = @"Очищено!";
}

-(void)checkTextField {
    if ([self.textField.text isEqual: @""]) {
        NSLog(@"TextField empty!");
//        self.resultLabel.text = @"Ввести за вас произвольную строку?";
    }
    
    if ([self.textField.text isEqualToString: @" "]) {
        NSLog(@"TextField empty!");
    }
}

- (IBAction)reverseButtonAction:(UIButton *)sender {
    [self checkTextField];
    
    self.resultLabel.text = [self reverseString:self.textField.text];
}

- (IBAction)checkPolindromButtonAction:(UIButton *)sender {
    [self checkTextField];
    
    self.resultLabel.text = [self checkPolindrom:self.textField.text];
}

- (IBAction)summAllLettersButtonAction:(UIButton *)sender {
    [self checkTextField];
}

- (IBAction)summAllSymbolsButtonAction:(UIButton *)sender {
    [self checkTextField];
}

- (IBAction)delAllPhoneticALettersButtonAction:(UIButton *)sender {
    [self checkTextField];
}

-(NSString *)reverseString:(NSString *)originalStr {
    
    NSString *preparedStr = [self stringWithoutStartAndEndSpases:originalStr];
    
    NSMutableString *reversedString = [[NSMutableString alloc] initWithCapacity:[preparedStr length]];
    NSUInteger charIndex = [preparedStr length];
    while (charIndex > 0) {
        charIndex --;
        NSRange subStringRange = NSMakeRange(charIndex, 1);
        [reversedString appendString:[preparedStr substringWithRange:subStringRange]];
    }
    
    return reversedString;
}

// Метод перебора строки по символьно - не работает с кирилицей
- (NSString *)reverseStr:(NSString *)inputStr {
    NSUInteger len = [inputStr length];
    NSMutableString *result = [[NSMutableString alloc] initWithCapacity:len];
    for (NSInteger i = len - 1; i >= 0; i--) {
        [result appendFormat:@"%c", [inputStr characterAtIndex:(int)i]];
    }
    return result;
}

// Обрезание пробелов по всей строке
-(NSString *)stringWithoutSpases:(NSString *)originalStr {
    
    return [originalStr stringByReplacingOccurrencesOfString:@" " withString:@""];
}

// Обрезание пробелов в начале и конце строки
-(NSString *)stringWithoutStartAndEndSpases:(NSString *)originalStr {
    NSCharacterSet *whiteSpases = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    // Обрезаем первые пробелы и сохраняем в новую строку
    NSUInteger i = 0;
    while (i < originalStr.length && [whiteSpases characterIsMember:[originalStr characterAtIndex:i]]) {
        i++;
    }
    
    NSString* strWithoutStartSpases = [NSString stringWithString:[originalStr substringFromIndex:i]]; //полуготовый вариант
    
    // Обрезаем пробелы с конца строки и возвращаем уже полностью "готовую" строку из этого метода
    NSUInteger l = strWithoutStartSpases.length;
    while (l > 0 && [whiteSpases characterIsMember:[strWithoutStartSpases characterAtIndex:l - 1]]) {
        l--;
    }
    
    return [strWithoutStartSpases substringToIndex:l];
}

-(NSString *)checkPolindrom:(NSString *)originalStr {
    
    if ([self isPalindromeStr:originalStr]) {
        return @"Это палиндром";
    } else {
        return @"Это не палиндром";
    }
}

-(BOOL)isPalindromeStr:(NSString *)originalStr {
    NSString *preparedStr = [self stringWithoutStartAndEndSpases:originalStr];
    NSString *lowwerCase = preparedStr.lowercaseString;
    NSString *withoutSpases = [self stringWithoutSpases:lowwerCase];
    // так же как реверс массива, сравниваем символы первый и последний
    // для этого мы делим пополам строку/массив и начинаем сравнение
    NSInteger len = withoutSpases.length; // длинна
    for (NSInteger i = 0; i < len/2; i++) {
        unichar temp = (unichar *)[withoutSpases characterAtIndex:i];
        if (temp != [withoutSpases characterAtIndex:len-i-1]) {
            return NO;
        }
    }
    return YES;
}


@end
