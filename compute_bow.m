function [bow_feature] = compute_bow(feature, vocab)
    
    H = zeros(1,size(vocab,2));
    for i = 1:size(feature,2)
        d = inf;
        for j = 1:size(vocab,2)
            dist = sqrt(sum((double(feature(:,i))-double(vocab(:,j))).^2));
%             dist = sum(abs(double(feature(:,i))-double(vocab(:,j))));
            if d > dist
               ind = j;
               d = dist;
            end
        end
       H(ind) = H(ind)+1; 
    end
    bow_feature  = H ./ norm(H);
end