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

im = imread('CDPAS007.jpg');
% im = imread('DIVER014.jpg');
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

% Détection des contours en rouge

imdetectred = redDetect(img,imgYCbCr,imgYCbCr);

figure, imshow(imdetectred);

%% Extraction des premières formes détectées


%% Comparaison avec la base des formes

% a = imread('image1.jpg'); 
%     b = imread('image2.jpg'); 
%     c = corr2(a,b);           %Trouve la corrélation entre deux images 
%     if c==1 

%     end; 

% Comparaison avec la fonction imshowpair (marche avec Matlab 2013)
