#!/bin/bash

################################
## properties
PROG=$(basename $0)
VER="1.0"

TMPPATH=`dirname $0`/templates/sequence
OUTPATH=`pwd`/sequence
BASESEQ=uvm
ENVNAME=env
WITH_TEST=0
VSEQR_NAME=
################################
## functions
version() {
  echo "$PROG version $VER"
  exit 1;
}

usage() {
  echo "Usage: $PROG [OPTIONS] seq_name"
  echo "version:$VER"
  echo "Options:"
  echo "  -o <output_dir>"
  echo "  -b <base sequence name>"
  echo "  -t env_name"
  echo "  -r vseqr_name"
  echo "  -h, --help"
  echo "  -v, --version"
  exit 1;
}

debug_out(){
  echo "seq_name is $seqs"
  echo "BASESEQ is $BASESEQ"
  echo "ENVNAME is $ENVNAME"
  echo "WITH_TEST = $WITH_TEST"
  echo "VSEQR_NAME= $VSEQR_NAME"
  echo "output to $OUTPATH"
  echo "Template path is $TMPPATH"
}

################################
## get options
while getopts ":o:b:t:r:vh-:" OPT
do
  case $OPT in
    -)
      case "${OPTARG}" in
        version) version; continue;;
        help) usage; continue;;
      esac;;
    b) BASESEQ=$OPTARG; continue;;
    t) ENVNAME=$OPTARG; WITH_TEST=1; continue;;
    r) VSEQR_NAME=$OPTARG; continue;;
    o) OUTPATH=$OPTARG; continue;;
    v) version; continue;;
    h) usage; continue;;
  esac
done

shift $(($OPTIND-1))
seqs=$@

################################
debug_out

################################

[ ! -d $OUTPATH ] && mkdir -p $OUTPATH

DEC_SEQR=""
if [ -n "$VSEQR_NAME" ]; then
  DEC_SEQR=`cat $TMPPATH/declare_sequencer.inc | perl -pe "s/<seqr_name>/$VSEQR_NAME/g"`
fi

for seq in $seqs;do
  for tmpl in `find $TMPPATH -name "*.svh"`; do
    SEQ=`echo $seq | tr a-z A-Z`
    TCLS=""
    BCLS=""
    OFL=$OUTPATH/`basename $tmpl | sed "s/template/$seq/g"`
    if [ $WITH_TEST -eq 1 ]; then
      TCLS=`cat $TMPPATH/test_definition.inc | perl -pe "s/<seq_name>/$seq/g" | perl -pe "s/<env_name>/$ENVNAME/g"`
      BCLS=$ENVNAME"_virtual"
    else
      TCLS=""
      BCLS=$BASESEQ
    fi
    echo "--- $OFL ---"
    cat $TMPPATH/template_sequence.svh \
    | perl -pe "s/<SEQ_NAME>/$SEQ/g" \
    | perl -pe "s/<seq_name>/$seq/g" \
    | perl -pe "s/<base_name>/$BCLS/g" \
    | perl -pe "s/<test_definition>/$TCLS/g" \
    | perl -pe "s/<declare_sequencer>/$DEC_SEQR/g" \
    > $OFL
  done
done


