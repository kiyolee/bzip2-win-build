#!/bin/bash

if [ $# -eq 0 ]; then
  echo "usage: $0 {file-path-to-bzip2.exe}"
  exit 255
fi

BZIP2="$1"

cat words1

"$BZIP2" -1  < sample1.ref > sample1.rb2
"$BZIP2" -2  < sample2.ref > sample2.rb2
"$BZIP2" -3  < sample3.ref > sample3.rb2
"$BZIP2" -d  < sample1.bz2 > sample1.tst
"$BZIP2" -d  < sample2.bz2 > sample2.tst
"$BZIP2" -ds < sample3.bz2 > sample3.tst

errcnt=0
cmp -s sample1.bz2 sample1.rb2
if [ $? -ne 0 ]; then echo "sample1 compress failed."; errcnt=$(($errcnt+1)); fi
cmp -s sample2.bz2 sample2.rb2
if [ $? -ne 0 ]; then echo "sample2 compress failed."; errcnt=$(($errcnt+1)); fi
cmp -s sample3.bz2 sample3.rb2
if [ $? -ne 0 ]; then echo "sample3 compress failed."; errcnt=$(($errcnt+1)); fi
cmp -s sample1.tst sample1.ref
if [ $? -ne 0 ]; then echo "sample1 uncompress failed."; errcnt=$(($errcnt+1)); fi
cmp -s sample2.tst sample2.ref
if [ $? -ne 0 ]; then echo "sample2 uncompress failed."; errcnt=$(($errcnt+1)); fi
cmp -s sample3.tst sample3.ref
if [ $? -ne 0 ]; then echo "sample3 uncompress failed."; errcnt=$(($errcnt+1)); fi

if [ $errcnt -eq 0 ]; then
  echo "all tests succeeed."
else
  echo "$errcnt test(s) failed."
fi

exit $errcnt
