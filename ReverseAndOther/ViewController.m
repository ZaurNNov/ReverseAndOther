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


// temp
@property (weak, nonatomic) IBOutlet UIButton *button3;
@property (weak, nonatomic) IBOutlet UIButton *button4;
@property (weak, nonatomic) IBOutlet UIButton *button5;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startAction];
    
    [self checkArrayMoove]; // движение массива -> & <-
}

-(void)startAction {
    self.textField.placeholder = @"введите сюда строку";
    
    // прячу не готовое
//    self.button3.alpha = 0.0;
//    self.button4.alpha = 0.0;
    self.button5.alpha = 0.0;
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
    
    NSString *prepareString= [self stringWitoutSpecialSymbols:self.textField.text];
    NSString *result = [NSString stringWithFormat:@"Символов в строке: %lu", (unsigned long)prepareString.length];
    
    self.resultLabel.text = result;
}

- (IBAction)summAllSymbolsButtonAction:(UIButton *)sender {
    [self checkTextField];
    NSString *result = [NSString stringWithFormat:@"Символов в строке: %lu", (unsigned long)self.textField.text.length];
    self.resultLabel.text = result;
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

-(NSString *)stringWitoutSpecialSymbols: (NSString *)originalStr {
    NSCharacterSet *letterCharacters = [NSCharacterSet letterCharacterSet];
    NSCharacterSet *invertedSet = letterCharacters.invertedSet;
    NSString *lettersAndDigitals = [originalStr stringByTrimmingCharactersInSet:invertedSet];
    
//    NSCharacterSet *symbolics = [NSCharacterSet symbolCharacterSet];
//    NSCharacterSet *other = [NSCharacterSet chara]

    return lettersAndDigitals;
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

-(void)checkArrayMoove {
    NSArray *arr = [[NSArray alloc] initWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", nil];
    NSLog(@"arr: %@", arr);
    NSArray *returnArrLeft = [self mooveArrayInLeft:2 fromIntArray:arr];
    NSLog(@"returnArrLeft: %@", returnArrLeft);
    NSArray *returnArrRight = [self mooveArrayInRight:2 fromIntArray:arr];
    NSLog(@"returnArrRight: %@", returnArrRight);
}

-(NSArray *)mooveArrayInLeft:(NSInteger)countToMoove fromIntArray:(NSArray *)originArr {
    
    // временный изменяемый пустой массив
    NSMutableArray *mutArr = [[NSMutableArray alloc] initWithArray:originArr];
    
    // Задача сместить массив влево на 3 позиции
    // был [1.2.3.4.5.6.7.8.9] -> стал [3.4.5.6.7.8.9.1.2]
    // решение - разделить массив на 2 части - первая часть это на сколько сдвинуть влево, каждую перевернуть затем перевернуть то что получится
    // получится что первый кусок массива окажется перевернутым в конце массива
    
    NSInteger len = originArr.count;
    NSInteger firstLen = countToMoove;
    NSInteger secondLen = originArr.count - countToMoove;
    
    // реверс второй части
    for (NSInteger k = 0; k < firstLen / 2; k++) {
        id temp = mutArr[firstLen - k - 1];
        mutArr[firstLen - k - 1] = mutArr[k];
        mutArr[k] = temp;
    }
    
    // реверс частей
    for (NSInteger m = 0; m < secondLen / 2; m++) {
        id temp = mutArr[len - m - 1];
        mutArr[len - m - 1] = mutArr[firstLen + m];
        mutArr[firstLen + m] = temp;
    }
    
    // реверс всего массива
    for (NSInteger i = 0; i < len/2; i++) {
        id temp = mutArr[i];
        mutArr[i] = mutArr[len - i - 1];
        mutArr[len - i - 1] = temp;
    }
    
    return mutArr;
}

-(NSArray *)mooveArrayInRight:(NSInteger)countToMoove fromIntArray:(NSArray *)originArr {

    // временный изменяемый пустой массив
    NSMutableArray *mutArr = [[NSMutableArray alloc] initWithArray:originArr];

    // Задача сместить массив вправо на 2 позиции
    // был [1.2.3.4.5.6.7.8.9] -> стал [8.9.1.2.3.4.5.6.7]
    // решение - разделить массив на 2 части - первая часть это на сколько сдвинуть влево, каждую перевернуть затем перевернуть то что получится
    // получится что первый кусок массива окажется перевернутым в конце массива

    NSInteger len = originArr.count;
    NSInteger firstLen = countToMoove;
    NSInteger secondLen = originArr.count - countToMoove;

    // реверс второй части
    for (NSInteger k = 0; k < firstLen / 2; k++) {
        id temp = mutArr[secondLen + k];
        mutArr[secondLen + k] = mutArr[len - k - 1];
        mutArr[len - k - 1] = temp;
    }

    // реверс частей
    for (NSInteger m = 0; m < secondLen / 2; m++) {
        id temp = mutArr[m];
        mutArr[m] = mutArr[secondLen - m - 1];
        mutArr[secondLen - m - 1] = temp;
    }

    // реверс всего массива
    for (NSInteger i = 0; i < len/2; i++) {
        id temp = mutArr[i];
        mutArr[i] = mutArr[len - i - 1];
        mutArr[len - i - 1] = temp;
    }

    return mutArr;
}



@end
