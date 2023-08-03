# Nintendont-docker

A docker container with all the dependencies required to build Nintendont

Useful for both CI and local building



## Local Compiling Example

Go to the root of the Nintendont repo and run this, and you should get a new loader.dol at the end.

```
docker run --rm  -v ${PWD}:/nintendont ghcr.io/ddrboxman/nintendont-docker:latest bash -c "cd /nintendont && make -j2"
```

## Github Action Example

`.github/workflows/main.yml`

```
name: Nintendont Build

on: [push]

jobs:
  build:
    name: Build Nintendont
    runs-on: ubuntu-22.04
    container: ghcr.io/ddrboxman/nintendont-docker:latest

    steps:
    - uses: actions/checkout@v2

    - name: Build Nintendont dol
      run: |
        make -j2
    - name: Copy Nintendont artifacts
      run: | 
        mkdir -p dist/Nintendont/apps/Nintendont
        cp nintendont/icon.png dist/Nintendont/apps/Nintendont/
        cp nintendont/meta.xml dist/Nintendont/apps/Nintendont/
        cp loader/loader.dol dist/Nintendont/apps/Nintendont/boot.dol
    - name: Upload Nintendont artifacts
      uses: actions/upload-artifact@v2
      with: 
        name: Nintendont
        path: |
         dist/Nintendont/
``
