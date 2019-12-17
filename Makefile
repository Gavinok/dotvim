######################################################################
# @author      : Gavin Jaeger-Freeborn (gavinfreeborn@gmail.com)
# @file        : Makefile
# @created     : Tue 19 Nov 2019 01:25:55 AM MST
######################################################################
all: sync

sync:
	[ -d $(PWD)/.git ] && git pull
	[ -f ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc
	mkdir -p ~/.config/nvim
	[ -f ~/.config/nvim/init.vim ] || ln -s $(PWD)/init.vim ~/.config/nvim/init.vim

clean:
	rm -f ~/.vimrc 
	rm -f ~/.config/nvim/init.vim
