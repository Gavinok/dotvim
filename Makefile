######################################################################
# @author      : Gavin Jaeger-Freeborn (gavinfreeborn@gmail.com)
# @file        : Makefile
# @created     : Tue 19 Nov 2019 01:25:55 AM MST
######################################################################
all: sync

sync:
	[ -d $(PWD)/.git ] && git pull
	[ -f ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc
	mkdir -p ~/.config/efm-langserver
	ln -sf $(PWD)/extra/efm/config.yaml ~/.config/efm-langserver/config.yaml
	mkdir -p ~/.config/nvim
	[ -f ~/.config/nvim/init.vim ] || ln -s $(PWD)/vimrc ~/.config/nvim/init.vim

clean:
	rm -f ~/.vimrc 
	rm -f ~/.config/nvim/init.vim
