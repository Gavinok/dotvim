######################################################################
# @author      : Gavin Jaeger-Freeborn (gavinfreeborn@gmail.com)
# @file        : Makefile
# @created     : Tue 19 Nov 2019 01:25:55 AM MST
######################################################################
all: sync

sync:
	if [ -d $(PWD)/.git ]; then
		git pull
	else
		git clone https://github.com/Gavinok/dotvim.git
	fi
	[ -f ~/.vimrc ] || ln -s $(PWD)/vimrc ~/.vimrc

clean:
	rm -f ~/.vimrc 
