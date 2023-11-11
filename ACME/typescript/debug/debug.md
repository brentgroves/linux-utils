https://code.visualstudio.com/docs/typescript/typescript-tutorial#_debugging

Debugging
VS Code has built-in support for TypeScript debugging. To support debugging TypeScript in combination with the executing JavaScript code, VS Code relies on source maps for the debugger to map between the original TypeScript source code and the running JavaScript. You can create source maps during the build by setting "sourceMap": true in your tsconfig.json.

https://code.visualstudio.com/docs/typescript/typescript-debugging

For more advanced debugging scenarios, you can create your own debug configuration launch.json file. To see the default configuration, go to the Run and Debug view (Ctrl+Shift+D) and select the create a launch.json file link.

This will create a launch.json file in a .vscode folder with default values detected in your project.

{
  // Use IntelliSense to learn about possible attributes.
  // Hover to view descriptions of existing attributes.
  // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
  "version": "0.2.0",
  "configurations": [
    {
      "type": "node",
      "request": "launch",
      "name": "Launch Program",
      "program": "${workspaceFolder}/helloworld.ts",
      "preLaunchTask": "tsc: build - tsconfig.json",
      "outFiles": ["${workspaceFolder}/out/**/*.js"]
    }
  ]
}