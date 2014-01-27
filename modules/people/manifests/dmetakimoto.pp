class people::dmetakimoto {
  # 自分の環境で欲しいresourceをincludeする
  include iterm2::stable #::devもある
  include chrome
  include imagemagick
  include alfred
  include sequel_pro
  include mysql
  include mysql_workbench
  include pow
  include sourcetree
  include git-flow
  
  # homebrewでインストール
  package {
    [
      'readline',
      'tmux',
      'reattach-to-user-namespace',
      'tig',
      'wget',
    ]:
  }

  $home     = "/Users/${::luser}"
  $src      = "${home}/src"
  $dotfiles = "${src}/dotfiles"

  # ~/src/dotfilesにGitHub上のtaka84u9/dotfilesリポジトリを
  # git-cloneする。そのとき~/srcディレクトリがなければいけない。
  repository { $dotfiles:
    source  => "taka84u9/dotfiles",
    require => File[$src]
  }
  # git-cloneしたらインストールする
  exec { "sh ${dotfiles}/install.sh":
    cwd => $dotfiles,
    creates => "${home}/.zshrc",
    require => Repository[$dotfiles],
  }

  package { 
    'GoogleJapaneseInput':                                                           
    source => "http://dl.google.com/japanese-ime/latest/GoogleJapaneseInput.dmg",
    provider => pkgdmg;                                                          
  }

}
