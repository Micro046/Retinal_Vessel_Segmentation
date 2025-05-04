close all;
clc;
clear all;
location = 'C:\Users\Iftakar Inqalabi\Desktop\Work\fyp\DRIVE_Dataset + Code\test\mask - Copy\*.gif';
ds = imageDatastore(location)  

destdirectory = 'C:\Users\Iftakar Inqalabi\Desktop\testing1';
mkdir(destdirectory);   %create the directory
A1 = 1;

while hasdata(ds)
   
    img = read(ds) ;             % read image from datastore
    edtImage = 2 * bwdist(~img);
    skeletonImage = bwmorph(img, 'skel', inf);
    diameterImage = edtImage .* double(skeletonImage);
   
    [m,n] = size(diameterImage);
    pixels = 4;

    for c = 1:m
        for r = 1:n
            if diameterImage(c,r) > pixels
                diameterImage(c,r) = 0;
            end
        end
    end

    vesselMask = bwmorph(diameterImage, 'spur' , 5);

    minlength = 25;
    vesselSegs = bwareaopen(vesselMask,minlength,8);
   
    branchpoints = bwmorph(skeletonImage,'branch',1);
    branchpoints = imdilate(branchpoints,strel('disk',6));
    vesselMask1 = img &~ branchpoints;
 
   
    branchpoints = bwmorph(skeletonImage,'branch',1);
    branchpoints = imdilate(branchpoints,strel('disk',4));
    vesselMask2 = skeletonImage &~ branchpoints;
   
    branchpoints1 = bwmorph(vesselSegs,'branch',1);
    branchpoints1 = imdilate(branchpoints1,strel('disk',8));
    vesselMask4 = vesselSegs &~ branchpoints1;
 
    vesselMask4 = imdilate(vesselMask4,strel('disk',4));
    vesselMask3 = vesselMask1 & vesselMask4;
   
    vesselSegs5 = img & branchpoints1;
    vesselSegs2 = vesselMask3 | vesselSegs5;
    
    vesselSegs2 = img &~ vesselSegs2;
    
    minlength = 25;
    vesselSegs2 = bwareaopen(vesselSegs2,minlength,8);
   
    vesselSegs3 = img &~ vesselSegs2;
    
    vesselSegs2 = vesselSegs2 | vesselSegs3;
    
    b1 = 'picture%d%s';
    A2 = ".jpg";
    str = sprintf(b1,A1,A2);
    fulldestination = fullfile(destdirectory, str);  
    imwrite(vesselSegs2, fulldestination);
    A1=A1+1;
   
end
