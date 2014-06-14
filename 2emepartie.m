
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

addpath ([curpath '\Base_formes']);
addpath ([curpath '\Base_panneaux']);

img = imread('IMP.jpg');
figure, imshow(img);

img = rgb2gray(img);
img = im2double(img);
figure, imshow(img);

[H,W] = size(img);

h = fspecial('sobel');
% h = fspecial('prewitt');

% Dérivée par rapport à x - détection verticale

imy = imfilter(img,h);

% Dérivée par rapport à y - détection horizontale

imx = imfilter(img,h');

% module
im = sqrt(imx.^2+imy.^2);
im = imadjust(im);   % Calibration

figure,subplot(2,2,1),subimage(img);title('Image source');
subplot(2,2,2),subimage(cal(imy)),title('Gradient vertical');
subplot(2,2,3), subimage(cal(imx)),title('Gradient horizontal');
subplot(2,2,4),subimage(im); title('Image module');


imContour = im2bw(im);
imContour = ~imContour;
figure, imshow(imContour);


