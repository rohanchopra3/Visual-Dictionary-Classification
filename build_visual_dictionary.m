function [vocab] = build_visual_dictionary(training_image_cell, dict_size)
    
    N = size(training_image_cell,2);
    features = [];
    stepSize = 10;
    for i = 1:N
        [~,f] = vl_dsift(im2single(training_image_cell{i}),'step', stepSize, 'size' ,8,'fast');
        features = [features f]; 
    end
    features = double(features');
    [~,c ] = kmeans(features, dict_size);
    vocab = c';
end