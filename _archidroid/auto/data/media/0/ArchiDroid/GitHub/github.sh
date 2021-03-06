#!/bin/bash
AD="/data/media/0/ArchiDroid"
ourFolder="$AD/GitHub"
ourRepo="origin"
ourLink="git://github.com/JustArchi/ArchiDroid.git"
VERSION="$1"

if [ -z "$VERSION" ]; then
	exit 1
fi

echo "CHANGELOG START"
echo ""
curl -kSs https://raw.github.com/JustArchi/ArchiDroid/$VERSION/META-INF/com/google/android/aroma/_changelog.txt
echo ""
echo ""
echo "CHANGELOG EOF"

if [ -d $ourFolder/$VERSION ]; then
	echo "Ok, repository already available with branch $VERSION. Updating..."
	cd $ourFolder/$VERSION
	ourOldHead=`git rev-parse HEAD`
	git pull $ourRepo $VERSION
	echo "New commits:"
	git --no-pager log --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset commited by %C(bold blue)%an%Creset' $ourOldHead..$ourRepo/$VERSION
	echo ""
	echo ""
else
	echo "Repository isn't available yet, cloning ArchiDroid repository branch $VERSION"
	cd $ourFolder
	git clone --branch $VERSION --depth 1 $ourLink $VERSION
	cd $ourFolder/$VERSION
	git pull $ourRepo $VERSION
fi

exit 0