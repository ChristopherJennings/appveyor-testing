dotnet publish .\MyConsoleApp\MyConsoleApp.csproj /p:PublishDir=publish -c Release -r win-x64 --self-contained true

xcopy my-vue-app\dist publish\dist /E /I

7z a appveyor_test-%APPVEYOR_BUILD_VERSION%.zip publish\*

appveyor PushArtifact appveyor_test-%APPVEYOR_BUILD_VERSION%.zip