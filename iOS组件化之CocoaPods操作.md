

## 简介

CocoaPods是类库管理工具。

## 下载和安装

1.首先安装Ruby环境

- 下载安装Xcode

  它集成了Unix环境需要的开发包

- 安装RVM，命令如下：

  ```
  $ curl -L https://get.rvm.io | bash -s stable  #下载安装
  $ source ~/.rvm/scripts/rvm #载入RVM环境
  $ rvm -v #运行下命令，查看版本号，以检查是否安装正确
  ```

- 用RVM安装Ruby环境：

  ```
  $ rvm list known #列出已知的ruby版本
  $ rvm install 2.2 #以2.2版本为例进行安装
  ```

  等待一段时间，安装完成已经，可查询已经安装的ruby，命令如下：

  ```
  $ rvm list
  ```

2.修改镜像源

由于gem resources官方镜像源地址`https://rubygems.org/`被墙，需要修改，依次输入以下命令即可：

```
$ gem sources --remove https://rubygems.org/ #移除原有的镜像源
$ gem sources -a http://ruby.taobao.org/ #添加淘宝的镜像源
```

可验证Ruby镜像源是否替换成功，命令如下：

```
$ gem sources -l
```

正常输出如下：

```
*** CURRENT SOURCES ***

https://ruby.taobao.org
```

3.安装cocoapods

命令如下：

```
$ sudo gem install cocoapods
```

4.更新cocopods

通常情况下，输入`$sudo gem install cocoapods`即可。若想安装beta版本或者未正式发布的版本，可输入以下命令：

```
$ sudo gem install cocoapods --pre
```

如果再安装不了，可尝试：

```
$ sudo gem install -n /usr/local/bin cocoapods --pre
```

# 使用Cocoapods

创建Podfile文件，添加依赖

```
target 'MyApp' do
  pod 'AFNetworking', '~> 3.0'
  pod 'FBSDKCoreKit', '~> 4.9'
end
```



# 经常碰到的问题

1.连接超时

```[!] Error installing JPush
[!] /usr/bin/git clone https://github.com/jpush/jpush-ios-sdk-pod.git /var/folders/8w/j6x5f1290zq_g0q8b0dp7fzm0000gn/T/d20170227-15744-1kyd22x --template= --single-branch --depth 1 --branch 2.2.0.1
Cloning into '/var/folders/8w/j6x5f1290zq_g0q8b0dp7fzm0000gn/T/d20170227-15744-1kyd22x'...
error: RPC failed; curl 56 SSLRead() return error -36
fatal: The remote end hung up unexpectedly
fatal: early EOF
fatal: unpack-objects failed
```

2.



## 参考

https://github.com/CocoaPods/CocoaPods/wiki