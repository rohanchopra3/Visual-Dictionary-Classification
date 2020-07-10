function [feature] = get_tiny_image(I, output_size)
    
    [o_h , o_w] = size(I);
    new_image = zeros(output_size(1),output_size(2));
    
    scale_h = floor(o_h/output_size(1));
    scale_w = floor(o_w/output_size(2));
    
    for i =1:output_size(2)
       for j = 1:output_size(1)
            new_image(j,i)= I(scale_h*j,scale_w*i);
       end
    end
    min1=min(min(new_image));
    max1=max(max(new_image));
    n = uint8(255 .* ((double(new_image)-double(min1))) ./ double(max1-min1));
    feature = n(:);
end