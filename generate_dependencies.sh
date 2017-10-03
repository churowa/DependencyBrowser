#! /bin/bash

/usr/libexec/PlistBuddy -c "clear" DependencyBrowser/Dependencies.plist
/usr/libexec/PlistBuddy -c "add Cocoapods array" DependencyBrowser/Dependencies.plist
/usr/libexec/PlistBuddy -c "add Carthage array" DependencyBrowser/Dependencies.plist

# Place all pods into the plist file
grep "pod " Podfile > pods_temp
while read p; do
  echo $p
  /usr/libexec/PlistBuddy -c "add :Cocoapods: string '$p'" DependencyBrowser/Dependencies.plist
done <pods_temp
rm pods_temp

# Place all cathage frameworks into the plist file.
grep "github " Cartfile > carts_temp
while read p; do
    echo $p
    /usr/libexec/PlistBuddy -c "add :Carthage: string '$p'" DependencyBrowser/Dependencies.plist
done <carts_temp

grep "git " Cartfile > carts_temp
while read p; do
    echo $p
    /usr/libexec/PlistBuddy -c "add :Carthage: string '$p'" DependencyBrowser/Dependencies.plist
done <carts_temp

rm carts_temp

/usr/libexec/PlistBuddy -c "save" DependencyBrowser/Dependencies.plist