// 15 may 2014

#include "objc_darwin.h"
#include <Foundation/NSString.h>
#include <AppKit/NSView.h>
#include <AppKit/NSScrollView.h>

#define to(T, x) ((T *) (x))
#define _toNSString(x) to(NSString, (x))
#define toNSView(x) to(NSView, (x))
#define toNSScrollView(x) to(NSScrollView, (x))

id toNSString(char *str)
{
	return [NSString stringWithUTF8String:str];
}

char *fromNSString(id str)
{
	return [_toNSString(str) UTF8String];
}

void display(id view)
{
	[toNSView(view) display];
}

struct xrect frame(id view)
{
	NSRect r;
	struct xrect s;

	r = [toNSView(view) frame];
	s.x = (intptr_t) r.origin.x;
	s.y = (intptr_t) r.origin.y;
	s.width = (intptr_t) r.size.width;
	s.height = (intptr_t) r.size.height;
	return s;
}

id makeScrollView(id content)
{
	NSScrollView *scrollview;

	scrollview = [[NSScrollView alloc]
		initWithFrame:NSMakeRect(0, 0, 100, 100)];
	[scrollview setHasHorizontalScroller:YES];
	[scrollview setHasVerticalScroller:YES];
	[scrollview setAutohidesScrollers:YES];
	[scrollview setDocumentView:toNSView(content)];
	return scrollview;
}

void giveScrollViewBezelBorder(id scrollview)
{
	[toNSScrollView(scrollview) setBorderType:NSBezelBorder];
}

id scrollViewContent(id scrollview)
{
	return [toNSScrollView(scrollview) documentView];
}