function [A,B,h] = baumwelch(data, A, B, p, n, m)
    nSeq = length(data);
    logp = log(p);
    A = log(A);
    % random initialization
    alpha = log(rand(m,m));
    phi = log(rand(n,m)); h = -Inf;
    % EM variables initialization
    logm = -Inf;
    logmold = 0;
    iter = 0;
    for k = 1:250
        logmold = logm;
        [logm, alpha, beta, delta, gamma] = obsv_prob(data, A, B, logp, n);
        [logp, A, B] = maximization(data, delta, gamma, B, n, m);
        iter = iter + 1;
        h = cat(1,h,logm);
        if iter > 1 & (abs(logmold-logm) <= 1e-5)
            break
            h = h(2:end);
        end
    end
end