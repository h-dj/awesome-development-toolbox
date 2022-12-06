# JDK 6、JDK 8、JDK 12 的 export 命令
#export JDK6_HOME="/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home"
#export JDK8_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home"
#export JDK12_HOME="/Library/Java/JavaVirtualMachines/openjdk-12.0.1.jdk/Contents/Home"
#
#//或者按以下方式
#
#export JAVA_HOME=$(/usr/libexec/java_home -v14)
#
#export JAVA_8_HOME=$(/usr/libexec/java_home -v1.8)
#export JAVA_11_HOME=$(/usr/libexec/java_home -v11)
#export JAVA_14_HOME=$(/usr/libexec/java_home -v14)
#
#
## alias 命令链接到 export 命令
#alias jdk6="export JAVA_HOME=$JDK6_HOME"
#alias jdk8="export JAVA_HOME=$JDK8_HOME"
#alias jdk12="export JAVA_HOME=$JDK12_HOME"
#
## 或者以下方式
#alias java8='export JAVA_HOME=$JAVA_8_HOME'
#alias java11='export JAVA_HOME=$JAVA_11_HOME'
#alias java14='export JAVA_HOME=$JAVA_14_HOME'
#
##设置默认的JDK
#export jdk8
#或者以下方式
#export JAVA_HOME=$(/usr/libexec/java_home -v14)
idea_jdk_parent_dir="$HOME"/.jdks
idea_jdk_dir=$(ls "$idea_jdk_parent_dir")
file_index=0
for file in $idea_jdk_dir
do
  arr[file_index]="$idea_jdk_parent_dir/$file"
  echo "${arr[file_index]}"
  file_index+=1
done


echo "$(date +%Y%m%d%H%M%S)"
