Theia extension dev
==

## Content
- nvm
- node 10
- yarn
- yo 
- generator-theia-extension 
- @theia/generator-plugin 
- generator-code typescript 
- ovsx 
- vsce

## Run

```
docker run -it --rm -p 3000:3000 --user $(id -u):$(id -g) -w=/workspace -v $(pwd):/workspace theia-ext-dev

yo theia-extension my-extension
# or
yo @theia/plugin my-plugin
# or
yo code my-extension

yarn

```
The env running in user level (no root), but You can get root with sudo su. 
- uid: 1000
- gid: 1000

### Publish theia 
```
yarn publish
ovsx create-namespace "publisher" # if it doesn't already exist
ovsx publish
```
https://github.com/open-vsx/publish-extensions


### Publish vscode extension
```
cd extension-dir
vsce package
```
https://code.visualstudio.com/api/working-with-extensions/publishing-extension