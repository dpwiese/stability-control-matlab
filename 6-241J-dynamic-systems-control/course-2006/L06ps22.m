function L06ps22(n, N)
   % function L06ps22(n,N)
   %
   % MATLAB code for 6.241/Fall 2006 PS2, problem 2(c)

   if nargin<1, n = 100; end            % default dimension
   if nargin<2, N = 20; end             % default number of trials
   M = toeplitz([0.5;-1;0.5;zeros(n-3,1)],[0.5 zeros(1,n-1)]);
   M(1,1) = 0.2;M(2,2) = 1;
   C = [zeros(1,n-1) 1];
   F = C*inv(eye(n)+M'*M);              % optimal filter
   G = F*C';                            % optimal cost
   qq = zeros(N,3);                     % to keep results
   for i = 1:N
       q = zeros(n,1);                      % generation of q
       q(1) = 5*randn; q(2) = q(1)+randn;
       for k = 1:n-2,
          q(k+2) = 2*(q(k+1)+randn)-q(k);
       end                                % end generation of q
       y = q+randn(n,1);
       qq(i,1) = q(n);
       qq(i,2) = F*y;
       qq(i,3) = sum(y)/n;
   end
   ee = sum((qq(:,1)-qq(:,2)).^2)/N;
   fprintf('\n error: %f    (theory: %f)\n',ee,G)
   close(gcf);plot(qq)

end
