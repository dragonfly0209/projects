function [h, array] = display_network(A, opt_normalize, opt_gratcolor, cols, opt_colmajor)

warning off all

if ~exist('opt_normalize', 'var') || isempty(opt_normalize)
    opt_normalize = true;
end

if ~exist('opt_gratcolor', 'var') || isempty(opt_gratcolor)
    opt_gratcolor = true;
end

if ~exist('opt_colmajor', 'var') || isempty(opt_colmajor)
    opt_colmajor = false;
end

A = A - mean(A(:));

if opt_gratcolor,colormap(gray); end

[L M] =size(A);
sz = sqrt(L);
buf = 1;
if ~exist('cols','var')
    if floor(sqrt(M))^2 ~= M;
        n = ceil(sqrt(M));
        while mod(M,n) ~= 0 && n < 1.2*sqrt(M), n = n+1; end
        m = ceil(M/n);
        
    else
        n = sqrt(M);
        m=n;
    end
else
    n = cols;
    m = ceil(M/n);
end
array = -ones(buf+m*(sz+buf),buf+n*(sz+buf));

if ~opt_gratcolor
    array = 0.1.* array;
end

if ~opt_colmajor
    k=1;
    for i=1:m
        for j=1:n
            if k>M,
                continue;
            end
            clim = max(abs(A(:,k)));
            if opt_normalize
                array(buf+(i-1)*(sz+buf)+(1:sz),buf+(j-1)*(sz+buf)+(1:sz)) = reshape(A(:,k),sz,sz)/clim;
            else
                array(buf+(i-1)*(sz+buf)+(1:sz),buf+(j-1)*(sz+buf)+(1:sz)) = reshape(A(:,k),sz,sz)/max(abs(A(:)));
            end
            k=k+1;
        end
        
    end
    
else
    k=1;
    for j=1:n
        for i =1:m
            if k>M,
                continue;
            end
            clim = max(abs(A(:,k)));
            if opt_normalize
                array(buf+(i-1)*(sz+buf)+(1:sz),buf+(j-1)*(sz+buf)+(1:sz)) = reshape(A(:,k),sz,sz)/clim;
            else
                array(buf+(i-1)*(sz+buf)+(1:sz),buf+(j-1)*(sz+buf)+(1:sz)) = reshape(A(:,k),sz,sz);
            end    
            k = k+1;
        end
    end
end
if opt_gratcolor
    h = imagesc(array,'EraseMode','none',[-1 1]);
else
    h = imagesc(array,'EraseMode','none',[-1 1]);
end
axis image off
drawnow;
warning on all