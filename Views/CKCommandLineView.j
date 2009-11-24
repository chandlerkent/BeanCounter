@import <Foundation/CPObject.j>

@implementation CKCommandLineView : CPObject
{
    CPArray files @accessors(readonly);
}

- (id)init
{
    if (self = [super init])
    {
        files = [CPArray array];
    }
    
    return self;
}

- (void)reportMetricsForFile:(id)file
{
    CPLog(@"%s not yet implemented in %s.", _cmd, [self className]);
}

- (void)reportMetricsForProject
{
    CPLog(@"%s not yet implemented in %s.", _cmd, [self className]);
}

@end