function imdetect = blueDetect(img,Cb,Cr)

[H,W,Canaux] = size(img);

for i = 1:H
    for j = 1:W
        if  Cb(i,j,2) > 0.55 && Cb(i,j,2) < 0.7 ...
            && Cr(i,j,3) > 0.25 && Cr(i,j,3) < 0.6
            
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
