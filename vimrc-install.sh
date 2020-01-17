#!/bin/bash
set -ex
echo "安装go"
yum -y install epel-release.noarch
yum -y install go
echo "安装vundle插件管理器"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo "判断是否存在vimrc文件,若存在,则移动至~/vimrc-bak"
test -f ~/.vimrc && mv ~/.vimrc ~/vimrc-bak
echo "下载我的vimrc配置"
cd ~ && wget https://raw.githubusercontent.com/jiqinga/vimrc/master/.vimrc
#coc依赖
echo "安装coc依赖"
curl -sL install-node.now.sh/lts | bash
curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
echo "安装插件"
vim +PluginInstall +qall
#执行coc脚本
~/.vim/bundle/coc.nvim/install.sh
echo "安装coc语言服务器"
vim -c 'CocInstall -sync coc-json coc-docker coc-sh coc-marketplace coc-go|q'
#python补全服务器
echo "安装python语言服务器"
pip install -U setuptools
pip install 'python-language-server[all]'
echo "生成coc-settings.json配置"
cat <<'EOF' > ~/.vim/coc-settings.json
{
  "python": {
    "command": "python",
    "args": [
      "-mpyls",
      "-vv",
      "--log-file",
      "/tmp/lsp_python.log"
    ],
    "trace.server": "verbose",
    "filetypes": [
      "python"
    ],
    "settings": {
      "pyls": {
        "enable": true,
        "trace": {
          "server": "verbose"
        },
        "commandPath": "",
        "configurationSources": [
          "pycodestyle"
        ],
        "plugins": {
          "jedi_completion": {
            "enabled": true
          },
          "jedi_hover": {
            "enabled": true
          },
          "jedi_references": {
            "enabled": true
          },
          "jedi_signature_help": {
            "enabled": true
          },
          "jedi_symbols": {
            "enabled": true,
            "all_scopes": true
          },
          "mccabe": {
            "enabled": true,
            "threshold": 15
          },
          "preload": {
            "enabled": true
          },
          "pycodestyle": {
            "enabled": true
          },
          "pydocstyle": {
            "enabled": false,
            "match": "(?!test_).*\\.py",
            "matchDir": "[^\\.].*"
          },
          "pyflakes": {
            "enabled": true
          },
          "rope_completion": {
            "enabled": true
          },
          "yapf": {
            "enabled": true
          }
        }
      }
    }
  }
}
}
EOF
##python	补全
#			 yum install -y unzip tree
#			 unzip master.zip
#			 mv pydiction-master/ pydiction
#			 mkdir -p /root/.vim/tools/pydiction
#			 cp -r pydiction/after /root/.vim
#			 cp pydiction/complete-dict  /root/.vim/tools/pydiction/
#
#go补全服务器
#GO111MODULE=on go get golang.org/x/tools/gopls@latest
#vim中执行,需科学上网
# :GoInstallBinaries



#vim中文帮助
echo "配置vim中文文档"
cd ~ && wget https://sourceforge.net/projects/vimcdoc/files/vimcdoc/1.8.0/vimcdoc-1.8.0.tar.gz && tar zxf vimcdoc-1.8.0.tar.gz && mv  vimcdoc-1.8.0 .vim/doc  && cd ~/.vim/doc/ && ./vimcdoc.sh -i

