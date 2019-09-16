#!/bin/bash
#创建目录
x=8 ; input=httprobe.txt ; export x=8 ; export input=httprobe.txt
for i in `seq 1 $x`
do
mkdir dir_$i
done

#切割文本
a=`wc -l $input|grep -o -P ".*?(?=\ )"`
#y=$((x-1))
each=$(($a/$x))
split -l $each  $input -d -a 3 split_

#可能多出一份文件
maybe=`ls|grep split|wc -l|grep -o -P ".*?(?=\ )"`
if [ '$maybe' != '$x' ]
then
cat split_000 >> split_00$x ; rm split_000
fi

#移动到一级分割目录
for i in `seq 1 $x`
do
mv split_00$i dir_$i/$input
done



#嵌套
for i in `seq 1 $x`
do

#创建二级分割目录
for num in `seq 1 $x`
do
mkdir /root/script/3_httprobe/dir_$i/dir_$num

#切割一级文本
a=`wc -l /root/script/3_httprobe/dir_$i/$input|grep -o -P ".*?(?=\ )"`
#y=$((x-1))
each=$(($a/$x))
cd /root/script/3_httprobe/dir_$i
split -l $each  /root/script/3_httprobe/dir_$i/$input -d -a 3 split_
done
done

for i in `seq 1 $x`
do
#删除一级文本
rm /root/script/3_httprobe/dir_$i/$input
done

for i in `seq 1 $x`
do
cd /root/script/3_httprobe/dir_$i
#合并可能多出的一份文件
maybe=`ls|grep split|wc -l|grep -o -P ".*?(?=\ )"`
if [ '$maybe' != '$x' ]
then
cat /root/script/3_httprobe/dir_$i/split_000 >> /root/script/3_httprobe/dir_$i/split_00$x ; rm /root/script/3_httprobe/dir_$i/split_000
fi
done

for i in `seq 1 $x`
do
for num in `seq 1 $x`
do
#移动到二级分割目录
mv /root/script/3_httprobe/dir_$i/split_00$num /root/script/3_httprobe/dir_$i/dir_$num/$input
done
done



for i in `seq 1 $x`
do
for num in `seq 1 $x`
do
cd /root/script/3_httprobe
#创建bash
echo '#!/bin/bash' >> /root/script/3_httprobe/dir_$i/dir_$num/${i}.sh
echo 'x=$x ; input=httprobe.txt' >> /root/script/3_httprobe/dir_$i/dir_$num/${i}.sh
echo "cd /root/script/3_httprobe/dir_$i/dir_$num" >> /root/script/3_httprobe/dir_$i/dir_$num/${i}.sh
echo "cp -r /root/script/3_httprobe/Arjun/* /root/script/3_httprobe/dir_$i/dir_$num" >> /root/script/3_httprobe/dir_$i/dir_$num/${i}.sh
random=`shuf -i 10-20 -n 1` ; thread=`shuf -i 3-5 -n 1`
echo "for c in "\`cat /root/script/3_httprobe/dir_$i/dir_$num/${input}\`"; do python3 arjun.py -u \$c -t $thread -d $random -o 1.txt --get" >> /root/script/3_httprobe/dir_$i/dir_$num/${i}.sh
echo 'grep -oP "param\"\:\ \".*" 1.txt | grep -oP "\ \".*\"" | sed -e "s/\"//g" | sed -e "s/\ //g" > 2.txt' >> /root/script/3_httprobe/dir_$i/dir_$num/${i}.sh
echo 'for param in `cat 2.txt`; do echo "$a?${param}=1" >> /root/script/3_httprobe/params_xss_test.txt; done; done' >> /root/script/3_httprobe/dir_$i/dir_$num/${i}.sh
echo "cd /root/script/3_httprobe; rm -r /root/script/3_httprobe/dir_$i/dir_$num" >> /root/script/3_httprobe/dir_$i/dir_$num/${i}.sh
done
done



#执行并删除
cd /root/script/3_httprobe
echo '#!/bin/bash' >> exe.sh
for i in `seq 1 $x`
do
for num in `seq 1 $x`
do
echo "bash /root/script/3_httprobe/dir_$i/dir_$num/${i}.sh" >> exe.sh
done
done
cat /root/script/3_httprobe/exe.sh | parallel --jobs 0 --progress --delay 1

for i in `seq 1 $x`
do
rm -r dir_$i
done

sort -u /root/script/3_httprobe/httprobe.txt -o /root/script/3_httprobe/httprobe.txt ; sort -u /root/script/3_httprobe/params_xss_test.txt -o /root/script/3_httprobe/params_xss_test.txt ; rm exe.sh















#xsstrike

#创建目录
x=8 ; input=/root/script/3_httprobe/params_xss_test.txt ; export x=8 ; export input=/root/script/3_httprobe/params_xss_test.txt
for i in `seq 1 $x`
do
mkdir dir_$i
done

#切割文本
a=`wc -l $input|grep -o -P ".*?(?=\ )"`
#y=$((x-1))
each=$(($a/$x))
split -l $each  $input -d -a 3 split_

#可能多出一份文件
maybe=`ls|grep split|wc -l|grep -o -P ".*?(?=\ )"`
if [ '$maybe' != '$x' ]
then
cat split_000 >> split_00$x ; rm split_000
fi

#移动到一级分割目录
for i in `seq 1 $x`
do
mv split_00$i dir_$i/$input
done



#嵌套
for i in `seq 1 $x`
do

#创建二级分割目录
for num in `seq 1 $x`
do
mkdir /root/script/3_httprobe/dir_$i/dir_$num

#切割一级文本
a=`wc -l /root/script/3_httprobe/dir_$i/$input|grep -o -P ".*?(?=\ )"`
#y=$((x-1))
each=$(($a/$x))
cd /root/script/3_httprobe/dir_$i
split -l $each  /root/script/3_httprobe/dir_$i/$input -d -a 3 split_
done
done

for i in `seq 1 $x`
do
#删除一级文本
rm /root/script/3_httprobe/dir_$i/$input
done

for i in `seq 1 $x`
do
cd /root/script/3_httprobe/dir_$i
#合并可能多出的一份文件
maybe=`ls|grep split|wc -l|grep -o -P ".*?(?=\ )"`
if [ '$maybe' != '$x' ]
then
cat /root/script/3_httprobe/dir_$i/split_000 >> /root/script/3_httprobe/dir_$i/split_00$x ; rm /root/script/3_httprobe/dir_$i/split_000
fi
done

for i in `seq 1 $x`
do
for num in `seq 1 $x`
do
#移动到二级分割目录
mv /root/script/3_httprobe/dir_$i/split_00$num /root/script/3_httprobe/dir_$i/dir_$num/$input
done
done



for i in `seq 1 $x`
do
for num in `seq 1 $x`
do
cd /root/script/3_httprobe
#创建bash
echo '#!/bin/bash' >> /root/script/3_httprobe/dir_$i/dir_$num/${i}.sh
echo 'x=$x ; input=httprobe.txt' >> /root/script/3_httprobe/dir_$i/dir_$num/${i}.sh
echo "cd /root/script/3_httprobe/dir_$i/dir_$num" >> /root/script/3_httprobe/dir_$i/dir_$num/${i}.sh
echo "cp -r /root/script/3_httprobe/XSStrike/* /root/script/3_httprobe/dir_$i/dir_$num" >> /root/script/3_httprobe/dir_$i/dir_$num/${i}.sh
#random=`shuf -i 10-20 -n 1` ; thread=`shuf -i 3-5 -n 1`
echo "for c in "\`cat /root/script/3_httprobe/dir_$i/dir_$num/${input}\`"; do python3 xsstrike.py -u \$c --console-log-level CRITICAL -t 20 --skip --blind >> \${output}/xss.txt" >> /root/script/3_httprobe/dir_$i/dir_$num/${i}.sh
#echo 'grep -oP "param\"\:\ \".*" 1.txt | grep -oP "\ \".*\"" | sed -e "s/\"//g" | sed -e "s/\ //g" > 2.txt' >> /root/script/3_httprobe/dir_$i/dir_$num/${i}.sh
#echo 'for param in `cat 2.txt`; do echo "$a?${param}=1" >> /root/script/3_httprobe/params_xss_test.txt; done; done' >> /root/script/3_httprobe/dir_$i/dir_$num/${i}.sh
echo "cd /root/script/3_httprobe; rm -r /root/script/3_httprobe/dir_$i/dir_$num" >> /root/script/3_httprobe/dir_$i/dir_$num/${i}.sh
done
done



#执行并删除
cd /root/script/3_httprobe
echo '#!/bin/bash' >> exe.sh
for i in `seq 1 $x`
do
for num in `seq 1 $x`
do
echo "bash /root/script/3_httprobe/dir_$i/dir_$num/${i}.sh" >> exe.sh
done
done
cat /root/script/3_httprobe/exe.sh | parallel --jobs 0 --progress --delay 1

for i in `seq 1 $x`
do
rm -r dir_$i
done

mv /root/script/3_httprobe/params_xss_test.txt $output
