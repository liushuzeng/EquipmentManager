//
//  Constants.h
//  Topka2.0
//
//  Created by wangdongdong on 13-1-18.
//  Copyright (c) 2013年 Topka. All rights reserved.
//

// 配置，0：线上  1：测试
#define DEPLOYMENT_ENVIRONMENT          1

// 渠道，0：App Store   1：越狱
#define DEPLOYMENT_CHANNEL              0

#define DISPLAY_GUIDE_WHEN_UPDATE_APP   YES      // 更新版本时是否需要显示引导页

// 是否显示闪屏页面
#define ShowSlash       0

// 闪屏页停留时间，单位秒
#define SLASH_TIME  5

#define COMPANY_SERVICE_PHONE   @"400-686-9976" // 公司服务电话

// 接口相关常量
#define ENCRYPT_SALT    @"topka20111011no1"     // 给定的用于加密的值，假定值
#define ENCRYPT_LOGIN   @"tk201411"             // 用于自动登录的加密值
#define ENCRYPT_SMS     @"tk201508"             // 用于发送验证码的加密值
#define CLIENT_SECRET   @"HWk2m5dU6u88cdOYVqa6S0488WNSX0L9"     // 客户端密钥
#define ATT_TOKEN       @"apptoken"             // http头里的自定义字段

//无手势tag
static const int kInvalidPanGestureTag = 55555;
//首页guideView的tag
static const int kbuyGuideTag = 20079;

//讨论详细底部输入框初始化高度
static int const KEYBOARD_HEIGHT = 53.0;//150.0;

// 自定义通知
#define ApplicationActveNotification @"MyAppActive"

//通信返回条数
#define   MESSAGE_COUNT             10

//图片压缩系数
#define PIC_ARCHIVE                 0.3
// 数据库版本
#define DB_VERSION                  @"DB_VERSION"
// 报价详情引导
#define QUOTE_GUIDE                 @"QUOTE_GUIDE"

#define ASKPRICE_FIRST_2CITY        @"ASKPRICE_FIRST_2CITY"
#define ASKPRICE_2CITY_REPORT       @"ASKPRICE_2CITY_REPORT"

// 第三方相关参数
// 微信
#define WECHAT_APP_ID       @"wx7a86cf5005a8a6b1"
// 腾讯QQ
#define TENCENT_APP_ID      @"100543694"
#define TENCENT_APP_KEY     @"d85a62462abb71ac9f35b5e6ab5ca8df"
#define QQ_APP_ID           @"05FE2CCE"
// 友盟
#define MOBCLICK_APP_KEY                @"526a13b456240b8eda00ee7f"
// 腾讯微博
#define TENCENT_WEIBO_APP_KEY           @"801433218"
#define TENCENT_WEIBO_APP_SECRET        @"50b919c0391ed2b344392448f0d5da77"
#define TENCENT_WEIBO_APP_REDIRECT_URI  @"http://topka.cn"
// 新浪微博
#define SINA_WEIBO_APP_KEY              @"1311409611"
#define SINA_WEIBO_APP_SECRET           @"a08065376ec27c6580a7eeca08e9032a"
#define SINA_WEIBO_APP_REDIRECT_URI     @"http://topka.cn"

// 友盟统计版本：3.1.8
// 友盟意见反馈：1.4.2

// 第三方类型
#define TYPE_SINA_WEIBO                 @"sina"
#define TYPE_TENCENT_QQ                 @"space"

// 设备相关
extern CGFloat FIXED_DEVICE_WIDTH;          // 正常竖屏情况下的屏幕宽度
extern CGFloat FIXED_DEVICE_HEIGHT;         // 正常竖屏情况下的屏幕高度
#define STATUSBAR_HEIGHT            20.0    // 状态栏高度
#define NAVIGATIONBAR_HOR_HEIGHT    32.0    // 导航栏横屏高度
#define NAVIGATIONBAR_HEIGHT        44.0    // 导航栏高度
#define TABBAR_HEIGHT               49.0    // tabbar高度
#define PULLREFRESHVIEW_HEIGHT      44.0        // 下拉刷新视图高度
#define DEVICE_WIDTH            [[UIScreen mainScreen] bounds].size.width
#define DEVICE_HEIGHT           [[UIScreen mainScreen] bounds].size.height
#define REFRESH_FOOTER_HEIGHT 60.0      // 表视图footer高度（查看更多）
#define IPHONE5                 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640.0, 1136.0), [[UIScreen mainScreen] currentMode].size) : NO)

#define NAVIGATIONBAR_ITEM_FRAME    CGRectMake(0.0, 0.0, 37.0, 35.0)

#define IOS_VERSION_7_OR_ABOVE      (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) ? (YES) : (NO))

#define IOS_VERSION_8_OR_ABOVE      (([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) ? (YES) : (NO))

#define IOS_VERSION_9_OR_ABOVE      (([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0) ? (YES) : (NO))

// 对话框
#define ALERT_TITLE_PROMPT              @"提示"
#define ALERT_BUTTON_TITLE_CONFIRM      @"确定"
#define ALERT_BUTTON_TITLE_CANCEL       @"取消"
// 操作表
#define ACTIONSHEET_BUTTON_TITLE_CANCEL @"取消"
#define ACTIONSHEET_BUTTON_TITLE_DONE   @"确定"
#define NEXT_TIME                       @"下次再说"
#define UPGRADE_NOW                     @"立即升级"
#define ACTIONSHEET_BUTTON_TITLE_CAMERA                 @"拍照"
#define ACTIONSHEET_BUTTON_TITLE_PHOTO_LIBRARY          @"用户相册"
#define ALERT_MESSAGE_NOT_AVAILABLE     @"该功能不可使用！"

#define ALERT_MESSAGE_SAVE_IMAGE_FAILED @"图片保存失败！"

#define SHARE_DESCRIPTION               @"分享"
#define RECOMMEND_FRIENDS               @"推荐给好友"
#define SHARE_DEFAULT_IMAGE             @"app_sharelogo"

#define COMMET_REMOVED                  @"该评论已被删除"
#define DISCUSS_REMOVED                 @"抱歉，此讨论已被删除"

// 最新版本下载地址
#define MY_APP_ID                       @"657077786"
#define LATEST_VERSION_DOWNLOAD_URL     @"http://itunes.apple.com/cn/app/mai-che-da-ren/id657077786?ls=1&mt=8"

#define USERS_LOGIN_REQUEST_URL         @"http://%@/users/login/"                   // oauth登录及验证接口
#define USERS_LOGOUT_REQUEST_URL        @"http://%@/users/logout/"                  // 登出接口
#define VERSION_REQUEST_URL             @"http://%@/version/"                       // 获取最新版本信息
#define SETPUSH_REQUEST_URL             @"http://%@/users/set-push/"                // 设置推送开关
#define SETSMS_REQUEST_URL              @"http://%@/users/set-sms-power/"           // 设置用户短信开关
#define USERS_SENDCODE_REQUEST_URL      @"http://%@/users/sendcode/"                // 发送验证码接口
#define USERS_AUTH_PHONE_REQUEST_URL    @"http://%@/users/auth-phone/"              // 手机号码验证接口
#define GET_USERS_CALL_URL              @"http://%@/users/call/"                    // 通话记录接口
#define CHANGE_PHONE_NUMBER_URL         @"http://%@/users/phone/"                   // 修改手机接口
#define CHANGE_USERS_NICK_URL           @"http://%@/users/nick/"                    // 修改昵称接口
#define CHANGE_USERS_PASSWORD_URL       @"http://%@/users/password/"                // 修改密码接口
#define USERS_UPDATE_PHONE_REQUEST_URL  @"http://%@/users/update-phone/"            // 修改手机号 第二步验证接口
#define MOD_AVATAR_REQUEST_URL          @"http://%@/users/avatar/"                  // 修改头像接口
#define USER_SEND_CODE_URL              @"http://%@/users/sendcode/"                // 发送验证码
#define RESET_PASSWORD_URL              @"http://%@/users/reset-password/"          // 重置密码
#define USERS_REGISTER_REQUEST_URL      @"http://%@/users/register/"                // 注册接口
#define SAVE_CALL_URL                   @"http://%@/users/call-save/"               // 保存电话记录接口
#define DELETE_CALL_URL                 @"http://%@/users/delete-call/"             // 清空通话记录接口
#define MODEL_REQUEST_URL               @"http://%@/cars/get-series/"               // 车型接口
#define SEND_ASKPRICE_URL               @"http://%@/ask-prices/send-ask-price/"     // 询价接口
#define PRICE_DETAIL_REQUEST_URL        @"http://%@/ask-prices/detail/"             // 询价详情接口
#define PRICE_SATISE_REQUEST_URL        @"http://%@/ask-prices/satisfaction/"       // 满意度打分
#define PRICEHISTORY_REQUEST_URL        @"http://%@/ask-prices/history/"            // 获取询价历史接口
#define ASK_PRICE_CITYS_URL             @"http://%@/ask-prices/ask-price-citys/"    // 询价城市
#define ASK_PRICE_CITYS_LIST_URL        @"http://%@/ask-prices/ask-price-city-list/"// 添加询价城市
#define MY_QUOTE_LIST_URL               @"http://%@/ask-prices/get-ask-list/"       // 我的询价列表
#define DELETE_QUOTE_URL                @"http://%@/ask-prices/del-ask/"            // 删除询价
#define QUOTE_DETAIL_URL                @"http://%@/ask-prices/get-reply-list/"     // 询价详情
#define DISCUSSIONS_ADD_REQUEST_URL     @"http://%@/discussions/add/"               // 添加讨论接口
#define DIS_DETAIL_REQUEST_URL          @"http://%@/discussions/detail/"            // 获取讨论详情接口
#define PARSE_REQUEST_URL               @"http://%@/discussions/zan-car/"           // 推荐车点赞接口
#define ADDCAR_REQUEST_URL              @"http://%@/discussions/add-car/"           // 讨论详情加车接口
#define DISCUSS_REQUEST_URL             @"http://%@/discussions/get-list/"          // 讨论列表接口
#define DISCUSS_SEARCH_REQUEST_URL      @"http://%@/discussions/search-list/"       // 讨论搜索接口
#define DISCUSS_SEARCH26_REQUEST_URL    @"http://%@/discussions/search-list/"       // 讨论2.6搜索接口
#define NOTIFICATION_REQUEST_URL        @"http://%@/feeds/index/"                   // 通知接口
#define GET_CMT_REQUEST_URL             @"http://%@/discussions/comments/"          // 评论列表接口
#define ADD_CMT_REQUEST_URL             @"http://%@/discussions/add-comment/"       // 添加评论接口
#define GET_DISCUSSIONS_RELATIONS       @"http://%@/discussions/relations/"         // 车型页相关讨论接口
#define DEALERS_REQUEST_URL             @"http://%@/dealers/get-list/"              // 获取经销商列表接口
#define ASKWANT_REQUEST_URL             @"http://%@/dealers/need-sales/"            // 需要销售顾问接口
#define SALERS_REQUEST_URL              @"http://%@/sales/get-list/"                // 获取经销商销售顾问接口
#define SALES_HOME_URL                  @"http://%@/sales/home/"                    // 卖车达人销售主页
#define SALES_DRIVE_URL                 @"http://%@/sales/drive/"                   // 预约试驾
#define DEL_CMT_REQUEST_URL             @"http://%@/comments/remove/"               // 删除评论接口
#define PARSE_CMT_REQUEST_URL           @"http://%@/comments/zan/"                  // 赞评论接口
#define CARS_HOT_BRANDS_REQUEST_URL     @"http://%@/cars/hot-brands/"               // 热门品牌接口
#define GET_CAR_PICS_REQUEST_URL        @"http://%@/cars/get-series-pics/"          // 得到车图接口
#define GET_SP_CAR_PICS_REQUEST_URL     @"http://%@/special-models/car-image-list/" // 得到特价实车图接口
#define GET_CAR_PARAMS_REQUEST_URL      @"http://%@/cars/properties/"               // 车型参数接口
#define GET_CAR_HOTRANKING_URL          @"http://%@/cars/hots/"                     // 热销排行接口
#define GET_OPENED_BRANDS_REQUEST_URL   @"http://%@/cars/get-opened-brands/"        // 获取开通的品牌
#define GET_OPENED_SERIES_REQUEST_URL   @"http://%@/cars/get-opened-series/"        // 获取开通品牌的车系
#define GET_OPENED_MODELS_REQUEST_URL   @"http://%@/cars/get-opened-models/"        // 获取开通车系的车型
#define GET_FEED_BACKS_LIST_URL         @"http://%@/feedbacks/getlist/"             // 举报列表接口
#define GET_FEED_BACKS_DETAIL_URL       @"http://%@/feedbacks/detail/"              // 举报详情接口
#define DISCUSS_ME_REQUEST_URL          @"http://%@/feeds/index/"                   // 与我相关接口
#define INDEX_AD_REQUEST_URL            @"http://%@/index/ad/"                      // 首页活动接口
#define ADD_REPORT_PRICE_URL            @"http://%@/reply-prices/report/"           // 举报添加接口
#define MINECARS_REQUEST_URL            @"http://%@/cars/mine-cars/"                // 车库列表接口
#define MINESADDCAR_REQUEST_URL         @"http://%@/cars/add-mine-car/"             // 添加车到车库接口
#define MINESDELCAR_REQUEST_URL         @"http://%@/cars/del-mine-cars/"            // 取消车到车库接口
#define MOD_SEX_REQUEST_URL             @"http://%@/users/modify/"                  // 修改性别接口
#define GET_BUBBLE_REQUEST_URL          @"http://%@/users/get-bubble/"              // 获取气泡接口
#define USERS_CITY_URL                  @"http://%@/users/city/"                    // 个人资料修改城市
#define SALES_DRIVE_LIST_URL            @"http://%@/sales/drive-list/"              // 预约试驾列表
#define SALES_DRIVE_DEL_URL             @"http://%@/sales/drive-del/"               // 清空预约试驾
#define SALES_DRIVE_DETAIL_URL          @"http://%@/sales/drive-detail/"            // 预约试驾详情
#define REPLY_CMT_URL                   @"http://%@/discussions/reply-comment/"     // 回复评论
#define CONTACT_URL                     @"http://%@/ask-prices/get-contact/"        // 经销商
#define PROMOTIONS_LIST_URL             @"http://%@/promotions/get-list/"           // 优惠列表
#define GIF_LIST_URL                    @"http://%@/gifts/get-list/"                // 礼券列表
#define GET_ASK_CITIES                  @"http://%@/cities/get-ask-cities/"         // 开通品牌的城市
#define SEND_ASK_PRICE                  @"http://%@/ask-prices/send-ask-price/"     // 询价
#define REPLY_CMT_URL                   @"http://%@/discussions/reply-comment/"     // 回复评论
#define SALES_LIST                      @"http://%@/models/get-sales-list/"         // 销售顾问
#define ASK_PRICE_CAR_ASK_URL           @"http://%@/ask-prices/car-ask/"            // 询价页面
#define BUYCAR_HOME_URL                 @"http://%@/index/home/"                    // 首页
#define DIS_DETAIL_LIKING_URL           @"http://%@/discussions/own-car/"           // 中意/取消中意
#define DISCUSSIONS_OTHER_CARS          @"http://%@/discussions/other-cars/"        // 查看网友推荐车型
#define DISCUSSIONS_MINE                @"http://%@/discussions/mine/"              // 我发起的讨论
#define DISCUSSIONS_JOIN                @"http://%@/discussions/join/"              // 我参与的讨论
#define DIFF_MODEL_LIST_URL             @"http://%@/cars/diff-model/"               // 车型对比列表
#define MYORDERLIST_URL                 @"http://%@/total-order/index/"    // 我的订单列表
#define CANCELORDER_URL                 @"http://%@/special-model-orders/cancel/"   // 取消订单
#define MY_ACCOUNT_URL                  @"http://%@/users/account/"                 // 我的账户
#define PAYMENT_URL                     @"http://%@/special-model-orders/pay-detail/" // 支付订金
#define JUSTPAYMENT_URL                 @"http://%@/special-model-orders/pay-action/" // 立即支付
#define BARGAINCAR_HOME_URL             @"http://%@/special-models/index/"          // 特价车首页
#define BARGAINCAR_LIST_URL             @"http://%@/special-models/all/"            // 特价车列表
#define BARGAINCAR_DETAIL_URL           @"http://%@/special-models/detail/"         // 特价车详细
#define BARGAINCAR_ORDER_DETAIL_URL     @"http://%@/special-model-orders/detail/"   // 特价订单详情
#define PURCHASEGOLD_URL                @"http://%@/users/model-cashes-index/"      // 购车金首页
#define PURCHASEGOLD_LIST_URL           @"http://%@/users/model-cashes-list/"       // 购车金流水
#define USERS_CASHES_INDEX              @"http://%@/users/cashes-index"             // 账户余额首页
#define USERS_CASHES_LIST               @"http://%@/users/cashes-list"              // 账户余额列表
#define BARGAINCAR_ORDER_CERTIF_URL     @"http://%@/special-model-orders/get-payment-voucher/"            // 特价车订单支付凭证
#define BARGAINCAR_ORDER_WATING_URL     @"http://%@/special-model-orders/waiting-payment-voucher/"        // 特价车订单支付轮询
#define BARGAINCAR_ORDER_DIFFER_URL     @"http://%@/special-model-orders/differ-payment-voucher/"        // 特价车订单支付轮询 - 不是我的车
#define BARGAINCAR_ORDER_CANCEL_URL     @"http://%@/special-model-orders/cancel-payment-voucher/"        // 特价车订单支付轮询 - 取消支付
#define BARGAINCAR_ORDER_CONFIRM_URL    @"http://%@/special-model-orders/confirm-payment-voucher/"        // 特价车订单支付轮询 - 确认支付
#define BARGAINCAR_CANCEL_BUY_CAR_URL   @"http://%@/special-model-orders-cancel/"                         // 特价车订单取消购车
#define UESRS_SEND_APPLE_WITHDRAW_CODE  @"http://%@/users/send-apply-withdraw-code/"  // 提现页获取验证码
#define USERS_APPLE_WITHDRAW            @"http://%@/users/apply-withdraw/"            // 提现页提交
#define UPLOAD_INVOICE                  @"http://%@/users/apply-model-cashes/"        // 上传发票
#define UPLOAD_INVOICESTATE             @"http://%@/users/apply-model-cashes-detail/" // 账户购车金返现详情
#define BUY_CAR_MONEY_BACR_RECORED_URL  @"http://%@/users/apply-model-cashes-list/"                       // 购车金返现记录
#define GET_HOME_SERIES_REQUEST_URL     @"http://%@/cars/series-list/"        // 获取开通品牌的车系

#define BOND_URL                        @"http://%@/reverse-bid-order/order-generate/" // 支付保证金
#define JUSTBOND_URL                    @"http://%@/reverse-bid-order/order-pay/"     // 立即支付保证金
#define HAGGLE_CONFIRM_DETAIL_URL       @"http://%@/reverse-bid-order/clinch-deal/"                       //  确认购车展示接口
#define HAGGLE_I_WANT_REPORT_URL        @"http://%@/reverse-bid-order/complaints/"                       // 我要举报订单
#define HAGGLE_CONFIRM_MAKESURE_URL     @"http://%@/reverse-bid-order/clinch-deal-pay/"                       // 确认购车支付接口
#define CARBUYINGINTENT_DETAIL_URL      @"http://%@/reverse-bid-order/order-bid-detail/"                       // 购车意向单详情
#define HAGGLE_HAGGLE_DETAIL_URL        @"http://%@/reverse-bid-order/order-detail/"                       // 砍价订单
#define HAGGLE_ADJUEST_CANCEL_URL       @"http://%@/reverse-bid-order/adjust-bids/"                       // 调整出价
#define HAGGLE_ORDER_LIST_URL           @"http://%@/reverse-bid-order/bid-list/"          // 砍价列表
#define HAGGLE_ORDER_GEN_URL            @"http://%@/reverse-bid-order/order-generate/"    // 生成砍价订单
#define HAGGLE_INTENSION_URL            @"http://%@/reverse-bid-order/intention/"         // 购车意向页面
#define HAGGLE_HAGGLE_CANCEL_URL        @"http://%@/reverse-bid-order/cancel-order-confirm/"                       // 取消砍价订单
#define HAGGLE_ADJUEST_MONERY_URL       @"http://%@/reverse-bid-order/adjust-bids/"                       // 调整出价
#define USERS_SET_PASSWORD_PAGE         @"http://%@/users/set-password-page/"                       // 是否需要显示原密码
#define USERS_DISCUSSION_MODIFY         @"http://%@/users/discussion_modify/"                       // 个人资料保存
#define HAGGLE_LAUCH_URL   @"http://%@/reverse-bid-order/bid-launch/"     // 发起砍价页面相关信息
#define HAGGLE_COUNT_URL   @"http://%@/stats/reverse-bid-order-count/"    // 获取使用砍价的人数
#define HAGGLE_SUBMIT_URL  @"http://%@/reverse-bid-order/bid-launch-submit/"    // 发起砍价页面提交
#define HAGGLE_DEMAND_URL  @"http://%@/reverse-bid-order/bid-demand/"    // 购车需求页面
#define HAGGLE_DEMAND_SUBMIT_URL  @"http://%@/reverse-bid-order/bid-demand-submit/"    // 购车需求页面提交
#define HAGGLE_PAY_CENCAL_SEND_SMS             @"http://%@/reverse-bid-order/send-sms/"     // 未支付订单时发送短信
#define ASK_PRICE_COUNT_URL   @"http://%@/stats/ask-price-count/"    // 获取使用询价的人数
#define BUY_MODELS_CAR_VIEW_URL   @"http://%@/models/detail/"    // 车型也
#define EVALUATION_CAR_VIEW_URL   @"http://%@/cars/get-reviews/"    // 评测列表

#define CHECK_DEALER_OR_SALER_URL   @"http://%@/ask-prices/check-ask/"    // 检测可以询价的销售经或销商数量
#define DEALERS_ASK_DEALERS_URL   @"http://%@/dealers/ask-dealers/"    //  可询价的经销商列表

// 根据RGB得到UIColor
#define COLOR(R, G, B, A)               [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]
#define BAR_COLOR                       COLOR(0x27,0x2d,0x33,1.0)       // 导航栏、标签栏背景颜色
#define VIEW_BG_COLOR                   COLOR(0xed,0xed,0xed,1.0)       // 视图背景颜色
#define TABLEVIEW_BG_COLOR              COLOR(0xed,0xed,0xed,1.0)       // tableview视图背景颜色
#define TABLE_LINE_COLOR                COLOR(0xcc,0xcc,0xcc,1.0)       // tableview视图分割线颜色
#define CELL_NORMAL_BG_COLOR            COLOR(0xff,0xff,0xff,1.0)       // 单元格背景颜色
#define CELL_HIGHLIGHT_BG_COLOR         COLOR(0xd4,0xd4,0xd4,1.0)       // 单元格高亮时背景颜色
#define BRAND_BLACK_COLOR               COLOR(0x33,0x33,0x33,1.0)       // 品牌黑
#define BRAND_LIGHT_BLACK_COLOR         COLOR(0x66,0x66,0x66,1.0)       // 品牌浅黑
#define BRAND_GRAY_COLOR                COLOR(0x99,0x99,0x99,1.0)       // 品牌灰
#define BRAND_ORANGE_COLOR              COLOR(0xff,0x75,0x22,1.0)       // 品牌橙
#define BRAND_GREEN_COLOR               COLOR(0x51,0xb3,0x34,1.0)       // 品牌绿
#define BRAND_LIGHT_GREEN_COLOR         COLOR(0x51,0xb2,0x34,1.0)       // 品牌浅绿
#define BRAND_PHONE_GREEN_COLOR         COLOR(0x53,0xb4,0x36,1.0)       // 品牌电话号码绿色
#define BRAND_LIGHT_GRAY_COLOR          COLOR(0xed,0xed,0xed,1.0)       // 品牌浅灰
#define BRAND_DEEP_GRAY_COLOR           COLOR(0xed,0xed,0xed,1.0)       // 品牌深灰
#define BRAND_BLUE_COLOR                COLOR(0.0,77.0,153.0,1.0)       // 品牌蓝
#define BRAND_RED_COLOR                 COLOR(205.0,35.0,45.0,1.0)      // 品牌红
#define BRAND_ERROR_RED_COLOR           COLOR(0xff,0x00,0x00,1.0)      // 失败时的红色
#define BRAND_HAGGLE_RED_COLOR          COLOR(0xff,0x3c,0x3c,1.0)      // 失败时的红色
#define BRAND_LIGHT_BLUE_COLOR          COLOR(0x21,0x96,0xf3,1.0)       // 品牌浅蓝
#define BRAND_WHITE_COLOR               COLOR(0xff,0xff,0xff,1.0)       // 品牌白色
#define SHARE_BUTTONTEXT_COLOR          COLOR(0x15,0x7d,0xfb,1.0)       // 分享面板按钮文字颜色
#define INPUT_FIELD_BG_COLOR            COLOR(0xe8,0xe8,0xe8,1.0)       // 输入框背景颜色
#define INPUT_FIELD_BORDER_COLOR        COLOR(0xdd,0xdd,0xdd,1.0)       // 输入框边框颜色
#define QUOTATION_CHARTS_GRAY_COLOR     COLOR(0xfa,0xfa,0xfa,1.0)       // 走势图背景色
#define UIColor(hexValue)               [UIColor colorWithRed:((float)((hexValue & 0xFF0000) >> 16))/255.0\
                                                        green:((float)((hexValue & 0xFF00) >> 8))/255.0\
                                                         blue:((float)(hexValue & 0xFF))/255.0 alpha:1.0]//获取16进制颜色


// 按钮部分
#define BRAND_BUTTON_COLOR                  COLOR(0xff,0xff,0xff,1.0)       // 白色按钮底色
#define BRAND_BUTTON_CLICK_COLOR            COLOR(0xe5,0xe5,0xe5,1.0)       // 白色按钮点按底色
#define BRAND_BUTTON_CIRCLE_COLOR           COLOR(0xed,0xed,0xed,1.0)       // 圆角按钮底色
#define BRAND_BUTTON_CIRCLE_CLICK_COLOR     COLOR(0xe4,0xe4,0xe4,1.0)       // 圆角按钮点按底色
#define BUTTON_CIRCLE_LINE_COLOR            COLOR(0xe0,0xe0,0xe0,1.0)       // 描边底色
#define BRAND_BUTTON_ORANGE_COLOR           COLOR(0xff,0x75,0x22,1.0)       // 橙色按钮底色
#define BRAND_BUTTON_ORANGE_CLICK_COLOR     COLOR(0xe5,0x69,0x1f,1.0)       // 橙色按钮点按底色
#define BRAND_BUTTON_GRAY_DISABLE_COLOR     COLOR(0xcc,0xcc,0xcc,1.0)       // 灰色禁用按钮底色
#define BUTTON_CIRCLE           2           //圆角2
#define BUTTON_CIRCLE_LINE      0.5         //描边0.5

#define JZ_WIDTH        145.0                               // 加载中宽度
#define JZ_LONG_WIDTH   150.0                               // 长的加载中宽度
#define JZ_HEIGHT       145.0                               // 加载中高度
#define JZ_X_LOC (DEVICE_WIDTH/2-JZ_WIDTH/2)                // 加载中左上角X坐标
#define JZ_LONG_X_LOC (DEVICE_WIDTH/2-JZ_LONG_WIDTH/2)      // 长的加载中左上角X坐标
#define JZ_Y_LOC ((DEVICE_HEIGHT-STATUSBAR_HEIGHT-NAVIGATIONBAR_HEIGHT)/2-JZ_HEIGHT/2)  // 加载中左上角Y坐标

#define RETURN_TRUE     @"true"     // 验证信息OK
#define RETURN_FALSE    @"false"    // 验证信息NG
#define STR_RESULT      @"result"
// 产生的随机数最大、最小值
#define RANDOM_MAX      9999
#define RANDOM_MIN      1000

//间距
#define LEFTMARGIN      15.0
#define RIGHTMARGIN     15.0

// 字体
#define FONT(S)                     [UIFont systemFontOfSize:S]
#define BOLD_FONT(S)                [UIFont boldSystemFontOfSize:S]

// 用户偏好设置
#define USER_DEFAULTS_KEY_BOTHER_MODE           @"BotherMode"       // 勿扰模式
#define USER_DEFAULTS_KEY_APP_VERSION           @"AppVersion"       // App版本号
#define USER_DEFAULTS_KEY_GUIDE_DISPLAYED       @"GuideDisplayed"   // 引导是否显示过
#define USER_DEFAULTS_KEY_SAVE_DISCUSSION       @"SaveDiscussion"   // 讨论草稿

#define USER_DEFAULTS_KEY_DEFAULTBUY            @"BuyGuide"         // 首页引导页
//push前弹框标示
#define USER_DEFAULTS_KEY_PUSH                  @"PushGuide"        // push前弹框

// 用户位置
#define USER_LOCATION               @"userLocation"
#define USER_UPDATE_LOCATION        @"userUpdateLocation"
#define USER_BUY_CAR_CITY           @"userBuyCarCity"
#define SALER_CITY                  @"Saler_City"
#define DEALER_CITY                 @"Dealer_City"

#define DEFUALT_CITY                @"北京"
#define DEFUALT_LON                 116.40
#define DEFUALT_LAT                 39.90

//通知
#define kModNameNotification                        @"kModNameNotification"        //修改名字通知
#define kUpdateLocalityNotification                 @"updateUserLocation"
#define kBuyCarCityChangedNotification              @"kBuyCarCityChangedNotification"//购车城市
#define kUserLocalityChangedNotification            @"kUserLocalityChangedNotification"//所在位置
#define kLoginSuccessedNotification                 @"kLoginSuccessedNotification"
#define kLogoutSuccessedNotification                @"kLogoutSuccessedNotification"
#define kModifyPhoneNoSuccessedNotification         @"kModifyPhoneNoSuccessedNotification"
#define kUpdateDataBaseNotification                 @"kUpdateDataBaseNotification"
#define kModAvatarSuccessedNotification             @"kModAvatarSuccessedNotification"
#define kSendDiscussionSuccessedNotification        @"kSendDiscussionSuccessedNotification"
#define kAnonymousLoginSuccessedNotification        @"kAnonymousLoginSuccessedNotification"//匿名登录成功通知

#define kCarSeriesAskSuccessedNotification          @"kCarSeriesAskSuccessedNotification"//在车系页询价，成功后跳到车系页通知
#define kQuoteDetailAskSuccessedNotification        @"kQuoteDetailAskSuccessedNotification"//在询价详情页再次询价，成功后跳到我的询价列表通知
#define kQuoteDetailPushAskSuccessedNotification    @"kQuoteDetailPushAskSuccessedNotification"//在询价详情页再次询价，成功后跳到我的询价列表通知（push专用）
#define kOnlineAskSuccessedNotification             @"kOnlineAskSuccessedNotification"//线上询价成功后，跳到我的询价列表通知
#define kCarModelAskSuccessedNotification           @"kCarModelAskSuccessedNotification"//在车型页询价，成功后跳到车型页通知

#define kGeneralSendSuccessedNotification           @"kGeneralSendSuccessedNotification"//提现成功 跳转通知
#define kConfirmCarSendSuccessedNotification        @"kConfirmCarSendSuccessedNotification"//确认我的车成功 跳转通知
#define kPaymentToDepositSendSuccessedNotification  @"kPaymentToDepositSendSuccessedNotification"//支付成功 跳转通知
#define kHaggleListSendSuccessedNotification        @"kHaggleListSendSuccessedNotification"//发起砍价成功通知：首页
#define kQuotePriceSendSuccessedNotification        @"kQuotePriceSendSuccessedNotification"//发起砍价成功通知：比价详情
#define kQuoteDetailSendSuccessedNotification       @"kQuoteDetailSendSuccessedNotification"//发起砍价成功通知：报价明细
#define kBuyCarHomeSendSuccessedNotification        @"kBuyCarHomeSendSuccessedNotification"//发起砍价成功通知：订单列表
#define kHaggleListBondSuccessedNotification        @"kHaggleListBondSuccessedNotification"//发起砍价支付页返回通知：首页
#define kQuotePriceBondSuccessedNotification        @"kQuotePriceBondSuccessedNotification"//发起砍价支付页返回通知：比价详情
#define kQuoteDetailBondSuccessedNotification       @"kQuoteDetailBondSuccessedNotification"//发起砍价支付页返回通知：报价明细
#define kCarSeriesBondSuccessedNotification         @"kCarSeriesBondSuccessedNotification"//车系页支付返回通知
#define kCarSeriesSendSuccessedNotification         @"kCarSeriesSendSuccessedNotification"//车系页支付成功通知

//从砍价详情也进入支付页面后，支付页面的返回通知
#define kHaggleDetailBackNotification               @"kHaggleDetailBackNotification"//从砍价详情也进入支付页面后，支付页面的返回通知
#define kHomeTipNotification                        @"kHomeTipNotification"//首页通知条通知
#define kCarModelBondSuccessedNotification          @"kCarModelBondSuccessedNotification"//车型页支付返回通知
#define kCarModelSendSuccessedNotification          @"kCarModelSendSuccessedNotification"//车型页支付成功通知

#define noDataFrame CGRectMake(0.0, LEFTMARGIN*2, DEVICE_WIDTH, LEFTMARGIN)

#define OLD_VERSION [[NSUserDefaults standardUserDefaults] objectForKey:@"oldversion"]

