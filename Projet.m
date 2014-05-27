%% ---------- Projet TNI: Reconnaissance de panneaux routiers -------
%BERGER Thibault/DIGONNET William

clear all;
close all;
clc

%% Inclusion du chemin des images

curpath = cd;
addpath ([curpath '\Images']);
addpath ([curpath '\Images\CDPA']);
addpath ([curpath '\Images\DIVER']);
addpath ([curpath '\Images\INTD']);
addpath ([curpath '\Images\INTG']);
addpath ([curpath '\Images\LIMV']);
addpath ([curpath '\Images\RALT']);
addpath ([curpath '\Images\SINTD']);
addpath ([curpath '\Images\STATI']);
addpath ([curpath '\Images\STATJ']);
addpath ([curpath '\Images\STOP']);

%% Chargement de l'image

% im = imread('CDPAS011.jpg');
im = imread('DIVER001.jpg');
% im = imread('SINTD025.jpg');
% im = imread('RALT019.jpg');
% im = imread('INTD004.jpg');
% im = imread('INTG009.jpg');
% im = imread('LIMV040.jpg');
% im = imread('STATI037.jpg');
% im = imread('STATJ009.jpg');
% im = imread('STOP024.jpg');

im = im2double(im);

% figure, imshow(im),title('Image source');

%% Redimensionnement de l'image

[h,w] = size(im);
img = imresize(im, [400 400]);

[H,W,Canaux] = size(img);
% size(img)
figure, imshow(img), title('Image redimensionnée');

%% Conversion de l'image du RGB vers YCbCR

imgYCbCr = rgb2ycbcr(img);

figure, imshow(imgYCbCr), title('Image domaine YCbCr');

%% Reconnaissance de contours rouges ou bleus

imdetect = zeros(H,W);

% Détection des contours en RGB

% for i = 1:H
%     for j = 1:W
% %         if img(i,j,1) < 0.5 && img(i,j,2) < 0.1 && img(i,j,3) < 0.1
%         if  img(i,j,1)/img(i,j,2) > 1.25 && img(i,j,1)/img(i,j,3) > 1.4 ...
%                 || img(i,j,3)/img(i,j,1) > 1.2 && img(i,j,3)/img(i,j,2) > 1.2
%             imdetect(i,j,:) = 1;
%         else imdetect(i,j,:) = 0;
%         end
%     end
% end

% Détection des contours en YCbCr (prend en compte la luminance et deux caractéristiques de chrominance)

for i = 1:H
    for j = 1:W
        if  imgYCbCr(i,j,2) > 0.4 && imgYCbCr(i,j,2) < 0.6 ...
            && imgYCbCr(i,j,3) > 0.5 && imgYCbCr(i,j,3) < 0.8
            
%         if  imgYCbCr(i,j,2)/imgYCbCr(i,j,3) > 0.6 && imgYCbCr(i,j,2)/imgYCbCr(i,j,3) < 0.9 ...
%             && imgYCbCr(i,j,3)/imgYCbCr(i,j,2) > 1.1 && imgYCbCr(i,j,3)/imgYCbCr(i,j,2) < 1.5

%         if  imgYCbCr(i,j,3)/imgYCbCr(i,j,1) > 1.6 && imgYCbCr(i,j,3)/imgYCbCr(i,j,1) < 2.2 ...
%             || imgYCbCr(i,j,2)/imgYCbCr(i,j,1) > 1.8 && imgYCbCr(i,j,2)/imgYCbCr(i,j,1) < 3

            imdetect(i,j,:) = 1;
            
        else imdetect(i,j,:) = 0;
        end
    end
end

figure, imshow(imdetect);

%% Extraction des premières formes détectées


%% Comparaison avec la base des formes

% a = imread('image1.jpg'); 
%     b = imread('image2.jpg'); 
%     c = corr2(a,b);           %Trouve la corrélation entre deux images 
%     if c==1 

%     end; 

% Comparaison avec la fonction imshowpair (marche avec Matlab 2013)
