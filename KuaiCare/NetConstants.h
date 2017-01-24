//
//  NetConstants.h
//  定制公交
//
//  Created by admin on 16/5/26.
//  Copyright © 2016年 KL. All rights reserved.
//

#ifndef NetConstants_h
#define NetConstants_h

//关于时间戳解释
//商务包车和定制公交 第一次请求 或者刷新 selectPage应该为-1，当selectPage不为-1到时候 需要将服务端给的时间戳当参数 一起请求。
//定制公交 部分参数解释 station_type  1 起始站 2 终点站 3途经站  upordown 0 可上可下 1 上  2下

//错误提示
#define Net_Connection_Error @"网络不可达，请检查设置"

#define Net_Connecting @"加载中..."



#endif