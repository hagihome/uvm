#!/bin/bash

################################
## properties
PROG=$(basename $0)
VER="1.0"

TMPPATH=`dirname $0`/templates/agent
OUTPATH=`pwd`

################################
## functions
version() {
  echo "$PROG version $VER"
  exit 1;
}

usage() {
  echo "Usage: $PROG [OPTIONS] uvc_name"
  echo "version:$VER"
  echo "Options:"
  echo "  -o <output_dir>"
  echo "  -h, --help"
  echo "  -v, --version"
  exit 1;
}

debug_out(){
  echo "uvc_name is $uvc_name"
  echo "output to $OUTPATH"
  echo "Template path is $TMPPATH"
}

################################
## get options
while getopts ":o:vh-:" OPT
do
  case $OPT in
    -)
      case "${OPTARG}" in
        version) version; continue;;
        help) usage; continue;;
      esac;;
    o) OUTPATH=$OPTARG; continue;;
    v) version; continue;;
    h) usage; continue;;
  esac
done

shift $(($OPTIND-1))

echo "options : $#"
#uvc_name=$1
uvc_name=$@

################################
debug_out

################################
for n in $uvc_name ; do
  N=`echo $n | tr a-z A-Z`
  
  opath=$OUTPATH/$n
  [ ! -d $opath ] && mkdir $opath

  for tmplt in `find $TMPPATH -type f`; do
    ofn=`basename $tmplt | sed "s/template_/${n}_/g"`
    cat $tmplt | sed "s/<UVC_NAME>/$N/g" | sed "s/<uvc_name>/$n/g" > $opath/$ofn
  done
done

