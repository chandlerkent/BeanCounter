@import "CKMethodsMetric.j"

@implementation CKTestCasesMetric : CKMethodsMetric
{
}

- (void)updateMetricForFile:(id)file line:(CPString)line
{
    if ([self isFileATestFile:file])
    {
        if ([self addFileIfNew:file])
        {
            methods.push(0);
        }
    }
    
    var index = files.length - 1;

    if ([self isLineAMethod:line] && [self isMethodATestCase:line])
    {
        methods[index]++;
    }
}

@end