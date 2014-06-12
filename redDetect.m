function imdetect = redDetect(img,Y,Cb,Cr)

[H,W,Canaux] = size(img);
imdetect = zeros([H,W]);

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

% Cb = imgYCbCr(:,1,:);
% Cr = imgYCbCr;


for i = 1:H
    for j = 1:W
        if  Cb(i,j) > 0.4 && Cb(i,j) < 0.6 ...
            && Cr(i,j) > 0.5 && Cr(i,j) < 0.8 && Y(i,j) < 0.8
            
%         if  imgYCbCr(i,j,2)/imgYCbCr(i,j,3) > 0.6 && imgYCbCr(i,j,2)/imgYCbCr(i,j,3) < 0.9 ...
%             && imgYCbCr(i,j,3)/imgYCbCr(i,j,2) > 1.1 && imgYCbCr(i,j,3)/imgYCbCr(i,j,2) < 1.5

%         if  imgYCbCr(i,j,3)/imgYCbCr(i,j,1) > 1.6 && imgYCbCr(i,j,3)/imgYCbCr(i,j,1) < 2.2 ...
%             || imgYCbCr(i,j,2)/imgYCbCr(i,j,1) > 1.8 && imgYCbCr(i,j,2)/imgYCbCr(i,j,1) < 3

            imdetect(i,j,:) = 1;
            
        else imdetect(i,j,:) = 0;
        end
    end
end
end
