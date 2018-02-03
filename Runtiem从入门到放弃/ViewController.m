//
//  ViewController.m
//  Runtiem从入门到放弃
//
//  Created by 杭州米发 on 2017/12/8.
//  Copyright © 2017年 杭州米发. All rights reserved.
//

/*
 *** rumtime 是消息传递机制是核心 是面向对象  动态语言 可以动态的创建类和对象 进行消息传递和转发 
*/




#import "ViewController.h"
#import <objc/message.h>
#import "Person.h"
//#import "UIViewController+Swizzling.h"
#import "NSArray+Name.h"
#import "NSMutableArray+SafeArray.h"
#import "UIViewController+FSViewController.h"
#import "Model.h"
#import "Test.h"

@protocol ViewControllerDelegate <NSObject>

- (void)viewControllerDelegate;

@end

@interface ViewController ()

@property (nonatomic, strong) UILabel * label;
@property (nonatomic, copy) NSArray * array;

@property (nonatomic, strong) NSMutableArray * dataArray;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
}

//动态交换方法 防止数组越界

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self runtimeBase];
    
    //动态的添加方法
    [self performMethod];
    
    //动态添加属性
//    [self addProper];
    
//    [self addArrayName];
    
    //动态数组的安全性
//    [self safeArray];
    
    
    //字典转模型
//    [self runtimeExchangeModel];
    
//    //便利一个 字典然后归档
//    unsigned int count;
//
//    objc_property_t * dicList = class_copyPropertyList([Person class], &count);
//    for (unsigned int i = 0 ; i < count; i++) {
//        objc_property_t property = dicList[i];
//        const char * name  = property_getName(property);
//        NSString * key = [NSString stringWithUTF8String:name];
//        NSLog(@"%@", key);
//    }
//
//
//    Person * person = [[Person alloc] init];
//    person.name = @"冯硕";
//    person.age = 25;
//    person.address = @"河南";
//    person.sex = @"男";

//    NSLog(@"%@", self.dataArray);
    
    
//    [self unknown];
    
    Test * test1 = [[Test alloc] init];
//Test * test2 = [[Test alloc] init];
    
    

}


#pragma mark - 字典转模型
//字典转模型
- (void)runtimeExchangeModel
{
    //字典转模型
    NSDictionary * dic = @{@"name":@"冯硕", @"age":@"25", @"sex":@"男"};
    Model * model = [Model modelWithDic:dic];
    NSLog(@"%@ %@ %@", model.name, model.age, model.sex);
}

- (void)safeArray
{
    //防止数组越界
    self.dataArray = [NSMutableArray array];
    [self.dataArray addObject:@"你好"];
    [self.dataArray addObject:@"hellWorld"];
    [self.dataArray addObject:nil];
}


- (void)addArrayName
{
    NSArray * array = [NSArray array];
    array.name = @"1253";
    NSLog(@"%@", array.name);
}



- (void)runtimeBase
{
    
    //当前类中属性的个数
    unsigned int count;
    objc_property_t *  propertylist = class_copyPropertyList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        const char * propertyName = property_getName(propertylist[i]);
        NSLog(@"peoperty ----- %@", [NSString stringWithUTF8String:propertyName]);
    }
    
    //或得方法列表
    Method *methodList = class_copyMethodList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        Method method = methodList[i];
        NSLog(@"method ------%@", NSStringFromSelector(method_getName(method)));
    }
    
    //或得成员变量的列表
    Ivar * ivarlist = class_copyIvarList([self class], &count);
    for (unsigned int i = 0; i < count; i++) {
        Ivar myivar = ivarlist[i];
        const char * ivarname = ivar_getName(myivar);
        NSLog(@"Ivar---->%@", [NSString stringWithUTF8String:ivarname]);
    }
    
    
    //获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (unsigned int i =0 ; i<count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        NSLog(@"protocol---->%@", [NSString stringWithUTF8String:protocolName]);
    }

}

/*
 *** 动态添加方法   1.首先一个对象  在缓存列表（但一个 class 往往只有 20% 的函数会被经常调用，可能占总调用次数的 80% 。每个消息都需要遍历一次 objc_method_list 并不合理。如果把经常被调用的函数缓存下来，那可以大大提高函数查询的效率。这也就是 objc_class 中另一个重要成员 objc_cache 做的事情 - 再找到 foo 之后，把 foo 的 method_name 作为 key ，method_imp 作为 value 给存起来。当再次收到 foo 消息的时候，可以直接在 cache 里找到，避免去遍历 objc_method_list）去查找当前的方法 找到的话 则去实现这个方法 2.如果没有在缓存列表中查到的话 就会到objc_method_list寻找   3.没有在objc_method_list找到的话 就会到父类指针中寻找 重复1 2  4.以此类推，如果一直到根类还没找到，转向拦截调用。5.如果没有重写拦截调用的方法，程序报错。
*/
- (void)performMethod
{
    [self performSelector:@selector(food) withObject:self];
}


void foodMethod(id  objc, SEL _cmd){
    NSLog(@"Doing foo");
}


- (void)eatfood
{
    NSLog(@"%@", @"吃饭了");
}


//+ (BOOL)resolveInstanceMethod:(SEL)sel
//{
//    if (sel == @selector(food)) {
//        class_addMethod([self class], sel, (IMP)foodMethod, "v@:*");
//    }
//    return YES;
//}

//当你调用一个不存在的方法的时候 你可以调用这个方法 然后返回yes
//+ (BOOL)resolveClassMethod:(SEL)sel
//{
//
//    return ni;
//}
//第二个方法和第一个方法相似，只不过处理的是实例方法。 当第一个方法  返回No 或者返回了YES 但是没有添加方法的时候 会走这个方法
+ (BOOL)resolveInstanceMethod:(SEL)sel
{
    NSLog(@"%@", NSStringFromSelector(sel));
    
    return  NO;
    
//    //这两种方法都是可以的 都可以完成
//      if (sel == @selector(food)) {
//    IMP fooimp =imp_implementationWithBlock(^(id _self){
//        NSLog(@"可以这样实现food的方法吗");
//    });
//    class_addMethod([self class], sel, fooimp, "v@:");
//  }
    
    
//    if (sel == @selector(food)) {
//        class_addMethod([self class], sel, (IMP)foodMethod, "V@:");
//    }
    return YES;
}
//后两个方法需要转发到其他的类处理

//第三个方法是将你调用的不存在的方法重定向到一个其他声明了这个方法的类，只需要你返回一个有这个方法的target   可以相应这个方法的对象 就行

- (id)forwardingTargetForSelector:(SEL)aSelector
{
    NSLog(@"%@", NSStringFromSelector(aSelector));
   
    return nil;
    
//    Person * person = [[Person alloc] init];
//    return person;
    
//   return [super forwardingTargetForSelector:aSelector];
}

//  第三步， 如果forwardingTargetForSelector:返回了nil，则该方法会被调用，系统会询问我们要一个合法的『类型编码(Type Encoding)』
//  若返回 nil，则不会进入下一步，而是无法处理消息
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [NSMethodSignature signatureWithObjCTypes:"v@:"];
}


//第四个方法是将你调用的不存在的方法打包成NSInvocation传给你。做完你自己的处理后，调用invokeWithTarget:方法让某个target触发这个方法
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    [anInvocation setSelector:@selector(unknown)];
    [anInvocation invokeWithTarget:self];
    NSLog(@"%@", anInvocation);
}


- (void)unknown
{
    NSLog(@"如果是在是没有找到这个方法的花 就来这里吧");
}



/*
 *** 方法的调用
    1.在对象类的 dispatch table 中尝试找到该消息。如果找到了，跳到相应的函数IMP去执行实现代码；
 
    2.如果没有找到，Runtime 会发送 +resolveInstanceMethod: 或者 +resolveClassMethod: 尝试去 resolve 这个消息；
 
    3.如果 resolve 方法返回 NO，Runtime 就发送 -forwardingTargetForSelector: 允许你把这个消息转发给另一个对象；
 
    4.如果没有新的目标对象返回， Runtime 就会发送 -methodSignatureForSelector: 和 -forwardInvocation: 消息。你可以发送 -invokeWithTarget: 消息来手动转发消息或者发送 -doesNotRecognizeSelector: 抛出异常。
 */


/*
 ***  这个方法是给一个系统的类动态的添加一个属性
 */
- (void)addProper
{
    //首先定义一个全局变量 用他的地址作为关联对象的key
    static char associateObjectKey;
    //设置关联对象
    objc_setAssociatedObject([NSString class], &associateObjectKey, @"name", OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    NSString * str = objc_getAssociatedObject([NSString class], &associateObjectKey);
    NSLog(@"%@", str);
    
    
    Person * person = [[Person alloc] init];
    person.name = @"你好";
    NSLog(@"%@", person.name);
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
