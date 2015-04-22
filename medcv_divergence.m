function [distance] = divergence(set_1, set_2, method)
	% Determine the Bregman diveregence specified in the string "method" to difference the two distributions
	if nargin < 3
		method = 'cdf'
	end

	if strcmp(method, 'kl')
		distance = kl_divergence(set_1, set_2)
	elseif strcmp(method, 'cdf')
		distance = cdf_distance(set_1, set_2)
	elseif strcmp(method, 'mahalanobis')
		% Does this actually work?
		distance = mahalanobis(set_1, set_2)
	else
		error(['No such method', method])
	end

function [dist] = mahalanobis(set_1, set_2)
	mahal_dist = mahal(set_1', set_2');
	dist = sum((set_1 - repmat(mean(set_2), 1, length(set_1))).^2, 2);
end

function [cdf] = compute_cdf(set)
	cdf = zeros(length(set), 1);
	for k = 1:length(set)
		cdf(k) = sum(set(1:k));
	end
end

function [dist] = cdf_distance(set_1, set_2)
	cdf_1 = compute_cdf(set_1);
	cdf_2 = compute_cdf(set_2);

	dist = 0.0;
	alpha = 1.8;
	for k = 1:length(cdf_1)
		dist = dist + ((cdf_1(k) - cdf_2(k)) ^ alpha)
	end
end

function [dist] = kl_divergence(set_1, set_2)
	dist = 10
end
