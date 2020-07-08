#!/bin/sh
DATE=$(date '+%Y%m%d%H%M')
dateMMDD=$(date '+%m%d')
bqueues=1d
CMTCONFIG=x86_64-centos7-gcc62-opt
#CMTCONFIG=x86_64-slc6-gcc62-opt

#INPUT_RDO="/gpfs/fs2001/yfukuhar/data/user.yfukuhar.mc16_13TeV.361107.PowhegPythia8EvtGen_AZNLOCTEQ6L1_Zmumu.recon.RDO.e3601_s3126_r9781.201806291853_EXT0/user.yfukuhar.14514992.EXT0._000004.RDO.pool.root"
#INPUT_LIST="/home/ktaniguc/atlas/list_set/RPCclustering_Jpsi_mu3p5mu3p5_AllFiles.list"
#INPUT_LIST="/home/ktaniguc/atlas/list_set/RPCclustering_JpsiCollimated_1-150.list"
#INPUT_LIST="/home/ktaniguc/atlas/list_set/RPCclustering_JpsiCollimated_151-300.list"
#INPUT_LIST="/home/ktaniguc/atlas/list_set/RPCclustering_JpsiCollimated_1-300.list"
#INPUT_LIST="/home/ktaniguc/atlas/list_set/RPCclustering_JpsiCollimated_301-930.list"
#INPUT_LIST="rpcClusterig_JpsiCollimated_100files.list"
#INPUT_LIST="/home/ktaniguc/atlas/list_set/RPCclustering_Zmumu_geo01-00-01.full.list"
#INPUT_LIST="/home/ktaniguc/atlas/list_set/RPCclustering_Zmumu_geo01-00-01.60888to63300.list"
#INPUT_LIST="/home/ktaniguc/atlas/list_set/RPCclustering_Zmumu_geo01-00-01.63303to77431.list"
#INPUT_LIST="/home/ktaniguc/atlas/list_set/RPCclustering_Zmumu_geo01-00-01.77433to80771.list"
#INPUT_LIST="/home/ktaniguc/atlas/list_set/RPCclustering_Zmumu_geo01-00-01.300files.list"
#INPUT_LIST="/home/ktaniguc/atlas/list_set/RPCclustering_Jpsi_mu3p5mu3p5_Br002.list"
#INPUT_LIST="/home/ktaniguc/atlas/list_set/RPCclustering_Zmumu_full.list"
INPUT_LIST="Zmumu.list" #geo : 00-01-00_VALIDATION , condTag : SDR-09-01
#INPUT_LIST="/home/ktaniguc/LocalAthena_21.0.53/run/rpcClustering.list"
#INPUT_RDO_FOR_OUTPUT="user.yfukuhar.mc16_13TeV.Zmumu"
#OUTPUT_AOD=$INPUT_RDO_FOR_OUTPUT".AOD."$DATE".root"


#BASE_DIR="/home/ktaniguc/datasets/mc16_13TeV/"
#BASE_DIR="/home/ktaniguc/datasets/mc16_13TeV.300000.Pythia8BPhotospp_A14_CTEQ6L1_pp_Jpsimu2p5mu2p5.simul.HITS.e4397_s3126/"
#BASE_DIR="/gpfs/fs7001/kayamash/dataset/ForAthena/mc16_13TeV.300901.ParticleGunEvtGen_Jpsi_mu3p5mu3p5_prompt.simul.HITS.e7406_e5984_a875/"
INPUT_HITS_FOR_OUTPUT="user.ktaniguc.mc16_13TeV"
OUTPUT_AOD=$INPUT_HITS_FOR_OUTPUT".AOD."$DATE".root"
OUTPUT_RDO=$INPUT_HITS_FOR_OUTPUT".RDOTRIG."$DATE".root"
OUTPUT_ESD=$INPUT_HITS_FOR_OUTPUT".ESD."$DATE".root"

PRE_EXEC='"all:from TriggerJobOpts.TriggerFlags import TriggerFlags;TriggerFlags.AODEDMSet.set_Value_and_Lock(\"AODFULL\");"'
AMICONFIG=r11189

MINBIAS_LOW="/gpfs/fs7001/ktaniguc/HITS/user.yfukuhar.mc16_13TeV.361238.Pythia8EvtGen_A3NNPDF23LO_minbias_inelastic_low.simul.HITS.e4981_s3087_s3111_der1530095342/HITS*"
MINBIAS_HIGH="/gpfs/fs7001/ktaniguc/HITS/user.yfukuhar.mc16_13TeV.361239.Pythia8EvtGen_A3NNPDF23LO_minbias_inelastic_high.simul.HITS.e4981_s3087_s3111_der1566302143/HITS.10701335._000695.pool.root.1"

#CMT_CONFIG="x86_64-slc6-gcc62-opt"
#AMI_TAG="r9781"
#NFILES_PER_JOB='5'
#NEVENTS_PER_FILE='500'
#NEVENTS_PER_JOB='100'
#DESTSE='TOKYO-LCG2_SCRATCHDISK'
MAXEVENTS='1000'
#SKIPEVENTS='0'
number=1


echo ""
echo "INPUT_LIST =   "$INPUT_LIST
echo "OUTPUT_AOD =   "$OUTPUT_AOD
echo ""

if [ -f "$INPUT_LIST" ] ; then
  for INPUT_FILE in `cat $INPUT_LIST`
  do
    echo ""
    echo "INPUT_FILE =   "$INPUT_FILE
    echo ""
    TEMP_DIR=`echo "$INPUT_FILE" | sed -e "s:/:_:g"`
    DIR="/gpfs/fs7001/ktaniguc/ZmumuAOD/OutputLocalAth$dateMMDD/$DATE/$TEMP_DIR/processing"
    OUTPUT_AOD=$INPUT_HITS_FOR_OUTPUT".AOD."$DATE"."$number".root"
    mkdir -p $DIR
    echo "Submit Directory: "$DIR
    cp ./*.sh $DIR
    cp ./*.py $DIR
    cd $DIR
    COMMAND_FORCLEAR="mv user.ktaniguc* ../ && cd ../ && rm -r ./processing"
    echo $COMMAND_FORCLEAR > clear.${number}.sh
    #COMMAND="bsub -q $bqueues -o log.out 'source $TestArea/../build/$CMTCONFIG/setup.sh && Reco_tf.py --autoConfiguration everything --outputAODFile ${OUTPUT_AOD} --skipEvents ${SKIPEVENTS} --maxEvents ${MAXEVENTS} --inputHITSFile ${INPUT_FILE}' --preExec 'all:from TriggerJobOpts.TriggerFlags import TriggerFlags;TriggerFlags.AODEDMSet.set_Value_and_Lock\(\"AODFULL\"\);' --geometryVersion ATLAS-R2-2016-01-00-01 --conditionsTag OFLCOND-MC16-SDR-14 --digiSeedOffset1 1 --digiSeedOffset2 1 --postInclude ./outputLevelConfig.py RecJobTransforms/UseFrontier.py"
    #COMMAND="bsub -q $bqueues -o log.out 'source $TestArea/../build/$CMTCONFIG/setup.sh && Reco_tf.py --AMIConfig r11189 --autoConfiguration everything --outputAODFile ${OUTPUT_AOD} --inputLowPtMinbiasHitsFile $MINBIAS_LOW --inputHighPtMinbiasHitsFile $MINBIAS_HIGH --maxEvents ${MAXEVENTS} --jobNumber ${number} --inputHITSFile ${INPUT_FILE} --preExec ${PRE_EXEC} --digiSeedOffset1 1 --digiSeedOffset2 1 --postInclude ./outputLevelConfig.py RecJobTransforms/UseFrontier.py && sh clear.${number}.sh'"
    COMMAND="bsub -q $bqueues -o log.out 'Reco_tf.py --autoConfiguration everything --outputAODFile ${OUTPUT_AOD} --maxEvents ${MAXEVENTS} --jobNumber ${number} --inputHITSFile ${INPUT_FILE} --preExec ${PRE_EXEC} --geometryVersion ATLAS-R2-2016-00-01-00 --conditionsTag OFLCOND-MC16-SDR-09-01 --digiSeedOffset1 1 --digiSeedOffset2 1 --postInclude RecJobTransforms/UseFrontier.py && sh clear.${number}.sh'"
    #COMMAND="bsub -q $bqueues -o log.out 'source $TestArea/../build/$CMTCONFIG/setup.sh && Reco_tf.py --autoConfiguration everything --outputAODFile ${OUTPUT_AOD} --maxEvents ${MAXEVENTS} --jobNumber ${number} --inputHITSFile ${INPUT_FILE} --preExec ${PRE_EXEC} --geometryVersion ATLAS-R2-2016-01-00-01 --conditionsTag OFLCOND-MC16-SDR-14 --digiSeedOffset1 1 --digiSeedOffset2 1 --postInclude RecJobTransforms/UseFrontier.py && sh clear.${number}.sh'"
    #COMMAND="bsub -q $bqueues -o log.out 'source $TestArea/../build/$CMTCONFIG/setup.sh && Reco_tf.py --AMIConfig r11189 --outputAODFile ${OUTPUT_AOD} --maxEvents ${MAXEVENTS} --inputLowPtMinbiasHitsFile $MINBIAS_LOW --inputHighPtMinbiasHitsFile $MINBIAS_HIGH --inputHITSFile ${INPUT_FILE} --preExec ${PRE_EXEC} --digiSeedOffset1 1 --digiSeedOffset2 1 --postInclude ./outputLevelConfig.py'"
#    COMMAND="bsub -q $bqueues -o log.out 'source $TestArea/../build/$CMTCONFIG/setup.sh && Reco_tf.py --AMIConfig r11189 --outputAODFile ${OUTPUT_AOD} --maxEvents ${MAXEVENTS} --inputHITSFile ${INPUT_FILE} --preExec ${PRE_EXEC} --digiSeedOffset1 1 --digiSeedOffset2 1 --postInclude ./outputLevelConfig.py RecJobTransforms/UseFrontier.py'"
#    COMMAND="source $TestArea/build/$CMTCONFIG/setup.sh && Reco_tf.py --autoConfiguration everything --outputESDFile ${OUTPUT_ESD} --maxEvents ${MAXEVENTS} --inputHITSFile ${INPUT_FILE} --geometryVersion ATLAS-R2-2016-01-00-01 --conditionsTag OFLCOND-MC16-SDR-14 --digiSeedOffset1 1 --digiSeedOffset2 1 --postInclude ./outputLevelConfig.py RecJobTransforms/UseFrontier.py"
    echo $COMMAND > tmp_athena_run.${number}.sh
    sh tmp_athena_run.${number}.sh
    cd -
    number=`expr $number + 1`
    echo "jobNumber = "${number}
  done
fi
