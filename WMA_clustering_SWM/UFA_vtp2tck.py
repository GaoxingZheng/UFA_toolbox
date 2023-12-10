#!/usr/bin/env python

import vtk
from vtk.util import numpy_support
import nibabel

import argparse
import glob
import numpy as np
import os

def convert(input, output, force=True, only_points=True):

  # print('Converting', len(input), 'files.')

    file_i = input

    if not os.path.exists(file_i):
      print('ERROR', 'Could not find file:', file_i)
      return

    # print('Converting', file_i)

    input_basename = os.path.basename(file_i)

    if input_basename.endswith('vtp'):

      r = vtk.vtkXMLPolyDataReader()
      r.SetFileName(file_i)
      r.Update()
      polydata = r.GetOutput()

    elif input_basename.endswith('vtk'):

      r = vtk.vtkPolyDataReader()
      r.SetFileName(file_i)
      r.Update()
      polydata = r.GetOutput()


    points = numpy_support.vtk_to_numpy(polydata.GetPoints().GetData())
    lines = numpy_support.vtk_to_numpy(polydata.GetLines().GetData())
    number_of_streamlines = polydata.GetLines().GetNumberOfCells()

    # if (number_of_streamlines == 0):

    #   print('ERROR', 'No streamlines in file:', file_i)
    #   continue
        
    #
    # convert to streamlines
    #
    streamlines = []
    i = 0
    current_fiber_id = 0
    line_length = 0
    if len(lines) > 0:
      line_length = lines[i]
    line_index = 0

    while (line_index<number_of_streamlines):
    #     print(line_index,'start',i+1,'len',line_length)
        
        current_line = lines[i+1+line_index:i+1+line_length+line_index]
        current_points = np.zeros((line_length, 3), dtype=np.float32)
      
        for p_i, p in enumerate(current_line):
            current_points[p_i] = points[p]
        
        
        streamlines.append(current_points)


        i += line_length
        line_index += 1
        if line_index < number_of_streamlines:
            line_length = lines[i+line_index]
            
            
    # #
    # # create header
    # #
    # hdr = {'vox_to_ras':np.eye(4), 
    #        'voxel_size':np.ones(3), 
    #        'dim':np.array([256,256,256]),
    #        'scalar_name':scalar_names,
    #        'property_name':property_names}

    tractogram = nibabel.streamlines.tractogram.Tractogram(streamlines,affine_to_rasmm=np.eye(4))
    tck = nibabel.streamlines.tck.TckFile(tractogram)


    with open(output, 'wb') as f:
        # nibabel.trackvis.write(f, streamlines, hdr)
        tck.save(f)

    # print('Written', output)


all_files = os.listdir(os.getcwd())

for vtpfile in all_files:
	# print(vtpfile)
	if vtpfile.split('.')[-1] in ['vtp']:
	    vtp_format = vtpfile.split('.')[0]+'.vtp'
	    tck_format = vtpfile.split('.')[0]+'.tck'
	    # print(vtp_format)
	    # print(tck_format)
	    convert(vtp_format,tck_format)
	    
