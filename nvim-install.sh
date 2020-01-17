#!/bin/bash
https://github.com/theniceboy/nvim/blob/master/init.vim
yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install -y neovim python2-neovim
yum install -y make gcc ctags git python python-devel python3 python3-devel 
pip2 install --upgrade neovim
pip2 install --user --upgrade neovim
pip3.6 install --upgrade neovim
pip3.6 install --user --upgrade neovim
mkdir ~/.config/nvim
git clone init.vim
yum -y install go
echo "安装vundle插件管理器"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.nvim/bundle/Vundle.vim
echo "安装coc依赖"
curl -sL install-node.now.sh/lts | bash
curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
echo "安装插件"
nvim +PluginInstall +qall
#执行coc脚本
cd  ~/.nvim/bundle/coc.nvim/ && ./install.sh
echo "安装coc语言服务器"
nvim -c 'CocInstall -sync coc-json coc-docker coc-sh coc-marketplace |q'
echo "安装python语言服务器"
pip install -U setuptools
pip install 'python-language-server[all]'
cat <<'EOF' > ~/.config/nvim/coc-settings.json
{
"languageserver": {
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
echo "alias vim='nvim'" >> ~/.bashrc
source ~/.bashrc
