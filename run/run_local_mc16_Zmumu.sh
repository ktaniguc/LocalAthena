#!/bin/sh
DATE=$(date '+%Y%m%d%H%M')

source $TestArea/../build/$CMTCONFIG/setup.sh

#INPUT_RDO="/gpfs/fs2001/yfukuhar/data/user.yfukuhar.mc16_13TeV.361107.PowhegPythia8EvtGen_AZNLOCTEQ6L1_Zmumu.recon.RDO.e3601_s3126_r9781.201806291853_EXT0/user.yfukuhar.14514992.EXT0._000004.RDO.pool.root"
INPUT_LIST="shortZmumuRDO_FTK.list"
INPUT_RDO_FOR_OUTPUT="user.yfukuhar.mc16_13TeV.Zmumu"
OUTPUT_AOD=$INPUT_RDO_FOR_OUTPUT".AOD."$DATE".root"
#CMT_CONFIG="x86_64-slc6-gcc62-opt"
#AMI_TAG="r9781"
#NFILES_PER_JOB='5'
#NEVENTS_PER_FILE='500'
#NEVENTS_PER_JOB='100'
#DESTSE='TOKYO-LCG2_SCRATCHDISK'
MAXEVENTS='100'

echo ""
echo "INPUT_LIST =   "$INPUT_LIST
echo "OUTPUT_AOD =   "$OUTPUT_AOD
echo ""


#echo "" | tee -a jediTaskID.info
#echo "LOG: " | tee -a jediTaskID.info
#
#eval $COMMAND 2>&1 | tee -a jediTaskID.info
#LOG_NAME="log_"$LOG_INDEX"_"$DATE


if [ -f "$INPUT_LIST" ] ; then
  echo $INPUT_LIST
  for INPUT_FILE in `cat $INPUT_LIST`
  do
    echo ""
    echo "INPUT_FILE =   "$INPUT_FILE
    echo ""
    TEMP_DIR=`echo "$INPUT_FILE" | sed -e "s:/:_:g"`
    DIR="Output/$TEMP_DIR"
    mkdir -p $DIR
    echo "Submit Directory: "$DIR
    cp ./*.sh $DIR
    cp ./*.py $DIR
    cd $DIR

    echo "Reco_tf.py '--inputRDO_FTKFile=${INPUT_FILE}' \
    '--maxEvents=500' \
    '--postExec' 'all:CfgMgr.MessageSvc().setError+=[\"HepMcParticleLink\"]' 'ESDtoAOD:fixedAttrib=[s if \"CONTAINER_SPLITLEVEL = \\\'99\\\'\" not in s else \"\" for s in svcMgr.AthenaPoolCnvSvc.PoolAttributes];svcMgr.AthenaPoolCnvSvc.PoolAttributes=fixedAttrib' 'RAWtoESD:topSequence.TrigSteer_HLT.enableRobRequestPreparation=False' \
    '--postInclude' 'default:PyJobTransforms/UseFrontier.py' \
    '--preExec' 'all:rec.Commissioning.set_Value_and_Lock(True);from AthenaCommon.BeamFlags import jobproperties;jobproperties.Beam.numberOfCollisions.set_Value_and_Lock(20.0);from LArROD.LArRODFlags import larRODFlags;larRODFlags.NumberOfCollisions.set_Value_and_Lock(20);larRODFlags.nSamples.set_Value_and_Lock(4);larRODFlags.doOFCPileupOptimization.set_Value_and_Lock(True);larRODFlags.firstSample.set_Value_and_Lock(0);larRODFlags.useHighestGainAutoCorr.set_Value_and_Lock(True)' 'all:from InDetRecExample.InDetJobProperties import InDetFlags; InDetFlags.doSlimming.set_Value_and_Lock(False)' 'all:from TriggerJobOpts.TriggerFlags import TriggerFlags;TriggerFlags.AODEDMSet.set_Value_and_Lock(\"AODFULL\");' 'all:from JetRec.JetRecFlags import jetFlags,JetContentDetail; jetFlags.detailLevel=JetContentDetail.Full' 'RAWtoESD:rec.doFTK.set_Value_and_Lock(True)' \
    '--skipEvents=0' \
    '--autoConfiguration=everything' \
    '--valid=True' \
    '--conditionsTag' 'default:OFLCOND-MC16-SDR-17' \
    '--geometryVersion=default:ATLAS-R2-2016-01-00-01' \
    '--runNumber=361107' \
    '--digiSeedOffset1=1911' \
    '--digiSeedOffset2=1911'\
    '--digiSteeringConf=StandardSignalOnlyTruth' \
    '--AMITag=r10681' \
    '--outputAODFile=${OUTPUT_AOD}' \
    '--jobNumber=1911' \
    '--triggerConfig=RAWtoESD=MCRECO:DBF:TRIGGERDBMC:2209,71,253' \
    '--postInclude=outputLevelConfig.py' " \
    > tmp.sh && bsub -q 1d -o log.out < tmp.sh

    #COMMAND="bsub -q 2d -o log.out 'source $TestArea/../build/$CMTCONFIG/setup.sh && Reco_tf.py --maxEvents ${MAXEVENTS} --outputAODFile ${OUTPUT_AOD} --inputRDOFile ${INPUT_FILE}' --postInclude ./outputLevelConfig.py"
    #COMMAND="bsub -q 2d -o log.out 'source $TestArea/../build/$CMTCONFIG/setup.sh && Reco_tf.py  
    #'--inputRDO_FTKFile=${INPUT_FILE}' 
    #'--maxEvents=500' 
    #'--postExec' 'all:CfgMgr.MessageSvc().setError+=["HepMcParticleLink"]' 'ESDtoAOD:fixedAttrib=[s if "CONTAINER_SPLITLEVEL = \'99\'" not in s else "" for s in svcMgr.AthenaPoolCnvSvc.PoolAttributes];svcMgr.AthenaPoolCnvSvc.PoolAttributes=fixedAttrib' 'RAWtoESD:topSequence.TrigSteer_HLT.enableRobRequestPreparation=False' 
    #'--postInclude' 'default:PyJobTransforms/UseFrontier.py' 
    #'--preExec' 'all:rec.Commissioning.set_Value_and_Lock(True);from AthenaCommon.BeamFlags import jobproperties;jobproperties.Beam.numberOfCollisions.set_Value_and_Lock(20.0);from LArROD.LArRODFlags import larRODFlags;larRODFlags.NumberOfCollisions.set_Value_and_Lock(20);larRODFlags.nSamples.set_Value_and_Lock(4);larRODFlags.doOFCPileupOptimization.set_Value_and_Lock(True);larRODFlags.firstSample.set_Value_and_Lock(0);larRODFlags.useHighestGainAutoCorr.set_Value_and_Lock(True)' 'all:from InDetRecExample.InDetJobProperties import InDetFlags; InDetFlags.doSlimming.set_Value_and_Lock(False)' 'all:from TriggerJobOpts.TriggerFlags import TriggerFlags;TriggerFlags.AODEDMSet.set_Value_and_Lock("AODFULL");' 'all:from JetRec.JetRecFlags import jetFlags,JetContentDetail; jetFlags.detailLevel=JetContentDetail.Full' 'RAWtoESD:rec.doFTK.set_Value_and_Lock(True)' 
    #'--skipEvents=0' 
    #'--autoConfiguration=everything' 
    #'--valid=True' 
    #'--conditionsTag' 'default:OFLCOND-MC16-SDR-17' 
    #'--geometryVersion=default:ATLAS-R2-2016-01-00-01' 
    #'--runNumber=361107' 
    #'--digiSeedOffset1=1911' 
    #'--digiSeedOffset2=1911'
    #'--digiSteeringConf=StandardSignalOnlyTruth' 
    #'--AMITag=r10681' 
    #'--outputAODFile=${OUTPUT_AOD}' 
    #'--jobNumber=1911' 
    #'--triggerConfig=RAWtoESD=MCRECO:DBF:TRIGGERDBMC:2209,71,253' 
    #'--postInclude ./outputLevelConfig.py'"
     #COMMAND="bsub -q 2d -o log.out \"source $TestArea/../build/$CMTCONFIG/setup.sh && Reco_tf.py --inputRDO_FTKFile=${INPUT_FILE} --maxEvents=500 --postInclude default:PyJobTransforms/UseFrontier.py --skipEvents=0 --autoConfiguration=everything --valid=True --conditionsTag default:OFLCOND-MC16-SDR-17 --geometryVersion=default:ATLAS-R2-2016-01-00-01 --digiSeedOffset1=1911 --digiSeedOffset2=1911 --digiSteeringConf=StandardSignalOnlyTruth --AMITag=r10681 --outputAODFile=${OUTPUT_AOD} --triggerConfig=RAWtoESD=MCRECO:DBF:TRIGGERDBMC:2209,71,253 --postInclude ./outputLevelConfig.py\""


    #echo $COMMAND > tmp_athena_run.sh
    #sh tmp_athena_run.sh
    cd -
  done
fi
