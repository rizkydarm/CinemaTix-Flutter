#!/bin/bash

# Make the script exit on any error
set -e

# Update the minimum deployment target in Podfile
if [ -f "Podfile" ]; then
    echo "Updating Podfile deployment target..."
    sed -i '' "s/platform :ios, '.*'/platform :ios, '15.6'/g" Podfile
fi

# Update deployment target in project.pbxproj
if [ -f "Runner.xcodeproj/project.pbxproj" ]; then
    echo "Updating Runner project deployment target..."
    sed -i '' "s/IPHONEOS_DEPLOYMENT_TARGET = .*;/IPHONEOS_DEPLOYMENT_TARGET = 15.6;/g" Runner.xcodeproj/project.pbxproj
fi

# Install pods
rm -rf Pods Podfile.lock
pod install

# Post pod install: Force update all pods deployment target
find . -name "Podfile.lock" -exec sed -i '' 's/IPHONEOS_DEPLOYMENT_TARGET: .*$/IPHONEOS_DEPLOYMENT_TARGET: '15.6'/g' {} \;
echo "Updating Podfile.lock"

# Update xcconfig files
# for xcconfig in $(find . -name "*.xcconfig"); do
#     sed -i '' 's/IPHONEOS_DEPLOYMENT_TARGET = .*/IPHONEOS_DEPLOYMENT_TARGET = 15.6/g' "$xcconfig"
# done
# echo "Updating xcconfig files"

# Force update all pods project deployment target
for project in $(find Pods -name "project.pbxproj"); do
    sed -i '' 's/IPHONEOS_DEPLOYMENT_TARGET = .*;/IPHONEOS_DEPLOYMENT_TARGET = 15.6;/g' "$project"
done
echo "Updating project deployment target"

echo "iOS deployment target update completed"