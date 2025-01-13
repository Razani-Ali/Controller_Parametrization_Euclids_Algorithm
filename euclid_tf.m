function [N, M, X, Y] = euclid_tf(G)
syms s x
[~, den] = numden(G);
pol = sym2poly(den);
root = roots(pol);
disp('poles are:')
disp(root)
if all(real(root) < 0)
    disp('plant is stable, so:')
    N = G;
    disp('N is:')
    pretty(N)
    M = 1;
    disp('M is:')
    disp(M)
    X = 0;
    disp('X is:')
    disp(X)
    Y = 1;
    disp('Y is:')
    disp(Y)
else
    G_bar = simplify(subs(G, s, (1-x)/x));
    disp('we should change variable (s = (1-x)/x), so new tf is')
    pretty(G_bar)
    disp('nx + my = 1')
    [n, m] = numden(G_bar);
    disp('n is')
    pretty(n)
    disp('m is')
    pretty(m)
    if length(sym2poly(m)) > length(sym2poly(n))
        disp('m oreder was higher than n, change them')
        a = m;
        m = n;
        n = a;
    end
    k = 0;
    while 1
        k = k + 1;
        if k ==1
            disp('step 1')
            [q, r] = quorem(n, m, x);
            disp('n = q1 * m + r1')
            disp('q1 is')
            pretty(q)
            disp('r1 is')
            pretty(r)
            if (r == 0 ) || (q == 0)
                disp('failed')
                error('something went wrong')
            elseif length(sym2poly(sym(r))) == 1
                disp('finished')
                break
            end
        elseif k == 2
            disp('step 2')
            [q(2), r(2)] = quorem(m, r(1), x);
            disp('m = q2 * r1 + r2')
            disp('q2 is')
            pretty(q(2))
            disp('r2 is')
            pretty(r(2))
            if (r(2) == 0 ) || (q(2) == 0)
                disp('failed')
                error('something went wrong')
            elseif length(sym2poly(sym(r(2)))) == 1
                disp('finished')
                break
            end
        else
            disp(strjoin(['step', string(k)]))
            [q(k), r(k)] = quorem(r(k-2), r(k-1), x);
            str = ['r', string(k-2), '= * r', string(k-1), '* q', string(k), '+ r', string(k)];
            disp(strjoin(str))
            disp(strjoin(['q', string(k), 'is']))
            pretty(q(k))
            disp(strjoin(['r', string(k), 'is']))
            pretty(r(k))
            if (r(k) == 0 ) || (q(k) == 0)
                disp('failed')
                error('something went wrong')
            elseif length(sym2poly(sym(r(k)))) == 1
                disp('finished')
                break
            end
        end
    end
    Q = sym(eye(k)); Q(2,1) = q(2);
    for i=3:k
        Q(i,i-2) = -1; Q(i,i-1) = q(i);
    end
    MN = sym(eye(2)); MN(1,2) = -q(1);
    MN = [MN; zeros(k-2,2)];
    R = simplify(Q^-1 * MN);
    disp('Q * R = MN * [n; m]')
    disp('Q is')
    pretty(Q)
    disp('MN is')
    pretty(MN)
    disp(strjoin(['r', string(k), 'is']))
    pretty(R(end, :))
    disp('so X is')
    pretty(simplify(R(end, 1)/r(end)))
    disp('so Y is')
    pretty(simplify(R(end, 2)/r(end)))
    disp('lets check the condtion, following expression must be 1')
    pretty(simplify((n*R(end, 1)+m*R(end, 2))/r(end)))
    disp('let turn them back to s instead of x (x=1/(s+1)')
    disp('N is')
    N = simplify(subs(n, x, 1/(s+1)));
    pretty(N)
    disp('M is')
    M = simplify(subs(m, x, 1/(s+1)));
    pretty(M)
    disp('X is')
    X = simplify(subs(R(end, 1)/r(end), x, 1/(s+1)));
    pretty(X)
    disp('Y is')
    Y = simplify(subs(R(end, 2)/r(end), x, 1/(s+1)));
    pretty(Y)
    disp('lets check the condtion, following expression must be 1')
    pretty(simplify(N*X+M*Y))
end

