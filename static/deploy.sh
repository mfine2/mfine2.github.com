if [ ! -n "$1" ] ; then 
     echo "please input svn username as the first parameter" 
     exit 0
fi
if [ ! -n "$2" ] ; then 
     echo "please input svn password as the second parameter" 
     exit 0
fi
 
echo "********** yum update  **********"
yum update -y
 
echo "********** yum groupinstall Development Libraries **********"
yum groupinstall "Development Libraries" -y
 
echo "********** yum groupinstall Development Tools **********"
yum groupinstall "Development Tools" -y
 
echo "********** yum install subversion **********"
yum install subversion -y
 
echo "********** /data/wwwroot/js.wcdn.cn/ **********"
rm /data1/ -fr
mkdir /data1/wwwroot/js.wcdn.cn/ -p
cd /data1/wwwroot/js.wcdn.cn/
 
echo "********** download node-v0.6.18.tag.gz from nodejs.org **********"
wget  http://nodejs.org/dist/v0.6.18/node-v0.6.18.tar.gz
 
echo "********** tar xzf node-v0.6.18.tar.gz **********"
tar xzf node-v0.6.18.tar.gz
 
echo "********** cd node-v0.6.18 and install **********"
cd node-v0.6.18
./configure && make && make install
 
echo "********** cd ../ and rm node-v0.6.18 **********"
cd ../
rm node-v0.6.18 -fr
rm node-v0.6.18.tar.gz -f
 
echo "********** svn co tools **********"
svn co https://svn1.intra.sina.com.cn/weibo/ria/tools/combine-2012-02-20 --username "$1" --password "$2" --no-auth-cache --non-interactive ./tools/combine-2012-02-20 
 
echo "********** start node server **********"
sh ./tools/combine-2012-02-20/server/restart.sh
 
echo "********** add t4 folder and soft link **********"
mkdir /data1/wwwroot/js.wcdn.cn/t4/apps/ -p
ln -s /data1/wwwroot/js.wcdn.cn/t4/ ~/t4
