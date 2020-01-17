#!/bin/bash    
#CentOS从github拉取vim并编译安装
#--enable-perlinterp=yes perl支持
#yum -y install perl perl-devel perl-ExtUtils-ParseXS perl-ExtUtils-XSpp perl-ExtUtils-CBuilder perl-ExtUtils-Embed

set -ex 

echo "卸载系统vim"
yum -y remove vim 'vim-*'

echo "克隆vim到本地"
cd /root && git clone https://github.com/vim/vim.git

echo "安装依赖"
yum -y install make gcc ruby ruby-devel  ctags git python python-devel python3 python3-devel tcl-devel libXt-devel gtk2-devel ncurses-devel
#curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.2/install.sh | bash
#source /root/.bashrc
#nvm install node
curl -sL install-node.now.sh/lts | bash
echo "检查python config"
python -V 
echo "回车默认为2.7"
read -p '请输入python版本:' pyversion
pyconfig=/usr/lib64/python${pyversion:-2.7}/config
if [ -d $pyconfig ];then
                echo "python路径正常"
else
		echo "python路径不正确"
fi

echo "检查python3 config"
a=`python3 --version |awk '{print $2}' | awk -F '.' '{print $1}'`
b=`python3 --version |awk '{print $2}' | awk -F '.' '{print $2}'`
py3config=/usr/lib64/python$a.$b/config-3.6m-x86_64-linux-gnu
if [ -d $python3 ];then
	echo "python3路径正常"
else
	echo "python3路径不正确"
fi

echo "开始编译安装"
cd /root/vim && ./configure --enable-pythoninterp=yes   --enable-python3interp=yes --with-python3-config-dir=$py3config --with-python-config-dir=$pyconfig   --enable-rubyinterp=yes --enable-cscope --enable-gui=gtk2 --with-features=huge --enable-multibyte  --with-compiledby="Jiqinga" --prefix=/usr/local/vim 
cd /root/vim && make && make install 

echo "检查vim是否安装正常"
ln -s /usr/local/vim/bin/vim /usr/local/bin/
which vim
if [ $? -eq 0 ];then
	echo "vim已安装"
	source /etc/profile
else
	echo "vim未成功安装"
fi

#vim升级到8.0
#1.卸载
#
#sudo apt-get remove --purge vim
#2.添加8.0的vim源并安装
#
#sudo add-apt-repository ppa:jonathonf/vim
#sudo apt update
#sudo apt install vim
#3.卸载源
#
#sudo add-apt-repository --remove ppa:jonathonf/vim
#4.查看版本
#vim -v
