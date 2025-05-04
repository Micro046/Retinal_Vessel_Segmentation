close all;
clc;
clear all;
location = 'C:\Users\Iftakar Inqalabi\Desktop\Work\fyp\results\UNET 2nd Results\*.png';
ds = imageDatastore(location)  

location1 = 'C:\Users\Iftakar Inqalabi\Desktop\Work\fyp\results\Thin_Vessels_reesults\*.png'
ds1 = imageDatastore(location1)

location3 = 'C:\Users\Iftakar Inqalabi\Desktop\Work\fyp\DRIVE_Dataset + Code\test\mask\*.gif'
ds2 = imageDatastore(location3)

location4 = 'C:\Users\Iftakar Inqalabi\Desktop\Work\fyp\results\Skeleton_Image_Result\*.png'
ds3 = imageDatastore(location4)

destdirectory = 'C:\Users\Iftakar Inqalabi\Desktop\Results';
mkdir(destdirectory);   %create the directory
A1 = 1;

while hasdata(ds)
    A = read(ds) ;  
    %A = imread('02_test.png');
    redChannel1 = A(:, :, 1);
    x1 = imcrop(redChannel1,[1045 1 1556 512]);
    %B = imread('22.png');
    B = read(ds1);
    redChannel2 = B(:, :, 1);
    x2 = imcrop(redChannel2,[1045 1 1556 512]);
    %C =imread('02_manual1.gif');
    C = read(ds2);
    %D =imread('skeleton_Image.png');
    D = read(ds3);
    redChannel3 = D(:, :, 1);
    x3 = imcrop(redChannel3,[1045 1 1556 512]);
    x = zeros(512);
    x4 = zeros(512);

    for c = 1:512
        for r = 1:512
            if (x2(c,r) == 255) & (x1(c,r) == 0)
                x(c,r) = x2(c,r);
            end
            if (x2(c,r) == 0) & (x1(c,r) == 255)
             x(c,r) = x1(c,r);
            end
            if (x2(c,r) == 255) & (x1(c,r) == 255)
             x(c,r) = 255;
            end
            if (x2(c,r) == 0) & (x1(c,r) == 0)
             x(c,r) = 0;
            end
        end
    end

    for c = 1:512
        for r = 1:512
            if (x(c,r) == 255) & (x3(c,r) == 0)
             x4(c,r) = x(c,r);
            end
            if (x(c,r) == 0) & (x3(c,r) == 255)
                x4(c,r) = x3(c,r);
            end
            if (x(c,r) == 255) & (x3(c,r) == 255)
                x4(c,r) = 255;
            end
            if (x(c,r) == 0) & (x3(c,r) == 0)
                x4(c,r) = 0;
            end
        end
    end
    
    b1 = 'picture%d%s';
    A2 = ".jpg";
    str = sprintf(b1,A1,A2);
    fulldestination = fullfile(destdirectory, str);  
    imwrite(x4, fulldestination);
    A1=A1+1;
end