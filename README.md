# nav_planner
规划与控制

使用方法
下载
git clone https://github.com/lxf0806/nav_planner.git/
添加注释
git commit -m “add new file test”
git push
用户名  lxf0806
密码 每次用每次更新

例子
touch README.md  //这个貌似必须有，我第一次因为这个上传出错

git init   // 初始化

git add.  // .代表添加文件夹下所有文件 

git commit -m "first commit"   // 把添加的文件提交到版本库，并填写提交备注

git remote add origin git@10.180.30.18:test/your_file_name.git //建立远程链接，git@10.180.30.18:test/your_file_name.git 为你的远程仓库地址，其中有两个链接，一个http，一个ssh，我自己用http链接上传失败，改用ssh就可以了。

git push -u origin master // 将代码上传


2、后续提交更新

git add.  // .代表添加文件夹下所有文件

git commit -m "change ** file"   // 把添加的文件提交到版本库，并填写提交备注

git push -u origin master // 将代码上传
