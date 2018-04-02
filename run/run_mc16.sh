#!/bin/sh
source $TestArea/../build/$CMTCONFIG/setup.sh
MAX_EVENT=100
AMITAG="r8957"
AMITAG="r9707_26"
AMITAG="r9703"
#BASE_DIR="/gpfs/fs6001/yyazawa/data/mc16_13TeV.361107.PowhegPythia8EvtGen_AZNLOCTEQ6L1_Zmumu.simul.HITS.e3601_s2997/"
#BASE_DIR="/gpfs/fs6001/yyazawa/data/data17_13TeV.00339758.express_express.merge.AOD.x539_m1897/"
#BASE_DIR="/gpfs/fs6001/yyazawa/data/mc16_13TeV.300201.Pythia8BPhotospp_A14_CTEQ6L1_bb_Jpsimu4mu4.simul.HITS.e4397_s3126/"
BASE_DIR="/gpfs/fs6001/yyazawa/data/mc16_13TeV.424103.Pythia8B_A14NNPDF23LO_pp_Jpsi_mu15mu2p5.simul.HITS.e4397_s3126/"
#BASE_DIR="/gpfs/fs6001/yyazawa/data/mc15_13TeV.361107.PowhegPythia8EvtGen_AZNLOCTEQ6L1_Zmumu.merge.HITS.e3601_s2576_s2132/"
#mc15_13TeV.424103.Pythia8B_A14NNPDF23LO_pp_Jpsi_mu15mu2p5.simul.HITS.e4397_s2608
#HIGH_FILE="/gpfs/fs6001/yyazawa/data/mc16_13TeV.361239.Pythia8EvtGen_A3NNPDF23LO_minbias_inelastic_high.merge.HITS.e4981_s2997_s2939/HITS.10008159._000019.pool.root.1"
HIGH_FILE="/gpfs/fs6001/yyazawa/data/mc16_13TeV.361239.Pythia8EvtGen_A3NNPDF23LO_minbias_inelastic_high.simul.HITS.e4981_s3087_s3111/HITS.10701335._001960.pool.root.1"
LOW_FILE="/gpfs/fs6001/yyazawa/data/mc16_13TeV.361238.Pythia8EvtGen_A3NNPDF23LO_minbias_inelastic_low.simul.HITS.e4981_s3087_s3111/HITS.10701323._001009.pool.root.1"
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
  DIR=`echo $FILE | sed -e "s:$BASE_DIR:DIR_${AMITAG}_:g"`
  mkdir $DIR && cd $DIR
  #echo "Reco_tf.py '--inputHITSFile=${FILE}' '--AMIConfig=${AMITAG}'  '--maxEvents=${MAX_EVENT}' '--outputAODFile=AOD.pool.root' '--jobNumber=1' '--inputLowPtMinbiasHitsFile=${LOW_FILE}' '--inputHighPtMinbiasHitsFile=${HIGH_FILE}'" > tmp.sh && bsub -q 12h -o log.out < tmp.sh && rm tmp.sh
  #echo "Reco_tf.py '--inputHITSFile=${FILE}' '--AMIConfig=${AMITAG}'  '--maxEvents=${MAX_EVENT}' '--outputAODFile=AOD.pool.root' '--jobNumber=1' '--inputLowPtMinbiasHitsFile=mc16_13TeV.361238.Pythia8EvtGen_A3NNPDF23LO_minbias_inelastic_low.merge.HITS.e4981_s2997_s2939' '--inputHighPtMinbiasHitsFile=mc16_13TeV.361239.Pythia8EvtGen_A3NNPDF23LO_minbias_inelastic_high.merge.HITS.e4981_s2997_s2939'" > tmp.sh && bsub -q 12h -o log.out < tmp.sh && rm tmp.sh
  #echo "Reco_tf.py --digiSteeringConf 'StandardSignalOnlyTruth'\
  #  --conditionsTag 'default:OFLCOND-MC16-SDR-20' \
  #  --valid 'True' \
  #  --pileupFinalBunch '6' \
  #  --numberOfHighPtMinBias '0.15520183' \
  #  --autoConfiguration 'everything' \
  #  --numberOfLowPtMinBias '59.3447981771' \
  #  --steering 'doRDO_TRIG' \
  #  --preInclude 'HITtoRDO:Digitization/ForceUseOfPileUpTools.py,SimulationJobOptions/preInlcude.PileUpBunchTrainsMC16c_2017_Config1.py,RunDependentSimData/configLumi_run300000_mc16c.py' \
  #  --postExec 'all:CfgMgr.MessageSvc().setError+=[\"HepMcParticleLink\"]' \
  #  'ESDtoAOD:fixedAttrib=[s if \"CONTAINER_SPLITLEVEL = \'99\'\" not in s else \"\" for s in svcMgr.AthenaPoolCnvSvc.PoolAttributes];svcMgr.AthenaPoolCnvSvc.PoolAttributes=fixedAttrib' \
  #  'RDOtoRDOTrigger:from TrigT2CaloCommon.TrigT2CaloCommonConfig import TrigDataAccess;ToolSvc+=TrigDataAccess(); ToolSvc.TrigDataAccess.fullTileMode=False;ToolSvc.TileRegionSelectorTable.FullRODs=False' \
  #  --postInclude 'default:PyJobTransforms/UseFrontier.py' \
  #  --preExec 'all:rec.Commissioning.set_Value_and_Lock(True);from AthenaCommon.BeamFlags import jobproperties;jobproperties.Beam.numberOfCollisions.set_Value_and_Lock(20.0);from LArROD.LArRODFlags import larRODFlags;larRODFlags.NumberOfCollisions.set_Value_and_Lock(20);larRODFlags.nSamples.set_Value_and_Lock(4);larRODFlags.doOFCPileupOptimization.set_Value_and_Lock(True);larRODFlags.firstSample.set_Value_and_Lock(0);larRODFlags.useHighestGainAutoCorr.set_Value_and_Lock(True); from LArDigitization.LArDigitizationFlags import jobproperties;jobproperties.LArDigitizationFlags.useEmecIwHighGain.set_Value_and_Lock(False)' \
  #  'all:from InDetRecExample.InDetJobProperties import InDetFlags; InDetFlags.doSlimming.set_Value_and_Lock(False)' \
  #  'ESDtoAOD:from TriggerJobOpts.TriggerFlags import TriggerFlags;TriggerFlags.AODEDMSet.set_Value_and_Lock(\"AODSLIM\");' \
  #  --triggerConfig 'RDOtoRDOTrigger=MCRECO:DBF:TRIGGERDBMC:2165,46,189' \
  #  --geometryVersion 'default:ATLAS-R2-2016-01-00-01' \
  #  --numberOfCavernBkg '0' " \
  #> tmp.sh && bsub -q 12h -o log.out < tmp.sh && rm tmp.sh

  #echo "Reco_tf.py --inputHITSFile '${FILE}' '--maxEvents=${MAX_EVENT}' '--outputAODFile=AOD.pool.root' --digiSteeringConf 'StandardSignalOnlyTruth' --conditionsTag 'default:OFLCOND-MC16-SDR-20' --valid 'True' --pileupFinalBunch '6' --numberOfHighPtMinBias '0.15520183' --autoConfiguration 'everything' --numberOfLowPtMinBias '59.3447981771' --steering 'doRDO_TRIG' --preInclude 'HITtoRDO:Digitization/ForceUseOfPileUpTools.py,SimulationJobOptions/preInlcude.PileUpBunchTrainsMC16c_2017_Config1.py,RunDependentSimData/configLumi_run300000_mc16c.py' --postExec 'all:ServiceMgr.GeoModelSvc.IgnoreTagDifference=True' 'ESDtoAOD:fixedAttrib=[s if "CONTAINER_SPLITLEVEL = '99'" not in s else "" for s in svcMgr.AthenaPoolCnvSvc.PoolAttributes];svcMgr.AthenaPoolCnvSvc.PoolAttributes=fixedAttrib' --postInclude 'default:PyJobTransforms/UseFrontier.py' --preExec 'all:rec.Commissioning.set_Value_and_Lock(True);from AthenaCommon.BeamFlags import jobproperties;jobproperties.Beam.numberOfCollisions.set_Value_and_Lock(20.0);from LArROD.LArRODFlags import larRODFlags;larRODFlags.NumberOfCollisions.set_Value_and_Lock(20);larRODFlags.nSamples.set_Value_and_Lock(4);larRODFlags.doOFCPileupOptimization.set_Value_and_Lock(True);larRODFlags.firstSample.set_Value_and_Lock(0);larRODFlags.useHighestGainAutoCorr.set_Value_and_Lock(True); from LArDigitization.LArDigitizationFlags import jobproperties;jobproperties.LArDigitizationFlags.useEmecIwHighGain.set_Value_and_Lock(False)' 'all:from InDetRecExample.InDetJobProperties import InDetFlags; InDetFlags.doSlimming.set_Value_and_Lock(False)' 'ESDtoAOD:from TriggerJobOpts.TriggerFlags import TriggerFlags;TriggerFlags.AODEDMSet.set_Value_and_Lock(\"AODSLIM\");' --triggerConfig 'RDOtoRDOTrigger=MCRECO:DBF:TRIGGERDBMC:2165,46,189' --geometryVersion 'default:ATLAS-R2-2016-01-00-01' --numberOfCavernBkg '0' --jobNumber '1' --inputLowPtMinbiasHitsFile '${LOW_FILE}' --inputHighPtMinbiasHitsFile '${HIGH_FILE}' " \
  #> tmp.sh && bsub -q 12h -o log.out < tmp.sh 
#  echo "Reco_tf.py --inputHITSFile '${FILE}' '--maxEvents=${MAX_EVENT}' '--outputAODFile=AOD.pool.root' --digiSteeringConf 'StandardSignalOnlyTruth' --conditionsTag 'default:OFLCOND-MC16-SDR-20' --valid 'True' --pileupFinalBunch '6' --numberOfHighPtMinBias '0.15520183' --autoConfiguration 'everything' --numberOfLowPtMinBias '59.3447981771' --steering 'doRDO_TRIG' --preInclude 'HITtoRDO:Digitization/ForceUseOfPileUpTools.py,SimulationJobOptions/preInlcude.PileUpBunchTrainsMC16c_2017_Config1.py,RunDependentSimData/configLumi_run300000_mc16c.py' --postExec 'all:ServiceMgr.GeoModelSvc.IgnoreTagDifference=True' 'ESDtoAOD:fixedAttrib=[s if "CONTAINER_SPLITLEVEL = '99'" not in s else "" for s in svcMgr.AthenaPoolCnvSvc.PoolAttributes];svcMgr.AthenaPoolCnvSvc.PoolAttributes=fixedAttrib' 'RDOtoRDOTrigger:from TrigT2CaloCommon.TrigT2CaloCommonConfig import TrigDataAccess;ToolSvc+=TrigDataAccess();' --postInclude 'default:PyJobTransforms/UseFrontier.py' --preExec 'all:rec.Commissioning.set_Value_and_Lock(True);from AthenaCommon.BeamFlags import jobproperties;jobproperties.Beam.numberOfCollisions.set_Value_and_Lock(20.0);from LArROD.LArRODFlags import larRODFlags;larRODFlags.NumberOfCollisions.set_Value_and_Lock(20);larRODFlags.nSamples.set_Value_and_Lock(4);larRODFlags.doOFCPileupOptimization.set_Value_and_Lock(True);larRODFlags.firstSample.set_Value_and_Lock(0);larRODFlags.useHighestGainAutoCorr.set_Value_and_Lock(True); from LArDigitization.LArDigitizationFlags import jobproperties;jobproperties.LArDigitizationFlags.useEmecIwHighGain.set_Value_and_Lock(False)' 'ESDtoAOD:from TriggerJobOpts.TriggerFlags import TriggerFlags;TriggerFlags.AODEDMSet.set_Value_and_Lock(\"AODSLIM\");' --triggerConfig 'RDOtoRDOTrigger=MCRECO:DBF:TRIGGERDBMC:2170,46,199' --geometryVersion 'default:ATLAS-R2-2016-01-00-01' --numberOfCavernBkg '0' --jobNumber '1' --inputLowPtMinbiasHitsFile '${LOW_FILE}' --inputHighPtMinbiasHitsFile '${HIGH_FILE}' " \
#  > tmp.sh && bsub -q 12h -o log.out < tmp.sh 
  #echo "Reco_tf.py '--inputHITSFile=${FILE}' '--AMIConfig=${AMITAG}'  '--maxEvents=${MAX_EVENT}' '--outputAODFile=AOD.pool.root' '--jobNumber=1' --inputLowPtMinbiasHitsFile '${LOW_FILE}' --inputHighPtMinbiasHitsFile '${HIGH_FILE}'" > tmp.sh && bsub -q 12h -o log.out < tmp.sh && rm tmp.sh
  echo "Reco_tf.py '--inputHITSFile=${FILE}' \
    '--maxEvents=${MAX_EVENT}' \
    '--outputAODFile=AOD.pool.root' '--conditionsTag' 'default:OFLCOND-MC16-SDR-19' '--digiSteeringConf' 'StandardSignalOnlyTruth' '--geometryVersion' 'default:ATLAS-R2-2016-01-00-01' '--numberOfCavernBkg' '0' '--numberOfHighPtMinBias' '0.15520183' '--numberOfLowPtMinBias' '59.3447981771' '--pileupFinalBunch' '6' --postExec 'RDOtoRDOTrigger:from TrigT2CaloCommon.TrigT2CaloCommonConfig import TrigDataAccess;ToolSvc+=TrigDataAccess();' 'all:from IOVDbSvc.CondDB import conddb;' --preExec 'all:rec.Commissioning.set_Value_and_Lock(True);from AthenaCommon.BeamFlags import jobproperties;jobproperties.Beam.numberOfCollisions.set_Value_and_Lock(20.0);from LArROD.LArRODFlags import larRODFlags;larRODFlags.NumberOfCollisions.set_Value_and_Lock(20);larRODFlags.nSamples.set_Value_and_Lock(4);larRODFlags.doOFCPileupOptimization.set_Value_and_Lock(True);larRODFlags.firstSample.set_Value_and_Lock(0);larRODFlags.useHighestGainAutoCorr.set_Value_and_Lock(True)' 'all:from InDetRecExample.InDetJobProperties import InDetFlags; InDetFlags.doSlimming.set_Value_and_Lock(False)' --steering 'doRDO_TRIG' --triggerConfig 'RDOtoRDOTrigger=MCRECO:DBF:TRIGGERDBMC:2165,46,189' --valid 'True' '--jobNumber=1' --inputLowPtMinbiasHitsFile '${LOW_FILE}' --inputHighPtMinbiasHitsFile '${HIGH_FILE}'" > tmp.sh && bsub -q 12h -o log.out < tmp.sh 
  #  --steering 'doRDO_TRIG' \
  #  --triggerConfig 'RDOtoRDOTrigger=MCRECO:DBF:TRIGGERDBMC:2165,46,189' \
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

