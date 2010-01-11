@import "CKMetric.j"

@implementation CKLOCMetric : CKMetric
{
    BOOL inMultilineComment;
}

- (id)initWithName:(CPString)aName
{
    if (self = [super initWithName:aName])
    {
        inMultilineComment = NO;
    }
    
    return self;
}

- (void)updateMetricForFile:(id)file line:(CPString)line
{
    [super updateMetricForFile:file line:line];
    
    var index = [[self metric] count] - 1;

    if (inMultilineComment)
    {
        var endMultilineCommentRegEx = new RegExp(".*\\*\\/", "");
        if (endMultilineCommentRegEx.test(line))
        {
            inMultilineComment = NO;
        }
    }
    else if (line.indexOf("/*") === 0)
    {
        inMultilineComment = YES;
    }
    else if (line !== nil && line !== "" && line.indexOf("//") !== 0)
    {
        metric[index]++;
    }
}

@end