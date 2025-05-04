close all;
clc
clear all;

location1 = 'C:\Users\Iftakar Inqalabi\Desktop\work\fyp\unet_testing_results\*.png';
ds1 = imageDatastore(location1)  

location2 = 'C:\Users\Iftakar Inqalabi\Desktop\work\fyp\thin_vessel_result_testing\*.jpg'
ds2 = imageDatastore(location2) 

location3 = 'C:\Users\Iftakar Inqalabi\Desktop\work\fyp\DRIVE_Dataset + Code\test\mask\*.gif';
ds3 = imageDatastore(location3) 

destdirectory = 'C:\Users\Iftakar Inqalabi\Desktop\work\fyp\thin_vessel_not_Present_in_unet';
mkdir(destdirectory);   %create the directory
A1 = 1;


while hasdata(ds1)
   img1 = read(ds1) ;
   img2 = read(ds2) ;
   img3 = read(ds3) ;
   
%    img1 = imread('01_test.png');
%    img2 = imread('picture1.jpg');
%    img3 = imread('01_manual1.gif');

   non_detected_vessels = (img3 &~ img1);
   A = (non_detected_vessels & img2);
   minlength = 20;
   A = bwareaopen(A,minlength,8);
  
   b1 = 'picture%d%s';
   A2 = ".jpg";
   
   str = sprintf(b1,A1,A2);
   
   
   fulldestination = fullfile(destdirectory, str);  
   imwrite(A , fulldestination);
   
   
   A1=A1+1;
   
end
