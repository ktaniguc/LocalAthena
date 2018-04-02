#!/bin/sh
source $TestArea/../build/$CMTCONFIG/setup.sh
MAX_EVENT=-1
AMITAG="r8957"
BASE_DIR="/gpfs/fs2001/ynoguchi/data/RDO/mc16/mc16_13TeV.300201.Pythia8BPhotospp_A14_CTEQ6L1_bb_Jpsimu4mu4.recon.RDO.e4397_s2997_r9191/"
#BASE_DIR="/gpfs/fs2001/ynoguchi/data/RDO/mc16.valid1/user.ynoguchi.valid1.424100.Pythia8B_A14_CTEQ6L1_Jpsimu4mu4.recon.RDO.e5112_s3091_r9573._201706160304_EXT0/"
#BASE_DIR="/gpfs/home/yyazawa/public/mc16_13TeV.361107.PowhegPythia8EvtGen_AZNLOCTEQ6L1_Zmumu.simul.HITS.e3601_s2997/"
FILES=(
"HITS.09794988._001077.pool.root.1"
"HITS.09794988._001144.pool.root.1"
"HITS.09794988._001214.pool.root.1"
"HITS.09794988._001595.pool.root.1"
"HITS.09794988._001949.pool.root.1"
"HITS.09794988._002318.pool.root.1"
"HITS.09794988._002320.pool.root.1"
"HITS.09794988._002582.pool.root.1"
"HITS.09794988._002628.pool.root.1"
"HITS.09794988._003038.pool.root.1"
)
for FILE in `find $BASE_DIR -name "*root*"`
do
  echo $FILE
  DIR=`echo $FILE | sed -e "s:$BASE_DIR:DIR_:g"`
  mkdir $DIR && cd $DIR
  echo "Reco_tf.py '--inputRDOFile=${FILE}' '--maxEvents=${MAX_EVENT}'  '--outputAODFile=AOD.pool.root'" > tmp.sh && bsub -q 12h -o log.out < tmp.sh && rm tmp.sh
  cd -
done
exit 0

for FILE in ${FILES[@]}
do
  echo "$FILE"
  mkdir $FILE && cd $FILE
  echo "Reco_tf.py '--inputHITSFile=${BASE_DIR}${FILE}' '--AMITag=r8957'  '--maxEvents=${MAX_EVENT}'  '--outputAODFile=AOD.pool.root'" > tmp.sh && bsub -q 12h -o log.out < tmp.sh
  cd ..
  #'--preExec' 'RAWtoESD:from TriggerJobOpts.TriggerFlags import TriggerFlags;TriggerFlags.enableMonitoring=[ "Validation", "Log" ,"Time"]' &> log &"
done

