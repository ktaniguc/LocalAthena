setupATLAS
#asetup r2017-04-13T2135,AthenaP1,21.0
#asetup r2017-04-16T2135,AthenaP1,21.0
#asetup r2017-04-16T2130,Athena,21.0
#asetup r2017-04-17T2130,Athena,21.0
#asetup r2017-04-18T2130,Athena,21.0
#asetup r2017-04-19T2135,AthenaP1,21.0
#asetup 21.0,Athena,r26
#asetup 21.0,AthenaP1,r22
#asetup r2017-04-12T2135,AthenaP1,21.0
#asetup r2018-04-12T2135,AthenaP1,21.0
#asetup r2018-03-13T2125,Athena,21.0
#asetup r2018-03-09T2222,Athena,21.0
#asetup r2018-03-29T2156,Athena,21.3

# For user.yfukuhar.mc16_13TeV.361107.PowhegPythia8EvtGen_AZNLOCTEQ6L1_Zmumu.simul.HITS.e3601_s3126
#asetup Athena,21.0.32,here

# For mc16_13TeV.424108.Pythia8B_A14_CTEQ6L1_Jpsimu6.simul.HITS.e5441_e5984_s3126
#asetup Athena,21.0.53,here
#asetup Athena,21.5.6,here
#asetup r2019-07-09T2150,Athena,21.3,here
asetup AthenaP1,21.1.50,here
#asetup Athena,21.3.14,here
#asetup AtlasOffline,21.0.15,here
#asetup 21.0,Athena,r26
#asetup 21.0,Athena,r31
#asetup AtlasOffline,21.0.20,slc6,gcc62,64

lsetup git
export TestArea=$PWD
export PATH=.:${TestArea}/../:$PATH
