clear all;
close all;
clc;

curpath = cd;
addpath ([curpath '\Base_panneaux']);


%% Chargement de la base des panneaux type
stop = imread('STOP.jpg');
cdpa = imread('CDPA.jpg');
sint = imread('SINT.jpg');
ralt = imread('RALT.jpg');
limv30 = imread('LIMV30.jpg');
limv50 = imread('LIMV50.jpg');
% limv60 = imread('LIMV60.jpg');
% limv70 = imread('LIMV70.jpg');
stati = imread('STATI.jpg');
statj = imread('STATIJ.jpg');
imp = imread('IMP.jpg');
intd = imread('INTD.jpg');
intg = imread('INTG.jpg');


stop = imresize(stop, [50 50]);
cdpa = imresize(cdpa, [50 50]);
sint = imresize(sint, [50 50]);
ralt = imresize(ralt, [50 50]);
limv30 = imresize(limv30, [50 50]);
limv50 = imresize(limv50, [50 50]);
% limv70 = imresize(limv70, [50 50]);
% limv60 = imresize(limv60, [50 50]);
stati = imresize(stati, [50 50]);
statj = imresize(statj, [50 50]);
intg = imresize(intg, [50 50]);
intd = imresize(intd, [50 50]);
imp = imresize(imp, [50 50]);

% stop = rgb2gray(stop);
% cdpa = rgb2gray(cdpa);
% sint = rgb2gray(sint);
% ralt = rgb2gray(ralt);
% limv30 = rgb2gray(limv30);
% limv50 = rgb2gray(limv50);
% limv60 = rgb2gray(limv60);
% limv70 = rgb2gray(limv70);
% stati = rgb2gray(stati);
% statj = rgb2gray(statj);
% imp = rgb2gray(imp);

figure, imshow(stop);
figure, imshow(cdpa);
figure, imshow(sint);
figure, imshow(ralt);
figure, imshow(limv30);
figure, imshow(limv50);
% figure, imshow(limv60);
% figure, imshow(limv70);
figure, imshow(stati);
figure, imshow(statj);
figure, imshow(imp);

H = 50;
W = 50;

imStop = redBase(stop,stop(:,:,1));
figure, imshow(imStop);

imCdpa = redBase(cdpa,cdpa(:,:,1));
figure, imshow(imCdpa);

imSint = redBase(sint,sint(:,:,1));
figure, imshow(imSint);

imRalt = redBase(ralt,ralt(:,:,1));
figure, imshow(imRalt);

imLimv30 = redBase(limv30,limv30(:,:,1));
figure, imshow(imLimv30);

imLimv50 = redBase(limv50,limv50(:,:,1));
figure, imshow(imLimv50);

% imLimv60 = redBase(limv60,limv60(:,:,1));
% figure, imshow(imLimv60);

% imLimv70 = redBase(limv70,limv70(:,:,1));
% figure, imshow(imLimv70);

imIntd = redBase(intd,intd(:,:,1));
figure, imshow(imIntd);

imIntg = redBase(intg,intg(:,:,1));
figure, imshow(imIntg);

imStati = redBase(stati,stati(:,:,1));
figure, imshow(imStati);

imStatj = redBase(statj,statj(:,:,1));
figure, imshow(imStatj);

[imStopLab,EtiqStop, AireStop, indexStop] = etiquette(imStop);
[imCdpaLab,EtiqCdpa, AireCdpa, indexCdpa] = etiquette(imCdpa);
[imSintLab,EtiqSint, AireSint, indexSint] = etiquette(imSint);
[imRaltLab,EtiqRalt, AireRalt, indexRalt] = etiquette(imRalt);
[imlimv30Lab,Etiqlimv30, Airelimv30, indexlimv30] = etiquette(imLimv30);
[imlimv50Lab,Etiqlimv50, Airelimv50, indexlimv50] = etiquette(imLimv50);
% [imlimv60Lab,Etiqlimv60, Airelimv60, indexlimv60] = etiquette(imLimv60);
% [imlimv70Lab,Etiqlimv70, Airelimv70, indexlimv70] = etiquette(imLimv70);
[imIntdLab,EtiqIntd, AireIntd, indexIntd] = etiquette(imIntd);
[imIntgLab,EtiqIntg, AireIntg, indexIntg] = etiquette(imIntg);
[imStatiLab,EtiqStati, AireStati, indexStati] = etiquette(imStati);
[imStatjLab,EtiqStatj, AireStatj, indexStatj] = etiquette(imStatj);

Src = H * W;


aire (1,:) = Src - 4 * AireStop(1);
aire (2,:) = Src - AireCdpa(1);
aire (3,:) = Src - AireSint(1);
aire (4,:) = Src - AireRalt(1);
aire (5,:) = Src - Airelimv30(1);
aire (6,:) = Src - Airelimv50(1);
% aire (7,:) = Src - Airelimv70(1);
aire (7,:) = Src - AireIntd(1);
aire (8,:) = Src - AireIntg(1);
aire (9,:) = Src - AireStati(1);
aire (10,:) = Src - AireStatj(1);

aire(11,:) = AireStop(5) + AireStop(6) + AireStop(7) + AireStop(8)
aire(12,:) = AireCdpa(2);
aire(13,:) = AireSint(2);
aire(14,:) = AireRalt(2);
aire(15,:) = Airelimv30(2) + Airelimv30(3);
aire(16,:) = Airelimv50(2) + Airelimv50(3);
aire(17,:) = AireIntd(2) + AireIntd(3) + AireIntd(4);
aire(18,:) = AireIntg(2) + AireIntg(3);
aire(19,:) = 0;
aire(20,:) = 0;



