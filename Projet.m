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

Cb = imgYCbCr;
Cr = imgYCbCr;

% Détection des contours en rouge

% imdetectred = redDetect(img,Cb,Cr);
% figure, imshow(imdetectred);

% Détection des contours en bleu

imdetectblue = blueDetect(img,Cb,Cr);
figure, imshow(imdetectblue);

%% Extraction des premières formes détectées

%Suppresion des pixels parasites
SE = [0 1 0;1 1 1;0 1 0];
% SE = [0 1 1 1 0; 1 1 1 1 1; 0 1 1 1 0];
N = 3;

for i = 1:N
    imdetectred = imerode(imdetectred,SE);
end
figure,imshow(imdetectred);

imres = zeros(H,W);
bw = im2bw(imdetectred); % conversion en image binaire

%% Comparaison avec la base des formes

%% Charger une image référence
ref = imread('Tri.bmp');
% imref = rgb2gray(ref);
[H1,W1] = size(ref);
figure,imshow(ref);

% position du centre de l'image
x0 = round(H1/2);
y0 = round(W1/2);

%% Effectuer la corrélation sur toute l'image testée
% et créer une image de corrélation 
rescorr = zeros(H,W);
for i=1:H-H1
   for j=1:W-W1
      c = corr2(ref,imdetectred(i:i+H1-1, j:j+W1-1));     
      rescorr(i,j) = c;         
   end;
end;

figure, imshow(rescorr);


%% Comparaison avec la base des formes

% a = imread('image1.jpg'); 
%     b = imread('image2.jpg'); 
%     c = corr2(a,b);           %Trouve la corrélation entre deux images 
%     if c==1 

%     end; 

% Comparaison avec la fonction imshowpair (marche avec Matlab 2013)
