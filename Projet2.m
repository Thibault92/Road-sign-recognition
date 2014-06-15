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

addpath ([curpath '\Base_formes']);
addpath ([curpath '\Base_panneaux']);


%% Chargement de la base des panneaux type
% stop = imread('stop.png');
% cdpa = imread('cdpa.jpg');

%% Chargement de l'image

% im = imread('CDPAS011.jpg');
% im = imread('DIVER001.jpg');
% im = imread('SINTD004.jpg');
% im = imread('RALT001.jpg');
im = imread('INTD003.jpg');
% im = imread('INTG009.jpg');
% im = imread('LIMV040.jpg');
% im = imread('STATI037.jpg');
% im = imread('STATJ009.jpg');
% im = imread('STOP001.jpg');

im = im2double(im);

% figure, imshow(im),title('Image source');

%% Redimensionnement de l'image

[h,w] = size(im);
img = imresize(im, [200 200]);

[H,W,Canaux] = size(img);
% size(img)
figure, imshow(img), title('Image redimensionnée');

%% Conversion de l'image du RGB vers YCbCR

imgYCbCr = rgb2ycbcr(img);

figure, imshow(imgYCbCr), title('Image domaine YCbCr');

%% Reconnaissance de contours rouges ou bleus

imdetect = zeros(H,W);

Y = imgYCbCr(:,:,1);
Cb = imgYCbCr(:,:,2);
Cr = imgYCbCr(:,:,3);

    % Détection des contours en rouge

imRed = redDetect(img,Y,Cb,Cr);
figure, imshow(imRed);


    % Détection des contours en bleu

% imdetectblue = blueDetect(img,Cb,Cr);
% figure, imshow(imdetectblue);

%% Suppresion des pixels parasites

SE = [0 1 0;1 1 1;0 1 0];
% N = 2; % nombre d'érosions
%
% for i = 1:N
%     imRed = imerode(imRed,SE);
% end
%
% imRed = imdilate(imRed,SE); % On effectue une ouverture par reconstruction
imRed = imopen(imRed,SE);
figure,imshow(imRed);

imRedbin = im2bw(imRed); % conversion en image binaire
% imRedbin = ~imRedbin;

%% Etiqueter l'image x
[imLabel,Etiquettes] = bwlabel(imRedbin);       % N représente le nombre d'étiquettes
disp(sprintf('     -- > %d objets détectés',Etiquettes));


Etiquettes = regionprops(imLabel, 'BoundingBox', 'Area');

for k = 1 : length(Etiquettes)
  objet(k,:) = Etiquettes(k).BoundingBox;
  rectangle('Position', [objet(k,1),objet(k,2),objet(k,3),objet(k,4)],...
  'EdgeColor','r','LineWidth',2 )
end

Aires = [Etiquettes.Area];
[classAire, index] = sort(Aires, 'descend');

index_new = index(find(classAire>10 & classAire<1000));


%% Comparaison avec la base des formes

%    Charger une image référence

cercle = imread('Cercle.bmp');
triangle = imread('Triangle.bmp');
triangle_envers = imread('Triangle_envers.bmp');
carre = imread('Carre.bmp');
oct = imread('Octogone.bmp');

cercle = imresize(cercle, [50 50]);
triangle = imresize(triangle, [50 50]);
triangle_envers = imresize(triangle_envers, [50 50]);
carre = imresize(carre, [50 50]);
oct = imresize(oct, [50 50]);

% cercle = imresize(cercle, [75 75]);
% triangle = imresize(triangle, [75 75]);
% triangle_envers = imresize(triangle_envers, [75 75]);
% carre = imresize(carre, [75 75]);
% oct = imresize(oct, [75 75]);
% figure, imshow(triangle);

%% Template Maching de l'image avec la base des formes

maxi = zeros(1,5);
x = zeros(1,5);
y = zeros(1,5);


imLabel2 = zeros(length(imLabel) + 2);
for i = 1:length(imLabel)
    for j = 1:length(imLabel)
        imLabel2(i+1,j+1) = imLabel(i,j);
    end
end
% figure, imshow(imLabel2);

for j=1:length(index_new)

    j
    ima = imLabel2(floor(objet(index_new(j),2))+1:round(objet(index_new(j),4)+objet(index_new(j),2))+1,floor(objet(index_new(j),1))+1:round(objet(index_new(j),3)+objet(index_new(j),1))+1);
%     ima = imresize(ima, [60 60]);
    ima = imresize(ima, 2);
    figure, imshow(ima);
    
[corr_cerc, maxi(1,1), x(1,1), y(1,1)] = templateMatch(ima, cercle);
[corr_tri, maxi(1,2), x(1,2), y(1,2)] = templateMatch(ima, triangle);
[corr_trienvers, maxi(1,3), x(1,3), y(1,3)] = templateMatch(ima, triangle_envers);
[corr_carre, maxi(1,4), x(1,4), y(1,4)] = templateMatch(ima, carre);
[corr_oct, maxi(1,5), x(1,5), y(1,5)] = templateMatch(ima, oct);


% figure, imshow(corr_cercp);
% figure, imshow(corr_cerc); title('Matching cercle');
% figure, imshow(corr_tri); title('Matching triangle');
% figure, imshow(corr_trienvers); title('Matching triangle envers');
% figure, imshow(corr_carre);title('Matching carre');
% figure, imshow(corr_oct); title('Matching octogone');

position = find(maxi==max(maxi));
if position == 1
    disp('Il s''agit d''un cercle');
    elseif position == 2
    disp('Il s''agit d''un triangle');
    elseif position == 3
    disp('Il s''agit d''un triangle à l''envers : c''est un panneau cédez le passage !!');
%     figure, imshow(cdpa);
    elseif position == 4
    disp('Il s''agit d''un carré');
    elseif position == 5
    disp('Il s''agit d''un octogone : c''est un panneau stop !!');
%     figure, imshow(stop);
end
end


% for i = 1:length(seg)
% 
% [corr_cerc, maxi(1,1), x(1,1), y(1,1)] = templateMatch(imRedbin, cercle);
% [corr_tri, maxi(1,2), x(1,2), y(1,2)] = templateMatch(imRedbin, triangle);
% [corr_trienvers, maxi(1,3), x(1,3), y(1,3)] = templateMatch(imRedbin, triangle_envers);
% [corr_carre, maxi(1,4), x(1,4), y(1,4)] = templateMatch(imRedbin, carre);
% [corr_oct, maxi(1,5), x(1,5), y(1,5)] = templateMatch(imRedbin, oct);
% 
% 
% % figure, imshow(corr_cercp);
% figure, imshow(corr_cerc); title('Matching cercle');
% figure, imshow(corr_tri); title('Matching triangle');
% figure, imshow(corr_trienvers); title('Matching tringle envers');
% figure, imshow(corr_carre);title('Matching carre');
% figure, imshow(corr_oct); title('Matching octogone');
% 
% position = find(maxi==max(maxi));
% if position == 1
%     disp('Il s''agit d''un cercle');
%     elseif position == 2
%     disp('Il s''agit d''un triangle');
%     elseif position == 3
%     disp('Il s''agit d''un triangle à l''envers : c''est un panneau cédez le passage !!');
% %     figure, imshow(cdpa);
%     elseif position == 4
%     disp('Il s''agit d''un carré');
%     elseif position == 5
%     disp('Il s''agit d''un octogone : c''est un panneau stop !!');
% %     figure, imshow(stop);
% end
% end


% [labels, nbLabels] = bwlabel(bw);   % étiquetage des régions à l'aide de la fonction bwlabel
% figure, imshow(bw); % affichage image binaire
% region_extrait = regionprops(labels,'BoundingBox'); % fonction regionprops pour extraire les régions
 
% %% Méthode 1
% for i=1:nbLabels
%     coupe = imcrop(labels,region_extrait(i).BoundingBox);
%     figure, imshow(coupe);
% end

% x = imdetectred;
% for i = 2:H-1
%     for j = 2:W-1
%         if x(i-1,j-1) == 1 && x(i,j) == 1 && x(i+1,j+1) == 1 && x(i-1,j) == 0 ...
%                && x(i-1,j+1) == 0 && x(i,j-1) == 0 && x(i,j+1) == 0 ...
%               && x(i+1,j-1) == 0 && x(i-1,j) == 0
%             x(i,j) = 1;
%             
%         elseif x(i-1,j-1) == 1 && x(i,j) == 1 && x(i+1,j+1) == 0 && x(i-1,j) == 0 ...
%                && x(i-1,j+1) == 0 && x(i,j-1) == 0 && x(i,j+1) == 0 ...
%               && x(i+1,j-1) == 1 && x(i-1,j) == 0
%             x(i,j) = 1;
%         elseif x(i-1,j-1) == 0 && x(i,j) == 1 && x(i+1,j+1) == 0 && x(i-1,j) == 0 ...
%                && x(i-1,j+1) == 0 && x(i,j-1) == 1 && x(i,j+1) == 1 ...
%               && x(i+1,j-1) == 0 && x(i-1,j) == 0
%             x(i,j) = 1;
%         elseif x(i-1,j-1) == 0 && x(i,j) == 1 && x(i+1,j+1) == 1 && x(i-1,j) == 0 ...
%                && x(i-1,j+1) == 0 && x(i,j-1) == 0 && x(i,j+1) == 0 ...
%               && x(i+1,j-1) == 1 && x(i-1,j) == 0
%             x(i,j) = 1;
%         elseif x(i-1,j-1) == 0 && x(i,j) == 1 && x(i+1,j+1) == 0 && x(i-1,j) == 0 ...
%                && x(i-1,j+1) == 1 && x(i,j-1) == 0 && x(i,j+1) == 0 ...
%               && x(i+1,j-1) == 1 && x(i-1,j) == 0
%             x(i,j) = 1;
%         elseif x(i-1,j-1) == 0 && x(i,j) == 1 && x(i+1,j+1) == 1 && x(i-1,j) == 0 ...
%                && x(i-1,j+1) == 0 && x(i,j-1) == 0 && x(i,j+1) == 0 ...
%               && x(i+1,j-1) == 1 && x(i-1,j) == 0
%             x(i,j) = 1;
%         else x(i,j) = 0;
%         end
%         
%     end
% end
% figure, imshow(x);

%% Comparaison avec la base des formes

% %% Charger une image référence
% ref = imread('8.tif','tif');
% % ref = 0.7*imread('8.tif','tif');
% % ref = imread('8n.tif','tif');
% % ref = imread('8b.tif','tif');
% [H1,W1] = size(ref);
% figure,imshow(ref), title('Image de référence (8)');
% 
% % position du centre de l'image
% x0 = round(H1/2);
% y0 = round(W1/2);
% 
% %% Effectuer la corrélation sur toute l'image testée
% % et créer une image de corrélation 
% rescorr = zeros(H,W);
% for i=1:H-H1
%    for j=1:W-W1
%       c = corr2(ref,im(i:i+H1-1, j:j+W1-1));     
%       rescorr(i,j) = c;         
%    end;
% end;


% Comparaison avec la fonction imshowpair (marche avec Matlab 2013)
