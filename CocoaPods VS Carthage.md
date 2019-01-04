1.语法上的不同

CocoaPods使用Podfile文件，生成Podfile.lock文件来锁定依赖库的版本；

Carthage使用Cartfile文件，生成Cartfile.resolved文件来锁定依赖库的版本。

引入依赖库的语法:

Podfile语法:

```
pod 'YTKNetwork', '~> 2.0.3'
pod 'UITableView+FDTemplateLayoutCell', :git => 'http://121.40.102.80:8888/libs/FDTemplate.git', :tag => '1.5.1' //引入私有库并指定1.5.1版本
pod 'JPush', '~> 3.0.6'
pod 'UMengAnalytics', '~> 4.2.4'
pod 'libextobjc', '~>0.4.1', :subspecs => ['EXTScope']
```

对应的Cartfile语法:

```
github "yuantiku/YTKNetwork" ~> 2.0.3 //这里必须是双引号，而且库名前面需要指定库的作者用户名
git "http://121.40.102.80:8888/libs/FDTemplate.git" == 1.5.1 //引入私有库并指定1.5.1版本，注:私有库采用gitlab搭建
binary "OtherFrameworks.json" 
github "jspahrsummers/libextobjc" ~> 0.4.1 //Carthage不支持指定subspecs，需要编译整个库
```

注：由于JPush和UMengAnalytics使用了zip文件，需要把对JPush和UMengAnalytics的依赖写入json文件中，内容如下（此处命名了OtherFrameworks.json，使用的相对路径）：

>{
>
>​    "3.0.6": "https://sdkfiledl.jiguang.cn/cocoapods/jpush/JPush-iOS-3.1.1.zip",
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

```
*** Fetching xxx
No tagged versions found for github "xx/xxx"
```



## 二 接入实践

注：部分使用Carthage，如YTKNetwork，JPush及私有库FDTemplate

1.隐去Podfile里面的YTKNetwork，JPush及FDTemplate三个库的引用

2.新建Cartfile文件，引入此三个库

```
github "yuantiku/YTKNetwork" ~> 2.0.3

git "http://git.uama.com.cn:8888/libs/FDTemplate.git" == 1.5.1

binary "OtherFrameworks.json"
```

其中OtherFrameworks.json内容如下:

3.运行Carthage update —platform iOS

4.Targets->Build Settings->Framework Search Paths添加`$(PROJECT_DIR)/Carthage/Build/iOS`

5.Targets->General->Embedded Binaries添加Carthage/Build/iOS文件中的动态库

Linked Frameworks and Libraries中也会自动添加

6.工程中引用私有库文件的语法有些变化

如需要从`import "YTKBatchRequest.h"`变成`import <YTKNetwork/YTKBatchRequest.h>`





碰到问题：

1.`dyld: Library not loaded:`

在Embedded Binaries中添加