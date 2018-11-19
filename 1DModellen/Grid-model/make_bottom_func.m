function [xb, d, d0] = make_bottom_func(mxb, L, alpha, Bc) 
    
    dep = [20, 20, 2 , 2 , 20, 20 ];    % depth of dam at characteristics [m]
    xlen = L;                           % size 'grid' [m]
    mx = mxb;                           % # gridpoints-1 on 'grid' [-]
    dx = xlen/mx;                       % length of 'grid'-cell [m]
    xx = 0:dx:xlen;                     % total x-interval
    d0 = dep(1); 
    d = dep(3);
    H = d0 - d;
    
    if ((L-Bc)>= (2*5 + (2*H*inv(alpha)))) 
        xb  = [0 , (50-(Bc/2)-inv(alpha)*H), (50-(Bc/2)), (50+(Bc/2)), (50+(Bc/2)+inv(alpha)*H), 100];    % characteristic x-coordinates of dam 
        dd = interp1(xb,dep,xx);                                                    % depth at slope of dam [m]
        write_matrix(dd',['dam_' num2str(Bc) '.bot'])                               % write ANSII matrix of bottom input
        Bc_1 = xb(4)-xb(3);
    else
         error(['Bc must be smaller than or equal to ' num2str(L - (2*5 + (2*H*inv(alpha))) ) ' m']);
    end
    save('var', 'xlen', 'd', 'd0', '-append')
%%{
%close
depmin = -max(dep);
plot(xx,-dd);hold on;
grid on
%set(gca,'ylim',[depmin 0])
pbaspect([(xlen/-depmin), 1, 1])
xlabel('x (m)')
ylabel('d (m)')
%}

end

