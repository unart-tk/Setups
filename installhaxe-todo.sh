#!/bin/sh
#
# ./installhaxe.sh test

#    (c) 2011 Ben, untar.org

# Build the haxe compiler
# =====================
# - download 'install.ml' and execute it (compiles the haxe compiler)
# - copy the executables and modifies the evironment variables

set -u

NEWHX='haxe2.07'
PREFIX="$HOME/usr/local/haxe"

HXSRC="$HOME/src/haxe/haxe$NEWHX"

MODE='test'

# Debugable commands (Depends on MODE)
x(){
    cmd="$1"
    if [ "$MODE" = 'test' ]; then
        echo "$cmd"
    elif [ "$MODE" = 'run' ]; then
        eval ${cmd}
    else
        echo "Error: Mode $MODE unknown."
        exit 1
    fi
}

echo "Installs Haxe $NEWHX in ~/usr/local/haxe"

# We won't be destructive, so we archive an already installed haxe
hxcheck=$(type haxe >/dev/null 2>&1 || echo not)
if [ -z "$hxcheck" ]; then
    hxold=$(type haxe &>/dev/null)
    hxpath=$(dirname `which haxe`)
    hxversion=$(haxe 2>&1 | \
     grep "haXe Compiler" | \
     perl -lne 'm/haXe\sCompiler\s(\d+\.\d*)/;print "$1"' \
    )
    
    # If haxe is installed in an separate folder
    hxinst=$(grep haxe "$hxpath")
    if [ -z "$hxinst" ]; then
        x "rm -f $hxpath/haxe/*"
    else
        x "mv \"$hxpath\" \"${hxpath}.${hxversion}.archive\""
    fi
    if [ -d "$PREFIX" ]; then 
        x "mv \"$PREFIX\" \"$PREFIX.${hxversion}.archive\""
    fi
fi

if [ ! -d "$HXSRC" ]; then
     x "mkdir -p \"$HXSRC\""
fi


#cd $hxsrc
#wget http://haxe.org/_media/install.ml
#ocaml install.ml



#/home/ben/src/haxe/inst.sh
#/home/ben/src/haxe/inst.sh
##!/bin/sh
## installhaxe.sh
##
#
#
#mkdir haxesrc
#cd haxesrc
#
## reset previous installations
#sudo rm -rf $PREFIX
#
#
## install haxe in /usr/local
#sudo mkdir $PREFIX
#sudo mkdir $PREFIX/bin
#sudo cp bin/* $PREFIX/bin
#sudo cp -r haxe/std $PREFIX
