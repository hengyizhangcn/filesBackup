# CocoaPods和Carthage的比较

## 一 语法上的不同

CocoaPods使用Podfile文件，生成Podfile.lock文件来锁定依赖库的版本；

Carthage使用Cartfile文件，生成Cartfile.resolved文件来锁定依赖库的版本。

引入依赖库的语法:

Podfile语法:

```podfile
pod 'YTKNetwork', '~> 2.0.3'
pod 'UITableView+FDTemplateLayoutCell', :git => 'http://121.40.102.80:8888/libs/FDTemplate.git', :tag => '1.5.1' //引入私有库并指定1.5.1版本
pod 'JPush', '~> 3.0.6'
pod 'UMengAnalytics', '~> 4.2.4'
pod 'libextobjc', '~>0.4.1', :subspecs => ['EXTScope']
```

对应的Cartfile语法:

```cartfile
github "yuantiku/YTKNetwork" ~> 2.0.3 //这里必须是双引号，而且库名前面需要指定库的作者用户名
git "http://121.40.102.80:8888/libs/FDTemplate.git" == 1.5.1 //引入私有库并指定1.5.1版本，注:私有库采用gitlab搭建
binary "JPush.json" 
github "jspahrsummers/libextobjc" ~> 0.4.1 //Carthage不支持指定subspecs(如EXTScope)，需要编译整个库
```

注：由于JPush和UMengAnalytics使用了zip文件，需要把对JPush和UMengAnalytics的依赖写入json文件中，内容如下（此处命名了JPush.json，使用的相对路径）：

>{
>
>​    "3.0.6":"https://sdkfiledl.jiguang.cn/cocoapods/jpush/JPush-iOS-3.1.1.zip",
>
>​   // "4.2.4": "http://dev.umeng.com/system/resources/W1siZiIsIjIwMTcvMDEvMjIvMTFfMDJfMDZfMjk3X3Vtc2RrX0lPU19hbmFseWljc19pZGZhX3Y0LjIuNC56aXAiXV0/umsdk_IOS_analyics_idfa_v4.2.4.zip"
>
>}
>
>//这里的路径是使用pod search命令搜索的，找到其中的source即可
>
>//这里json中只支持https,

注意事项

1.如果库没有tag，不能使用Carthage去管理，会报错，如

```print
*** Fetching xxx
No tagged versions found for github "xx/xxx"
```

## 二 接入实践

注：部分使用Carthage，如KVOController，MXParallaxHeader，MBProgressHUD等

1.隐去Podfile里面的KVOController，MXParallaxHeader，MBProgressHUD等库的引用，并重新运行`pod install`

2.新建Cartfile文件，引入相关库

```Cartfile
#github "zwaldowski/BlocksKit" == 2.2.3 #无iOS scheme
github "facebook/KVOController" ~> 1.2.0
github "maxep/MXParallaxHeader" ~> 0.6.0
github "hackiftekhar/IQKeyboardManager" ~> 5.0.0
github "matej/MBProgressHUD" ~> 1.0.0
github "mineschan/MZTimerLabel" ~> 0.5.4
#github "mindsnacks/MSWeakTimer" ~> 1.1.0 #无iOS scheme
git "http://git.uama.com.cn:8888/libs/FDTemplate.git" == 1.5.1
git "http://git.uama.com.cn:8888/base/SCNetWorkModule.git" == 2.0.4
```

3.运行Carthage update —platform iOS

4.Targets->Build Settings->Framework Search Paths添加`$(PROJECT_DIR)/Carthage/Build/iOS`

5.Targets->General->Linked Frameworks and Libraries添加Carthage/Build/iOS文件中的动态库

然后在Embedded Binaries中添加选择动态库，Linked Frameworks and Libraries中也会自动添加，删除重复的即可

6.工程中引用私有库文件的语法有些变化

如需要从`import "YTKBatchRequest.h"`变成`import <YTKNetwork/YTKBatchRequest.h>`

## 三 项目中依赖库对Carthage的支持程度

| 依赖                                       | CocoaPods | Carthage | remark |
| ---------------------------------------- | :-------: | :------: | :----: |
| FDTemplate、YTKNetwork、AFNetworking、SDWebImage、IQKeyboardManager、MBProgressHUD、MJExtension、HMSegmentedControl、MJRefresh、KVOController、TZImagePickerController、SZTextView、SVProgressHUD、BlocksKit、  MXParallaxHeader、 MZTimerLabel 、 MSWeakTimer |     √     |    √     |   17   |
| MWPhotoBrowser、OpenUDID、UIDeviceIdentifier、UIAlertView-Blocks、NullSafe、AKNumericFormatter、DZNEmptyDataSet、libqrencode、libextobjc、TYMProgressBarView、MJPopupViewController、 ZFPlayer、 JZLocationConverter、WebViewJavascriptBridge、 CircleProgressBar、 DACircularProgress、 VTMagic、 DYRateView、 CSStickyHeaderFlowLayout、 UITextView+Placeholder、 JKCountDownButton、 MGJRouter |     √     |    ×     |   21   |
| JPush、UMengAnalytics、  AMapSearch-NO-IDFA、AMap3DMap-NO-IDFA、AMapLocation-NO-IDFA |     √     |    ×     |   5   |
| SCBaseFramework、SCCommonModule、SCNetWorkModule、SCSocketModule、SCStatisticLib、EagleMonitoring、SCAliyunOSSLib、SCAlipay、SCImageEditSDK、UIBubbleTableView、SmartDoorUnlock、SCUnionPay、 SCVoiceKeeperModule、SCShareLib、 SCUniversalQRCodeModule |     √     |    ×     |   15   |

## 四  增加Carthage支持

以SCNetWorkModule为例

1.新建一个Cocoa Touch Framework工程

2.该工程功能需要依赖YTKNetwork\MJExtension，添加Cartfile，输入内容

> github "yuantiku/YTKNetwork", ~> 2.0.4
> github "CoderMJLee/MJExtension", ~> 3.0.10

3.运行Carthage update —platform iOS

4.Targets->Build Settings->Framework Search Paths添加`$(PROJECT_DIR)/Carthage/Build/iOS`

5.Targets->General->Linked Frameworks and Libraries添加Carthage/Build/iOS文件中的动态库

6.头文件引用`import "MJExtension.h"`改为`import <MJExtension/MJExtension.h>`

## 碰到问题：

1.`dyld: Library not loaded:`

在Embedded Binaries中添加

2.Parse error: found more than 3 dot-separated components in version in line: github "CoderMJLee/MJRefresh" ~> 3.1.15.7

不支持四分的版本号

3.Dependency "MGJRouter" has no shared framework schemes

打开Edit Scheme，关闭Shared选项并重新打开即可