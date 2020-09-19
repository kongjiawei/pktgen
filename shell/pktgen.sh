#!/bin/bash 
trace_index=0
time_index=0
#set src ip
export SRC_IP='10.0.0.1/32'
export PKT_SIZE=1024
export ratio=100
echo "pktgen.set_ipaddr('0', 'src', '${SRC_IP}')" |  socat - TCP4:127.0.0.1:22022
echo "pktgen.set('0', 'size', ${PKT_SIZE})" | socat - TCP4:127.0.0.1:22022

#java --version
while read line
do
    trace_array[$trace_index]=$line
   # echo ${trace_array[$trace_index]}
    let trace_index++

done < trace
#echo ${trace_array[0]}
#echo ${trace_array[1]}
#echo ${trace_array[2]}
while read b
do
    time_array[time_index]=$b
    let time_index+=1
done < time_time1
#echo "pktgen.start ('0')" | socat - TCP4:127.0.0.1:22022
echo "pktgen.set('0','rate',${trace_array[0]}*${ratio})" | socat - TCP4:127.0.0.1:22022
sleep 1s
echo "pktgen.start('0')" | socat - TCP4:127.0.0.1:22022
sleep 1s
for ((i=0;i<$trace_index;i++))
do
echo "pktgen.set('0','rate',${trace_array[i]}*${ratio})" | socat - TCP4:127.0.0.1:22022
sleep ${time_array[i]}s
done
