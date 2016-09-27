rm -rf build
git clone git@github.com:kongeor/kongeor.github.io.git build
cp -rf resources/public/* build
cd build
git add *
git commit -a -m "build"
git push -u origin master
cd ..
