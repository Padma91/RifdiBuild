#!/bin/bash

batchFile=$CCM_TB_DF_PLANS/sabatch
inputFile=$CCM_TB_DF_SPLIT_DATA/$2
inputData=$CCM_TB_DF_SPLIT_DATA
outputSectionData=$CCM_TB_DF_SECTION_DATA
billcycleno=`echo $3|cut -d "_" -f3`
filename=`echo $3|cut -d "_" -f1-3`
ctlfile=`find $outputSectionData -name "TB_PB_"$filename"_*.ctl"`
echo "ctlfile : $ctlfile"
splitnumber=`echo $ctlfile|cut -d "_" -f6`
splitnumber=`echo $splitnumber|cut -d "." -f1`
Accdet=`echo $2 | cut -d "_" -f1-5`
splitcheck=`expr $splitnumber + 0`
splitcheck11=`echo $splitnumber | sed 's/^0*//'`
Instance_No=`echo $3|cut -d "_" -f4`
Instance_Num=`expr $Instance_No + 0`
timestamp=`date '+%d%m%Y%H%M%S'`
echo "bill cycle: $billcycleno"
singlesplitcheck=0
Time=`date '+%I:%M %p'`
echo "TimeStart=$Time"

DFexecutioncount=`ls $controlfilepath/pcejoinctl/$billcycleno/|wc -l`
BCNumber=`echo $billcycleno|cut -c2-3`
SubCycleNumber=`echo $billcycleno|cut -c4-5`
echo "$BCNumber & $SubCycleNumber &&&&& $Instance_Num"

read TheInputFile < ${CCM_TB_GEN_LOG}/${BCNumber}_${SubCycleNumber}_Report_Flexcab_to_RIFDI.csv

echo "Input file of the log $TheInputFile"

BCDate=`echo ${TheInputFile} | cut -d',' -f1`
BCNum=`echo ${TheInputFile} | cut -d',' -f2`
SubCycle_Num=`echo ${TheInputFile} | cut -d',' -f3`
Total_Accounts=`echo ${TheInputFile} | cut -d',' -f4`
Num_PrintAccts=`echo ${TheInputFile} | cut -d',' -f5`
Num_EmailAccts=`echo ${TheInputFile} | cut -d',' -f6`
Num_OnilineAccts=`echo ${TheInputFile} | cut -d',' -f7`
Errorcount_Unpack=`echo ${TheInputFile} | cut -d',' -f8`

logFile=$CCM_TB_DF_LOGFILE/TB_Dataprep_${billcycleno}_Instance$1.log
# To find the total accounts from ACDC file.


Error_Dataprep=`cat $inputData'/TB_PB_'$3'_ACCDET.dat'| cut -c 18-27 | uniq -c | wc -l`
echo "Count: $Error_Dataprep"

# cat $inputData'/TB_PB_'$3'_ACCDET.dat' | cut -c 18-27| uniq -c > ${CCM_TB_GEN_LOG}/accountlist$timestamp.txt
# rm ${CCM_TB_GEN_LOG}/accountlist$timestamp.txt

#$batchFile $1 '\TB_Invoice\SplitData_Dev' $logFile InputFileName=$inputFile AccountDetails=$inputSectionData'/TB_PB_'$3'_ACCDET.dat' NewChargesSummary=$inputSectionData'/TB_PB_'$3'_NEWCHRGSUM.dat' PreviousPayments=$inputSectionData'/TB_PB_'$3'_PREVPAY.dat' Adjustments=$inputSectionData'/TB_PB'$3'_ADJMTS.dat' ImportantMessages=$inputSectionData'/TB_PB_'$3'_IMPMESS.dat' AccountChargesCredits=$inputSectionData'/TB_PB_'$3'_ACDC.dat' AccountLog=$inputSectionData'AccountLog_'$3'.log'
#$batchFile $1 '\TB\TB_Data_Manipulation' $logFile ADSource=$inputData'/TB_PB_'$3'_ACCDET.dat' NCSource=$inputData'/TB_PB_'$3'_NEWCHRGSUM.dat' NBSource=$inputData'/TB_PB_'$3'_NWCHRBRKDWN.dat' ACDCSource=$inputData'/TB_PB_'$3'_ACDC.dat' ADJSource=$inputData'/TB_PB_'$3'_ADJMTS.dat' PPSource=$inputData'/TB_PB_'$3'_PREVPAY.dat' IMSource=$inputData'/TB_PB_'$3'_IMPMESS.dat' TPSource=$inputData'/TB_PB_'$3'_TPCHRG.dat' ADOutput=$outputSectionData'/TB_PB_'$3'_ACCDET.dat' NCOutput=$outputSectionData'/TB_PB_'$3'_NEWCHRGSUM.dat' HSOutput=$outputSectionData'/TB_PB_'$3'_HIGSPESER.dat' ACDCOutput=$outputSectionData'/TB_PB_'$3'_ACDC.dat' ADJOutput=$outputSectionData'/TB_PB_'$3'_ADJMTS.dat' PPOutput=$outputSectionData'/TB_PB_'$3'_PREVPAY.dat' TPOutput=$outputSectionData'/TB_PB_'$3'_TPCHRG.dat' IMOutput=$outputSectionData'/TB_PB_'$3'_IMPMESS.dat' USAGESource=$inputData'/TB_PB_'$3'_USGEDET.dat' DBNCSource=$inputData'/TB_PB_'$3'_DB_NEWCHRGSUM.dat' DBNBSource=$inputData'/TB_PB_'$3'_DB_NWCHRBRKDWN.dat' DBUSGSource=$inputData'/TB_PB_'$3'_DB_USGEDET.dat' DBTPSource=$inputData'/TB_PB_'$3'_DB_TPCHRG.dat' DBOutput=$outputSectionData'/TB_PB_'$3'_DB_NC_NB_THRG.dat'

$batchFile $1 '\TB\TB_Data_Manipulation' $logFile TempFilePath=$CCM_TB_DF_TMP_PATH ADSource=$inputData'/TB_PB_'$3'_ACCDET.dat' NCSource=$inputData'/TB_PB_'$3'_NEWCHRGSUM.dat' NBSource=$inputData'/TB_PB_'$3'_NWCHRBRKDWN.dat' ACDCSource=$inputData'/TB_PB_'$3'_ACDC.dat' ADJSource=$inputData'/TB_PB_'$3'_ADJMTS.dat' PPSource=$inputData'/TB_PB_'$3'_PREVPAY.dat' IMSource=$inputData'/TB_PB_'$3'_IMPMESS.dat' TPSource=$inputData'/TB_PB_'$3'_TPCHRG.dat' ADOutput=$outputSectionData'/TB_PB_'$3'_ACCDET.dat' NCOutput=$outputSectionData'/TB_PB_'$3'_NEWCHRGSUM.dat' HSOutput=$outputSectionData'/TB_PB_'$3'_HIGSPESER.dat' ACDCOutput=$outputSectionData'/TB_PB_'$3'_ACDC.dat' ADJOutput=$outputSectionData'/TB_PB_'$3'_ADJMTS.dat' PPOutput=$outputSectionData'/TB_PB_'$3'_PREVPAY.dat' TPOutput=$outputSectionData'/TB_PB_'$3'_TPCHRG.dat' IMOutput=$outputSectionData'/TB_PB_'$3'_IMPMESS.dat' USAGESource=$inputData'/TB_PB_'$3'_USGEDET.dat' DBNCSource=$inputData'/TB_PB_'$3'_DB_NEWCHRGSUM.dat' DBNBSource=$inputData'/TB_PB_'$3'_DB_NWCHRBRKDWN.dat' DBUSGSource=$inputData'/TB_PB_'$3'_DB_USGEDET.dat' DBTPSource=$inputData'/TB_PB_'$3'_DB_TPCHRG.dat' DBOutput=$outputSectionData'/TB_PB_'$3'_DB_NC_NB_THRG.dat' DirCharSource=$inputData'/TB_PB_'$3'_DIR_CHRG.dat' DircharOutput=$outputSectionData'/TB_PB_'$3'_DIR_CHRG.dat' DBHSOutput=$outputSectionData'/TB_PB_'$3'_DB_HS.dat' DBAGOutput=$outputSectionData'/TB_PB_'$3'_DB_AT_GLANCE.dat' AGOutput=$outputSectionData'/TB_PB_'$3'_AT_GLANCE.dat' DBTPLGOutput=$outputSectionData'/TB_PB_'$3'_DB_TP_LEGEND.dat' TPLGOutput=$outputSectionData'/TB_PB_'$3'_TP_LEGEND.dat' DBDirCharSource=$inputData'/TB_PB_'$3'_DB_DIR_CHRG.dat' DBDirCharOutput=$outputSectionData'/TB_PB_'$3'_DB_DIR_CHRG.dat'
exit_status=$?
if [ $exit_status -eq 0 ]; then
        Error_Dataprep=0
#       echo "error dataprep: $Error_Dataprep $Instance_Num"
        echo "$Error_Dataprep" > $CCM_TB_OPS_REPORT/LogFiles/DF_inst_${BCNum}${SubCycle_Num}_$Instance_Num.txt
		 echo "inside Status $exit_status"
		 echo " BIllcycle Number : ${BCNum}${SubCycle_Num} "
		status_flag=0
else

        if [ $splitcheck -eq 1 ]; then
                singlesplitcheck=1
        fi
          echo "inside 2 Status $exit_status"
		 echo " BIllcycle Number : ${BCNum}${SubCycle_Num} "
        echo "error dataprep else part: $Error_Dataprep $Instance_Num"
        echo "$Error_Dataprep" > $CCM_TB_OPS_REPORT/LogFiles/DF_inst_${BCNum}${SubCycle_Num}_$Instance_Num.txt
		status_flag=1
fi

# Error_Dataprep=`awk '{s+=$0} END {print s}' $CCM_TB_OPS_REPORT/LogFiles/Dataprep_instances.txt`
Total_instance=1
sum=0

controlfilepath=$CCM_TB_DFNAS_ROOT
if [ -d $controlfilepath/pcejoinctl/$billcycleno ]; then
        mv $controlfilepath/'dfprocess_ctl/TB_PB_'$3'.ctl' $controlfilepath/pcejoinctl/$billcycleno/
else
        mkdir $controlfilepath/pcejoinctl/$billcycleno
        mv $controlfilepath/'dfprocess_ctl/TB_PB_'$3'.ctl' $controlfilepath/pcejoinctl/$billcycleno/
fi
DFexecutioncount=`ls $controlfilepath/pcejoinctl/$billcycleno/|wc -l`
Accdetcount=`ls $CCM_TB_DF_SPLIT_DATA/${Accdet}_*_ACCDET.dat |wc -l`

if [ $splitcheck == $DFexecutioncount ]; then

        while [  $Total_instance -le $splitcheck ]
        do
#       echo "Total: $Total_instance"
                if [ -s $CCM_TB_OPS_REPORT/LogFiles/DF_inst_${BCNum}${SubCycle_Num}_${Total_instance}.txt ]; then
                        cat $CCM_TB_OPS_REPORT/LogFiles/DF_inst_${BCNum}${SubCycle_Num}_${Total_instance}.txt | tee -a $CCM_TB_OPS_REPORT/LogFiles/DF_inst_${BCNum}${SubCycle_Num}.txt
                fi
        (( Total_instance++ ))
        done

        if [ -s $CCM_TB_OPS_REPORT/LogFiles/DF_inst_${BCNum}${SubCycle_Num}.txt ]; then

           for Error_Dataprep in $(cat $CCM_TB_OPS_REPORT/LogFiles/DF_inst_${BCNum}${SubCycle_Num}.txt)
                do
                sum=`expr $sum + $Error_Dataprep`
                done
        fi
        #adds the dataprep error to unpack error

        echo "Unpack error count: ${Errorcount_Unpack},Dataprep error accounts: ${sum}"
        echo "Sum is $sum $Errorcount_Unpack"

        Error_Unpack=`expr $sum + $Errorcount_Unpack`
#echo "removed in  $splitcheck"
#echo "to be removed in $DFexecutioncount"

        rm $CCM_TB_OPS_REPORT/LogFiles/${BCNum}_${SubCycle_Num}_Report_Flexcab_to_RIFDI.csv
        rm ${CCM_TB_GEN_LOG}/${BCNum}_${SubCycle_Num}_Report_Flexcab_to_RIFDI.csv

        #creating log file
        echo -n "${BCDate},${BCNum},${SubCycle_Num},${Total_Accounts},${Num_PrintAccts},${Num_EmailAccts},${Num_OnilineAccts},${Error_Unpack}," > $CCM_TB_OPS_REPORT/LogFiles/${BCNum}_${SubCycle_Num}_Report_Flexcab_to_RIFDI.csv

        cp $CCM_TB_OPS_REPORT/LogFiles/${BCNum}_${SubCycle_Num}_Report_Flexcab_to_RIFDI.csv $CCM_TB_GEN_LOG
        rm $CCM_TB_OPS_REPORT/LogFiles/DF_inst_${BCNum}${SubCycle_Num}*.txt
fi

         echo "Accdetcount : $Accdetcount"
		 echo "DFexecutioncount : $DFexecutioncount"
		 echo "singlesplitcheck : $singlesplitcheck"
if [ $Accdetcount == $DFexecutioncount ] && [ $singlesplitcheck == 0 ]; then
        mv $controlfilepath/pcejoinctl/$billcycleno/TB_PB_$filename'_'$splitnumber'.ctl' $controlfilepath/pcejoinctl/
        rm -r $controlfilepath/pcejoinctl/$billcycleno
fi

#Part which decides on the Control-M status
if [ $status_flag -eq 0 ] 
then
	exit 0
else
	exit 5
fi	
