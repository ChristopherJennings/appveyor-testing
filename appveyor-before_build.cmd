dotnet restore

cd my-vue-app

npm i

npm run build

cd ..\

IF %APPVEYOR_REPO_TAG% SET APPVEYOR_BUILD_VERSION = APPVEYOR_REPO_TAG_NAME