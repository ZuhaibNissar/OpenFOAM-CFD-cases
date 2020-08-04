#!/bin/bash

foamCleanTutorials
blockMesh | tee log.blockMesh
surfaceFeatureExtract | tee log.surfaceFeatureExtract
snappyHexMesh -overwrite | tee log.shm
checkMesh | tee log.checkMesh
rm -rf 0
cp -r 0_org 0
setFields | tee log.setFields
createPatch -dict system/createPatchDict.0 -overwrite
createPatch -dict system/createPatchDict.1 -overwrite
decomposePar
mpirun -np 4 renumberMesh -overwrite -parallel 
mpirun -np 4 interFoam -parallel | tee log.solver