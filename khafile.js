let project = new Project('Bun Snap');

project.addSources('Sources');
project.addShaders('Shaders/**');

project.addLibrary('glm');
project.addLibrary('gltf');
project.addLibrary('headbutt');
project.addLibrary('thx.core');
project.addLibrary('edge');

project.addAssets('Assets/**');

// TODO: disable -debug, enable -dce full for release
project.addParameter('-debug');
//project.addParameter('-dce full');

// HTML target
project.windowOptions.width = 640;
project.windowOptions.height = 480;

resolve(project);
