#!/bin/sh
# Run MINE with variable pairs, using as many parellel processes
# as specified by the user (default 2)
SCRIPT_NAME=`basename $0`
THREADS=2
FILE_TO_RUN="no_file_supplied"



# Get arguments
while test $# -gt 0; do
        case "$1" in
                -h|--help)
                        echo "$SCRIPT_NAME - Run MINE in parallel"
                        echo " "
                        echo "$SCRIPT_NAME [options] <csv_file>"
                        echo " "
                        echo "options:"
                        echo "-h, --help              Show brief help"
                        echo "-p, --processes <int>   Maximum number of processes to run in parallel"
                        exit 0
                        ;;
                -p)
                        shift
                        if test $# -gt 0; then
                                THREADS=$1
                        else
                                echo "Maximum parallelization not found"
                                exit 1
                        fi
                        shift
                        ;;
                --processes)
                        shift
                        if test $# -gt 0; then
                                THREADS=$1
                        else
                                echo "Maximum parallelization not found"
                                exit 1
                        fi
                        shift
                        ;;
                *)
                        FILE_TO_RUN=$1
                        break;
                        ;;
        esac
done

#next_params() {
#  mod_limit=$2
#  col1=`expr $count / $mod_limit`
#  col2=`expr $count % mod_limit`
#  params="$col1 $col2"
#}

invoke() {
  echo "Invoking MINE for $2 $3 using a maximum of $4 processes"
  while ( $((jobs | wc -l)) >= $4 ); do
    sleep 3;
    jobs > /dev/null
  done
  ls > /dev/null &
#    CMD="java -jar MINE.jar $FILE_TO_RUN -onePair $i $j"
}


# Make sure file exists
if [ ! -e $FILE_TO_RUN ]
  then
  echo "No file found"
  exit 1
fi

# Gets number of columns in the CSV
NUM_COLS=`awk -F',' ' { print NF }' $FILE_TO_RUN | sort | uniq`
echo "$NUM_COLS columns in $FILE_TO_RUN"
COL_LIMIT=`expr $NUM_COLS - 1`
#COUNT_LIMIT=`expr $NUM_COLS \* $NUM_COLS - $NUM_COLS`
#COUNT_LIMIT=`expr $COUNT_LIMIT / 2 - 1`
#echo "COUNT_LIMIT=$COUNT_LIMIT"

#for i in `seq 0 $COUNT_LIMIT`
#do
#  next_params $i $COUNT_LIMIT
#  echo "$i of $COUNT_LIMIT: $params"
#done


COL_LIMIT=1

for i in `seq 0 $COL_LIMIT`
do
  start=`expr $i + 1`
  for j in `seq $start $COL_LIMIT`
  do
#    invoke $FILE_TO_RUN $i $j $THREADS
    CMD="java -jar MINE.jar $FILE_TO_RUN -onePair $i $j"
    echo $CMD
    $CMD 
  done
done

wait

