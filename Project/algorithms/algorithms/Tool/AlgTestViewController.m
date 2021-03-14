//
//  AlgTestViewController.m
//  algorithms
//
//  Created by ZHUYN on 2021/2/22.
//

#import "AlgTestViewController.h"
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonHMAC.h>
#import "AESCipher.h"
#import <objc/runtime.h>
#import "NSString+test.h"

@interface Person: NSObject
{
    NSString *_ivarOne;
}
@property (copy, atomic) NSArray *ary;

+ (void)testMethoddClass;
- (void)testMethodd;

@end

@implementation Person

- (void)testMethodd {
    NSLog(@"invoke testMethodd");
}

@end


@interface AlgTestViewController ()

@property (assign, atomic) Person *per;

@end

@implementation AlgTestViewController


+ (void)load {
    
//    Person *p;
//    [p testMethodd];
    
//    Person *p = [[Person alloc] init];
//    p.ary = [NSArray new];
//    NSLog(@"%ld", p.ary.count);
    
    
    NSString *str = @"123";
    [str compare:@"1"];
    
   
}

+ (void)initialize {
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    self.per = [Person new];
//    NSLog(self.per);
    
//    Person *p = [Person new];
//    self.per = p;
//    NSLog(self.per.ary);
    
//    Person *p = [Person alloc];
//    [p testMethodd];
    
    Person *p1 = [Person alloc];
    Person *p2 = [p1 init];
    Person *p3 = [p1 init];
    
    NSLog(@"%@ - %p - %p",p1,p1,&p1);
    NSLog(@"%@ - %p - %p",p2,p2,&p2);
    NSLog(@"%@ - %p - %p",p3,p3,&p3);
    
    p1.ary = [NSArray arrayWithObjects:@"1212", nil];
    NSLog(@"%d", p2.ary.count);
    NSLog(@"%@", p3.ary.firstObject);
    
    [self getPropertyList];
    [self getIvarList];
    
    unsigned int outCount ;
    Method *list = class_copyMethodList([Person class], &outCount);
    for (int i = 0; i < outCount; i++) {
        NSLog(@"%s", sel_getName(method_getName(list[i])));
    }

    // 点击事件
    self.view.backgroundColor = [UIColor grayColor];
    UIButton *footerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [footerBtn setTitle:@"button1" forState:UIControlStateNormal];
    [footerBtn setBackgroundColor:[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0]];
    [footerBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [footerBtn addTarget:self action:@selector(button1Click) forControlEvents:UIControlEventTouchUpInside];
    footerBtn.frame = CGRectMake(100, 100, 100, 100);
    [self.view addSubview:footerBtn];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"button2" forState:UIControlStateNormal];
    [button2 setBackgroundColor:[UIColor purpleColor]];
    [button2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(button2Click) forControlEvents:UIControlEventTouchUpInside];
    button2.frame = CGRectMake(100, 150, 100, 100);
    [self.view addSubview:button2];
    
    NSMutableArray *ary = [NSMutableArray array];
//    [ary addObject:CGRectMake(0, 0, 10, 10)];
//    [UIImage imageNamed:<#(nonnull NSString *)#>];
//    [UIImage imageWithContentsOfFile:<#(nonnull NSString *)#>];
    
    // 加密
    NSString *password = @"123456";
    NSLog(@"MD5:%@", [self md5WithString:password]);
    NSLog(@"sha1:%@", [self sha1WithString:password]);
    NSLog(@"MD5_base64:%@", [self md5_base64WithString:password]);
    NSLog(@"md5AddSalt:%@", [self md5AddSaltWithString:password]);
    NSLog(@"sha1_base64:%@", [self sha1_base64WithString:password]);
    NSLog(@"base64:%@", [self base64EncodedStringWithString:password]);
    NSLog(@"HMAC:%@", [self HMACWithString:password key:@"15:33:32"]);
    
    [self encryptString];
    
    // 0 1 1 2 3 5 8 13 求第n个费纳波契数
    NSLog(@"%d", [self fib:32]);
    NSLog(@"%d", [self fib2:32]);
    
//    NSArray *a = [NSArray arrayWithObject:CGRectZero];
//    NSArray *a = [NSArray arrayWithObject:nil];
//    NSArray *a = [NSArray arrayWithObjects:nil, nil];
}

- (void)getPropertyList
{
    unsigned int outCount ;
    objc_property_t *propertyList = class_copyPropertyList([Person class], &outCount);//获取类属性列表
    for (unsigned int i = 0;i < outCount;i ++ )
    {
        objc_property_t property = propertyList[i];
        const char *propertyName = property_getName(property);//获取属性的名字
        const char *propertyDesc = property_getAttributes(property);//获取属性整体描述
        const char *propertyValue = property_copyAttributeValue(property, propertyName);//获取属性的值
        NSLog(@"\n\n%s 属性的描述是:%s ==== 值是：%s",propertyName,propertyDesc,propertyValue);
        
        unsigned int attCount;
        objc_property_attribute_t *attList = property_copyAttributeList(property, &attCount);//获取属性的描述列表，结果是一个类型为objc_property_attribute_t结构体组成的数组
        for (unsigned int j = 0; j < attCount; j ++) {
            objc_property_attribute_t att = attList[j];
            const char * name = att.name;
            const char * value = att.value;
            NSLog(@"%s 属性的名字是 %s 值是:%s",propertyName,name,value);
        }
    }
}

- (void)getIvarList {
    unsigned int ivarCount;
    //获取类成员变量列表，包括类的属性property
    Ivar *ivarList = class_copyIvarList([Person class], &ivarCount);
    for (unsigned int i = 0; i < ivarCount; i ++) {
        //获取指定成员变量的名字
        const char *ivarName = ivar_getName(ivarList[i]);
        //获取成员变量的类型 类型参考property_copyAttributeList中name为T的值
        const char *ivarTypeEncoding = ivar_getTypeEncoding(ivarList[i]);
        //获取成员变量在类对象中的内存偏移值
        ptrdiff_t ivarOffset = ivar_getOffset(ivarList[i]);
        NSLog(@"ivarList[i]成员变量的名字是：%s，类型是：%s，偏移是：%td",ivarName,ivarTypeEncoding,ivarOffset);
    }
    
    
}

- (void)button1Click
{
    NSLog(@"button1");
}

- (void)button2Click
{
    NSLog(@"button22222");
}

- (int)fib:(int)input
{
    if (input <= 1) {
        return input;
    }
    
    return [self fib:input - 1] + [self fib:input - 2];
}

- (int)fib2:(int)input
{
    if (input <= 1) {
        return input;
    }
    
    int first = 0;
    int second = 1;
    for (int i = 0; i < input - 1; i++) {
        int sum = first + second;
        first = second;
        second = sum;
    }
    
    return second;
}

/*
 HASH算法是密码学的基础，常用：MD5、SHA。
 两条性质：不可逆、无冲突（不可能两个值的hash值相同）
 */
#pragma mark - md5
- (NSString *)md5WithString:(NSString *)input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return  output;
}

// 结合base64
- (NSString *)md5_base64WithString:(NSString *)input
{
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (int)strlen(cStr), digest );
    
    NSData * base64 = [[NSData alloc] initWithBytes:digest length:CC_MD5_DIGEST_LENGTH];
    NSLog(@"MD5:%@", base64);
    return [base64 base64EncodedStringWithOptions:0];;
}

// 加盐
static NSString *salt = @"aslkajd#$@&u278gjkh#${[]!";
- (NSString *)md5AddSaltWithString:(NSString *)input
{
    NSString *saltStr = [input stringByAppendingString:salt];
    const char *cStr = [saltStr UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5(cStr, (CC_LONG)strlen(cStr), digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return  output;
}

#pragma mark - sha1 (Secure Hash Algorithm，SHA)
- (NSString*)sha1WithString:(NSString *)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    //使用对应的CC_SHA1,CC_SHA256,CC_SHA384,CC_SHA512的长度分别是20,32,48,64
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    //使用对应的CC_SHA256,CC_SHA384,CC_SHA512
    CC_SHA1(data.bytes, (int)data.length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}

// 结合base64
- (NSString *)sha1_base64WithString:(NSString *)input
{
    const char *cstr = [input cStringUsingEncoding:NSUTF8StringEncoding];
    NSData *data = [NSData dataWithBytes:cstr length:input.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (int)data.length, digest);
    
    NSData * base64 = [[NSData alloc]initWithBytes:digest length:CC_SHA1_DIGEST_LENGTH];

    return [base64 base64EncodedStringWithOptions:0];
}


#pragma mark - Base64
/*
 Base64是一种数据编码方式，目的是让数据符合传输协议的要求。标准Base64编码解码无需额外信息即完全可逆，即使你自己自定义字符集设计一种类Base64的编码方式用于数据加密，在多数场景下也较容易破解。
 
 对于数据加密应该使用专门的目前还没有有效方式快速破解的加密算法。比如：对称加密算法AES-128-CBC，对称加密需要密钥，只要密钥没有泄露，通常难以破解；也可以使用非对称加密算法，如 RSA，利用极大整数因数分解的计算量极大这一特点，使得使用公钥加密的数据，只有使用私钥才能快速解密。
 
 对于数据校验，也应该使用专门的消息认证码生成算法，如 HMAC - 一种使用单向散列函数构造消息认证码的方法，其过程是不可逆的、唯一确定的，并且使用密钥来生成认证码，其目的是防止数据在传输过程中被篡改或伪造。将原始数据与认证码一起传输，数据接收端将原始数据使用相同密钥和相同算法再次生成认证码，与原有认证码进行比对，校验数据的合法性。
 */
- (NSString *)base64EncodedStringWithString:(NSString *)str;
{
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    return [data base64EncodedStringWithOptions:0];
}

- (NSString *)base64DecodedStringWithString:(NSString *)Base64Str
{
    NSData *data = [[NSData alloc] initWithBase64EncodedString:Base64Str options:0];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

#pragma mark - HMAC (Hash-based Message Authentication Code)
/*
 hmac主要应用在身份验证中，它的使用方法是这样的：
 (1) 客户端发出登录请求（假设是浏览器的GET请求）
 (2) 服务器返回一个随机值，并在会话中记录这个随机值
 (3) 客户端将该随机值作为密钥，用户密码进行hmac运算，然后提交给服务器
 (4) 服务器读取用户数据库中的用户密码和步骤2中发送的随机值做与客户端一样的hmac运算，然后与用户发送的结果比较，如果结果一致则验证用户合法
 在这个过程中，可能遭到安全攻击的是服务器发送的随机值和用户发送的hmac结果，而对于截获了这两个值的黑客而言这两个值是没有意义的，绝无获取用户密码的可能性，随机值的引入使hmac只在当前会话中有效，大大增强了安全性和实用性。大多数的语言都实现了hmac算法，比如php的mhash、python的hmac.py、java的MessageDigest类，在web验证中使用hmac也是可行的，用js进行md5运算的速度也是比较快的。
 */
// HMAC
- (NSString *)HMACWithString:(NSString *)input key:(NSString *)keyStr
{
    const char *cKey  = [keyStr cStringUsingEncoding:NSASCIIStringEncoding];
    const char *cData = [input cStringUsingEncoding:NSASCIIStringEncoding];
    
    unsigned char cHMAC[CC_SHA256_DIGEST_LENGTH];
    
    //关键部分
    CCHmac(kCCHmacAlgSHA256, cKey, strlen(cKey), cData, strlen(cData), cHMAC);
    
    NSData *HMAC = [[NSData alloc] initWithBytes:cHMAC
                                          length:sizeof(cHMAC)];
    
    //将加密结果进行一次BASE64编码。
    NSString *hash = [HMAC base64EncodedStringWithOptions:0];
    return hash;
}


#pragma mark - bubbleSort
//冒泡排序
- (void)bubbleSortWithArray:(NSMutableArray *)arrData{
    for (int i=0; i<arrData.count; i++) {
        for (int j = 1; j<arrData.count - i; j++) {
            if ([arrData objectAtIndex:j-1]>[arrData objectAtIndex:j]) {
                [self swapWithData:arrData index1:j-1 index2:j];
            }
        }
    }
}

- (void)swapWithData:(NSMutableArray *)arrData index1:(NSUInteger)index1  index2:(NSUInteger)index2
{
    NSNumber *temp = [arrData objectAtIndex:index1];
    [arrData replaceObjectAtIndex:index1 withObject:[arrData objectAtIndex:index2]];
    [arrData replaceObjectAtIndex:index2 withObject:temp];
}

#pragma mark - AES128（对称加密）
- (void)encryptString
{
    NSString *tempString = @"123456";   // 牛逼
    NSString *keyStr = @"aes--128--string";
    NSString *tString = aesEncryptString(tempString, keyStr);
    NSLog(@"%@--%@--%@", tempString, tString, aesDecryptString(tString, keyStr));
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
