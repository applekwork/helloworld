### 终端上传项目到GitHub步骤
#### 一.配置GitHub的SSH key
>1.查看系统中是否配置过SSH keys，并处理
>1.1 终端里输入显示隐藏文件：```defaults write com.apple.finder AppleShowAllFiles -bool true ```输入命令完成之后需要重启Finder 桌面顶部苹果logo->强制退出->
就可显示隐藏文件。
>1.2 cd ~/.ssh 检查是否已经存在ssh,然后前往个人文件查看有没有 .ssh 文件夹，有的话个人建议删除掉，从新配置.![](media/15276656622146/15276659030399.png)
>2、在本地配置SSH key : mkdir .ssh 
cd .ssh
命令：ssh-Keygen -t rsa -C “youEmail”，输入完成之后一直按回车键 中间会提示你要输入文件、密码，不用管一直按回车直到出现下面这样。
拷贝SSH key，会在github上进行配置的时候使用
gonganxinxideiMac-2:.ssh gonganxinxi$ pbcopy < ~/.ssh/id_rsa.pub
>3、在github配置SSH key

>3.1 找到SSH key配置位置
![](media/15276656622146/15276660469761.png)

>3.2 填写SSH key配置信息
>4、回到终端，进行SSH确认连接
输入命令：ssh -T Git@github.com
执行完这条指令之后会输出 Are you sure you want to continue connecting (yes/no)? 输入 yes 回车,看见You’ve successfully authenticated, but GitHub does not provide shell access 。这就表示已成功连上github。
回到github，刷新网页就可以看到钥匙旁的灰色小圆点变绿，就表明已经添加成功了。
三、创建项目仓库

#### 二.创建github远程仓库
>1.GitHub 上建好仓库
![](media/15276656622146/15276663603276.jpg)
>2、创建git本地仓库
我们需要设置username和email，因为github每次commit都会记录他们。
```
git config --global user.name "github的户名" 
git config --global user.email"注册邮箱名"
```
>3.cd到你的本地项目、根目录下，再执行git命令
* 3.1 cd /Users/guolijun/Desktop/WebScoketTest 
* 3.2 git init
* 3.3 git add .
* 3.4 git commit -m ""
* 3.5 git remote add origin https://......
* 3.6 git push -u origin master（此处，可能我们会查看当前是否在master，使用命令：git check master）

#####另外附上：最后分享一些Github常用的命令：
* 切换分支：git checkout name
* 撤销修改：git checkout -- file
* 删除文件：git rm file
* 查看状态：git status
* 添加记录：git add file 或 git add .
* 添加描述：git commit -m "miao shu nei rong"
* 同步数据：git pull
* 提交数据：git push origin name
* 分支操作
* 查看分支：git branch
* 创建分支：git branch name
* 切换分支：git checkout name
* 创建+切换分支：git checkout -b name
* 合并某分支到当前分支：git merge name
* 删除分支：git branch -d name
* 删除远程分支：git push origin :name
####  END

