# C1M2

C1M2: a universal algorithm for 3D instance segmentation, annotation and quantification of irregular cells

Authors: Hao Zheng, Songlin Huang, Jing Zhang, Ren Zhang, Jialu Wang, Jing Yuan, Anan Li, Xin Yang, Zhihong Zhang.

The research paper can be downloaded from [here](http://engine.scichina.com/doi/10.1007/s11427-022-2327-y).



# Content
* Software requirements
* Getting started
* Output files

# Software requirements

The algorithm was implemented in MATLAB (R2022a, The MathWorks, Natick, Massachusetts, USA) using custom-written scripts with dependencies on the Image Processing Toolbox and Statistics and Machine Learning Toolbox.

# Getting started
Add the C1M2 folder to the Matlab path

The protocol of C1M2 can be downloaded from [here](https://www.sciengine.com/cfs/files/files/fs/1659449496276303872).

Example datasets can be downloaded from [here](https://drive.google.com/file/d/14XyqgbmYaDFn46NxkOIlM9CeIktH3awT/view?usp=sharing).

The script of two_channel_f480.m, two_channel_cd11c.m and single_channel_cx3cr1.m for instance segmentation of F4/80<sup>+</sup>, CD11c<sup>+</sup> and Cx3Cr1<sup>+</sup> cells, respectively.

The script of annotate_quantification.m for annotation and quantification.

The script of compute_AP.m for computing the standard average precision metric

# Output files

The instance segmentation results of C1M2 is segment_cells.mat, which containing cell_non, cell_one, cell_multi, and total_cells.

