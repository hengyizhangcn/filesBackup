安装gollum

1.安装命令

`gem install gollum`

1）如果有错误，按照提示，会有brew install icu4c or 的提示，所以之后再运行命令

brew install icu4c，然后再运行gollum安装命令

2）如果还有错误，若提示

```
Building native extensions.  This could take a while...
ERROR:  Error installing gollum:
	ERROR: Failed to build gem native extension.

    current directory: /Library/Ruby/Gems/2.3.0/gems/charlock_holmes-0.7.5/ext/charlock_holmes
/System/Library/Frameworks/Ruby.framework/Versions/2.3/usr/bin/ruby -r ./siteconf20180111-37826-uqvu55.rb extconf.rb
checking for main() in -licui18n... no
checking for main() in -licui18n... yes
checking for unicode/ucnv.h... yes
checking for main() in -lz... yes
checking for main() in -licuuc... yes
checking for main() in -licudata... yes
creating Makefile

current directory: /Library/Ruby/Gems/2.3.0/gems/charlock_holmes-0.7.5/ext/charlock_holmes
make "DESTDIR=" clean
......
```

则需要安装charlock_holmes，命令如下

```
sudo gem install charlock_holmes -- --with-icu-dir=/usr/local/opt/icu4c --with-cxxflags=\'-Wno-reserved-user-defined-literal -std=c++11\'
Building native extensions with: '--with-icu-dir=/usr/local/opt/icu4c --with-cxxflags='-Wno-reserved-user-defined-literal -std=c++11''
```

然后再安装gollum即可

参考:

https://github.com/gollum/gollum/issues/1257

https://github.com/brianmario/charlock_holmes/issues/122

2.克隆wiki工程到本地

```
git clone git@git.uama.com.cn:yongzhi.lin/scusefulcodelibrary.wiki.git
cd scusefulcodelibrary.wiki
```

3.输入gollum命令，可见控制台输出如下：

```
gollum
[2018-01-11 19:44:29] INFO  WEBrick 1.3.1
[2018-01-11 19:44:29] INFO  ruby 2.3.3 (2016-11-21) [universal.x86_64-darwin17]
== Sinatra (v1.4.8) has taken the stage on 4567 for development with backup from WEBrick
[2018-01-11 19:44:29] INFO  WEBrick::HTTPServer#start: pid=38633 port=4567
```

4.在浏览器中输入http://localhost:4567/Home即可