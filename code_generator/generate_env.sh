#!/bin/bash

################################
## properties
PROG=$(basename $0)
VER="1.0"

TMPPATH=`dirname $0`/templates/env
OUTPATH=`pwd`
UVC_ARRAY=()
################################
## functions
version() {
  echo "$PROG version $VER"
  exit 1;
}

usage() {
  echo "Usage: $PROG [OPTIONS] env_name"
  echo "version:$VER"
  echo "Options:"
  echo "  -o <output_dir>"
  echo "  -m uvc_name,uvc_inst_name,num"
  echo "  -h, --help"
  echo "  -v, --version"
  exit 1;
}

debug_out(){
  echo "env_name is $env_name"
  echo "output to $OUTPATH"
  echo "Template path is $TMPPATH"
  echo "UVC_ARRAY is ${UVC_ARRAY[@]}"
}

################################
## get options
while getopts ":o:m:vh-:" OPT
do
  case $OPT in
    -)
      case "${OPTARG}" in
        version) version; continue;;
        help) usage; continue;;
      esac;;
    m) com_num=`echo $OPTARG | grep -o "," | wc -l`;
       if [ $com_num -ne 2 ];then
         echo "*E,Option error -m $OPTARG";
         usage;
       fi
       num=`echo $OPTARG | awk -F',' '{print $3}'`
       expr $num + 1 > /dev/null 2>&1
       RET=$?
       if [ $RET -ge 2 ];then  
         echo "*E,Option error -m $OPTARG : num=$num";
         usage;
       fi
       UVC_ARRAY+=($OPTARG) ; continue;;
    o) OUTPATH=$OPTARG; continue;;
    v) version; continue;;
    h) usage; continue;;
  esac
done

shift $(($OPTIND-1))

env_name=$1

################################
debug_out

################################

UVC_DEC=""
UVC_BLD=""
UVC_CON=""
UVC_IMP=""
VSEQ_UVC_DEC=""

for uvc in ${UVC_ARRAY[@]};do
  uvc_name=`echo $uvc | awk -F',' '{print $1}'`
  uvc_inst_name=`echo $uvc | awk -F',' '{print $2}'`
  uvc_num=`echo $uvc | awk -F',' '{print $3}'`
  echo "uvc_name=$uvc_name uvc_inst_name=$uvc_inst_name uvc_num=$uvc_num"
  ## for virtual sequencer
  if [ $uvc_num -eq 1 ];then
    VSEQ_UVC_DEC=$VSEQ_UVC_DEC`cat $TMPPATH/declare_uvc_handle.inc|sed "s/<uvc_name>/$uvc_name/g"|sed "s/<uvc_inst_name>/$uvc_inst_name/g"`
  else
    VSEQ_UVC_DEC=$VSEQ_UVC_DEC`cat $TMPPATH/declare_uvcs_handle.inc|sed "s/<uvc_name>/$uvc_name/g"|sed "s/<uvc_inst_name>/$uvc_inst_name/g"|sed "s/<uvc_num>/$uvc_num/g"`
  fi
  VSEQ_UVC_DEC=$VSEQ_UVC_DEC$'\n'

  ## for declare uvc
  if [ $uvc_num -eq 1 ];then
    UVC_DEC=$UVC_DEC`cat $TMPPATH/declare_uvc.inc|sed "s/<uvc_name>/$uvc_name/g"|sed "s/<uvc_inst_name>/$uvc_inst_name/g"`
  else
    UVC_DEC=$UVC_DEC`cat $TMPPATH/declare_uvcs.inc|sed "s/<uvc_name>/$uvc_name/g"|sed "s/<uvc_inst_name>/$uvc_inst_name/g"|sed "s/<uvc_num>/$uvc_num/g"`
  fi
  UVC_DEC=$UVC_DEC$'\n'

  ## for build uvc
  if [ $uvc_num -eq 1 ];then
    UVC_BLD=$UVC_BLD`cat $TMPPATH/build_uvc.inc|sed "s/<uvc_name>/$uvc_name/g"|sed "s/<uvc_inst_name>/$uvc_inst_name/g"`
  else
    UVC_BLD=$UVC_BLD`cat $TMPPATH/build_uvcs.inc|sed "s/<uvc_name>/$uvc_name/g"|sed "s/<uvc_inst_name>/$uvc_inst_name/g"|sed "s/<uvc_num>/$uvc_num/g"`
  fi
  UVC_BLD=$UVC_BLD$'\n'

  ## for connect uvc
  if [ $uvc_num -eq 1 ];then
    UVC_CON=$UVC_CON`cat $TMPPATH/connect_uvc.inc|sed "s/<uvc_name>/$uvc_name/g"|sed "s/<uvc_inst_name>/$uvc_inst_name/g"`
  else
    UVC_CON=$UVC_CON`cat $TMPPATH/connect_uvcs.inc|sed "s/<uvc_name>/$uvc_name/g"|sed "s/<uvc_inst_name>/$uvc_inst_name/g"|sed "s/<uvc_num>/$uvc_num/g"`
  fi
  UVC_CON=$UVC_CON$'\n'

  ## import uvc
  UVC_IMP=$UVC_IMP`echo "  import <uvc_name>_pkg::*;"|sed "s/<uvc_name>/$uvc_name/g"`$'\n'
done

ENV_NAME=`echo $env_name | tr a-z A-Z`
echo "env_name=$env_name ENV_NAME=$ENV_NAME"
for f in `find $TMPPATH -name "template*"`; do
  ENV_NAME=`echo $env_name | tr a-z A-Z`
  opath=$OUTPATH/$env_name
  [ ! -d $opath ]&&mkdir -p $opath
  ofn=`basename $f | sed "s/template/$env_name/g"`
  echo "output file is $OUTPATH/env/$ofn"
  cat $f | sed "s/<ENV_NAME>/$ENV_NAME/g"|sed "s/<env_name>/$env_name/g"\
  |perl -pe "s/<declare_uvcs>/$UVC_DEC/g"\
  |perl -pe "s/<build_uvcs>/$UVC_BLD/g"\
  |perl -pe "s/<connect_vseqr>/$UVC_CON/g"\
  |perl -pe "s/<declare_uvc_handle>/$VSEQ_UVC_DEC/g" \
  |perl -pe "s/<import_uvcs>/$UVC_IMP/g" \
  > $opath/$ofn
done
echo "--- virtual sequencer ---"
#echo "--- env class:declare ---"
#echo "$UVC_DEC"
#echo "--- env class:build ---"
#echo "$UVC_BLD"
#echo "--- env class:connect ---"
#echo "$UVC_CON"

