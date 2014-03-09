# create temp folder
printf "Creating and moving to temp folder\n"
mkdir temp
cd temp

# create 
printf "Creating package.json\n"
echo "{}" > package.json

printf "Installing old versions of ansi-styles and moment...\n"
npm install --save ansi-styles@0.1
npm install --save moment@1

printf "\nNow we should have some out-of-date packages:\n"
cat package.json
npm outdated

printf "\nRunning the updatehammer...\n"
cp ../index.js ./
node index.js

printf "\nNow our packages should all be set to the latest:\n"
cat package.json
npm outdated
rm -rf node_modules
