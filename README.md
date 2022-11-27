# C1M2

C1M2: a universal algorithm for 3D instance segmentation, annotation and quantification of irregular cells

Authors: Hao Zheng, Songlin Huang, Jing Zhang, Ren Zhang, Jialu Wang, Jing Yuan, Anan Li, Xin Yang, Qingming Luo & Zhihong Zhang.


# Content
* software requirements
* Getting started
* Output files

software requirements

The algorithm was implemented in MATLAB (R2022a, The MathWorks, Natick, Massachusetts, USA) using custom-written scripts with dependencies on the Image Processing Toolbox and Statistics and Machine Learning Toolbox.

# Getting started
Add the C1M2 folder to the Matlab path

There are three scripts for F4/80, CD11c and CX3CR1, respectively.

# Output files

The instance segmentation results of C1M2 is segment_cells.mat, which containing cell_non, cell_one, cell_multi, and total_cells.

