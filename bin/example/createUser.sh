#!/bin/bash
read -p "Enter The Users Password : " PASSWD
for UNAME in `cat users.txt`
do
id $UNAME &> /dev/null
if [ $? -eq 0 ]
then
echo "Already exists"
else
useradd $UNAME &> /dev/null
echo "$PASSWD" | passwd --stdin $UNAME &> /dev/null
if [ $? -eq 0 ]
then
echo "Create success"
else
echo "User $UNAME Create failure"
echo $UNAME  >> createUserFailedLog
fi
fi
done
[[ -f createUserFailedLog ]] && echo "Check FailedLog"
