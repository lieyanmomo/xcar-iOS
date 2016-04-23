//
//  Public.h
//  XCAR
//
//  Created by Morris on 9/21/15.
//  Copyright (c) 2015 Samtse. All rights reserved.
//

#ifndef XCAR_Public_h
#define XCAR_Public_h

// 设置颜色
#define TSEColor(r, g, b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]
#define TSEAColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//
#define TableViewContentInset 100

//获取设备的物理高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
//获取设备的物理宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width

#define ScreenWidth5S 320
#define ScreenWidth6 375
#define ScreenWidth6plus 414

// 自定义Log
#ifdef DEBUG
#define TSELog(...) NSLog(__VA_ARGS__)
#else
#define TSELog(...)
#endif

/** 爱卡汽车 */
/** 0. 获取新闻列表 */
#define kGetCarNewsURL @"http://a.xcar.com.cn/interface/6.0/getNewsList.php"
/** 0.1 刷新的新闻数量 （必须是整10的数，比如10，20，30等等，不然不会返回数据）*/
#define LIMIT @"limit"
/** 0.2 刷新状态 0 为刷新最新的新闻 10 为刷新之前的新闻 每加10则加载更久之前的新闻 */
#define OFFSET @"offset"
/** 0.3 新闻的类型 1为最新新闻（大杂烩） 2（国内外新车） 3（评测） 4（导购） 5（行情）*/
#define TYPE @"type"
/** 0.4 version? 传不传没影响 */
#define VER @"ver"

/** 1.获取视频新闻 */
/** type = 144998 (视频) */
#define kGetVideoCarNewsURL @"http://mi.xcar.com.cn/interface/xcarapp/getdingyue.php"

/** 2.获取新闻信息链接 */
#define kGetNewsInfoURL @"http://a.xcar.com.cn/interface/6.0/getNewsInfo.php"
/**
 newsid=1805939 新闻的id
 pubtime=201505 新闻发布时间
 uid=7916227 用户的uid
 */

/** 3.获取论坛信息  limit=20&offset=0&ver=6.2 */
#define kGetForumInfoURL @"http://mi.xcar.com.cn/interface/xcarapp/getSelectedPostList.php"
// 热帖 limit=20&offset=0&ver=6.2
#define kGetHotPostURL @"http://my.xcar.com.cn/app/6/getHotPostList.php"

/** 4.获取所有车品牌 */
#define kGetAllXCarBrandsURL @"http://mi.xcar.com.cn/interface/xcarapp/getBrands.php"

/** 4.1 各车品牌的车型 */
// 参数：brandId 1 = Audi 56 = Aston Martin （id号不是按字母来的）
#define kGetCarSubBrandsURL @"http://mi.xcar.com.cn/interface/xcarapp/getSeriesByBrandId.php"

#define kGetSpecialSaleURL @"http://mi.xcar.com.cn/interface/xcarapp/getSpecialSale.php?cityId=348&deviceId=668B4D65-724E-461E-A389-905F158A0871&provinceId=30&uid=7916227"


#define PARAM @"param"
/**
 参数
 param = param
 
 数据分析
 brands 数组 品牌
 icon 车标图片
 keyword 品牌名 （宝马）
 subBrandNum 分类数量 3
 
 subBrands 数组 该品牌的所有分类
 series 数组 该分类的车型
 icon 车型图片
 name 车型名字
 price 价格范围
 subBrandName 分类名字（华晨宝马、宝马(进口)、宝马M）
 */

/** 5.获取降价信息 */
// 降价
// brandId = 0; cityId = 475; provincedId = 1; seriesId = 0; sortType = 1;
// sortType 1 降幅最大 2 价格最低 3 价格最高
#define BRANDID @"brandId"
#define CITYID @"cityId"
#define PROVINCEID @"provincedId"
#define SERIESID @"seriesId"
#define SORTTYPE @"sortType"
#define kGetDiscountInfoURL @"http://mi.xcar.com.cn/interface/xcarapp/getDiscountList.php"
// 活动
#define kGetSalesInfoURL @"http://a.xcar.com.cn/interface/6.0/getEventList.php"
// CityId
// 348 = Shenzhen
// 475 = Beijing
// getRakingList
// 车有惠
#define kGetSalesByCityId @"http://mi.xcar.com.cn/interface/xcarapp/getSaleListByCityId.php"






/*******************************************************************************************/
/*******************************************************************************************/
/*******************************************************************************************/

/** 汽车之家 */
/** 最新 */
#define kGetLatestNewsURL @"http://app.api.autohome.com.cn/autov4.7/news/newslist-pm1-c0-nt0-p1-s30-l0.json"

/** 快报 */
#define kGetBreakingNewsURL @"http://app.api.autohome.com.cn/autov4.7/news/fastnewslist-pm1-b0-l0-s20-lastid0.json"

/** 视频 */
#define kGetVideoURL @"http://app.api.autohome.com.cn/autov4.7/news/videolist-pm1-vt0-s30-lastid0.json"

/** 评测 */
#define kGetEvaluatingNewsURL @"http://app.api.autohome.com.cn/autov4.7/news/newslist-pm1-c0-nt3-p1-s30-l0.json"

/** 导购 */
#define kGetGuideNewsURL @"http://app.api.autohome.com.cn/autov4.7/news/newslist-pm1-c0-nt60-p1-s30-l0.json"

/** 行情 */
#define kGetMarketNewsURL @"http://app.api.autohome.com.cn/autov4.7/news/newslist-pm1-c110100-nt2-p1-s30-l0.json"

/** 用车 */
#define kGetUseCarNewsURL @"http://app.api.autohome.com.cn/autov4.7/news/newslist-pm1-c0-nt82-p1-s30-l0.json"

/** 技术 */
#define kGetTechNewsURL @"http://app.api.autohome.com.cn/autov4.7/news/newslist-pm1-c0-nt102-p1-s30-l0.json"

/** 文化 */
#define kGetCultureNewsURL @"http://app.api.autohome.com.cn/autov4.7/news/newslist-pm1-c0-nt97-p1-s30-l0.json"

/** 改装 */
#define kGetChangedNewsURL @"http://app.api.autohome.com.cn/autov4.7/news/newslist-pm1-c0-nt107-p1-s30-l0.json"

/** 原创视频 */
#define kGetOriginalVideoURL @"http://app.api.autohome.com.cn/autov4.7/news/videolist-pm1-vt8-s30-lastid0.json"

/** 说客 */
#define kGetShuoKeURL  @"http://app.api.autohome.com.cn/autov4.7/news/shuokelist-pm1-s30-lastid0.json"

/** 品牌 */
#define kGetAllAutoCarBrandsURL @"http://app.webcars.com.cn/default.aspx"
#define MSGID @"MsgID"

/**
 0. 参数
 MsgID ＝ getAllBrandList
 
 1. 数据分析
     总数组，包含所有的汽车品牌
     ListContents =
        (
            {    该组的品牌数量
                 GroupCount = 2;
                 该组品牌的详细信息
                 GroupInfo =
                    (
                        {
                            品牌id
                            BrandID = 1;
                            品牌名字
                            MainBrandName = "\U5965\U8fea";
                            品牌logo图片
                            imgURL = "http://www.webcars.com.cn/CarsPhoto/Brands/0/1.png";
                        },
                        {
                            BrandID = 57;
                            MainBrandName = "\U963f\U65af\U987f\U00b7\U9a6c\U4e01";
                            imgURL = "http://www.webcars.com.cn/CarsPhoto/Brands/0/57.png";
                        }
                    );
     
                该组品牌的拼音首字母
                PinYin = A;
            },
        )
*/

#endif
