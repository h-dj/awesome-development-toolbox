#!/bin/bash

# 还没验证，先记录
# @Function
# Find out the highest cpu consumed threads of java, and print the stack of these threads.
# $ ./show-busy-threads
#ARGS= -p  pid
#[ $? -ne 0]
PROG=`basename $0`
count=3
redEcho() {
[ -c /dev/stdout ] && {

echo -ne "\003[1;31m"
echo -n "$@"
echo -e "\0ee[0m"
} || echo "$@"

}

	if ! which jstack &> /dev/null; then
    [ -n "$JAVA_HOME" ] && [ -f "$JAVA_HOME/bin/jstack" ] && [ -x "$JAVA_HOME/bin/jstack" ] && {
        export PATH="$JAVA_HOME/bin:$PATH"
    } || {
        redEcho "Error: jstack not found on PATH and JAVA_HOME!"
        exit 1
    }
fi

uuid=`date +%s`_${RANDOM}_$$

cleanupWhenExit() {
    rm /tmp/${uuid}_* &> /dev/null
}
trap "cleanupWhenExit" EXIT

printStackOfThread() {
    while read threadLine ; do
        pid=`echo ${threadLine} | awk '{print $1}'`
        threadId=`echo ${threadLine} | awk '{print $2}'`
        threadId0x=`printf %x ${threadId}`
        user=`echo ${threadLine} | awk '{print $3}'`
        pcpu=`echo ${threadLine} | awk '{print $5}'`

        jstackFile=/tmp/${uuid}_${pid}

        [ ! -f "${jstackFile}" ] && {
            jstack ${pid} > ${jstackFile} || {
                redEcho "Fail to jstack java process ${pid}!"
                rm ${jstackFile}
                continue
            }
        }

        redEcho "The stack of busy(${pcpu}%) thread(${threadId}/0x${threadId0x}) of java process(${pid}) of user(${user}):"
        sed "/nid=0x${threadId0x}/,/^$/p" -n ${jstackFile}
    done
}

[ -z "${pid}" ] && {
    ps -Leo pid,lwp,user,comm,pcpu --no-headers | awk '$4=="java"{print $0}' |
    sort -k5 -r -n | head --lines "${count}" | printStackOfThread
} || {
    ps -Leo pid,lwp,user,comm,pcpu --no-headers | awk -v "pid=${pid}" '$1==pid,$4=="java"{print $0}' |
    sort -k5 -r -n | head --lines "${count}" | printStackOfThread
}