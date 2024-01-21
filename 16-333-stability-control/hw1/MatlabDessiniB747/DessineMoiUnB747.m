function    resultat = DessineMoiUnB747(Cap,Assiette,Gite,altitude)

    % Date : 28/11/2006
    % Auteur : Elodie Roux (Elodie.Roux@supaero.org)
    % But du programme :    Dessine en 3D un B747
    %            dans le repere terrestre Ro selon
    %             les angles de Cap, Assiette, Gite
    %            et l'altitude que vous indiquez.
    %             Bien evidemment les angles sont en radians
    %            et orientes, l'altitude est en metres.
    % J'ai pique les coordonnees des points qui decrivent le B747,
    % dans le fichier 'b747.wrl' que j'ai trouve a
    % http://www.mathworks.com/matlabcentral/fileexchange/loadFile.do?objectId=699&objectType=file
    %
    % Exemple d'utilisation :
    %------------------------
    % Gite         = -5 *pi/180;
    % Assiette     = 12 *pi/180;
    % Cap         = 0 *pi/180;
    % altitude    = 15;
    % DessineMoiUnB747(Cap,Assiette,Gite,altitude);
    %
    % Autre exemple avec une animation cette fois-ci :
    %-------------------------------------------------
    % for(i=[0:1:15 15:-1:0]),
    %    clf,
    %    DessineMoiUnB747(0,i*pi/180,0,37);
    %    pause(0.0001)
    % end

    % Matrice des coordonnees de l'avion B747 :
    % (j'ai pique la premiere matrice de points du fichier b747.wrl)
    % les "vertices" correspondent a la matrice "point" du fichier b747.wrl
    % les "faces" correspondent a la matrice "coordIndex" avec la derniere colonne en moins, et faire +1 sur tous les elements
    load -ASCII vertices.mat
    % et les surfaces definies par les points
    load -ASCII faces.mat

    % les coordonnees avion "vertices" ne sont pas definies
    % comme on a l'habitude dans le repere avion Rb
    % alors on va modifier cela pour revenir a la definition
    % de l'avion dans Rb
    vertices = 10/2 * ([1 0 0;0 cos(-pi/2) -sin(-pi/2); 0 sin(-pi/2) cos(-pi/2)]*vertices')';
    % le fois dix/deux c'est pour mettre en metres

    % On remonte l'avion pour qu'a altitude nulle, il touche le sol.
    % en realite faudrait le monter un peu plus car ici le train est rentre
    % c'est la nacelle moteur qui touche le sol visiblement.
    vertices(:,3) = vertices(:,3) - max(vertices(:,3));

    % pour tenir compte du cap, de l'assiette, du gite...
    % il suffit de multiplier par les matrices de rotation :
    M_Rb_RF = [1 0 0; 0 cos(Gite) -sin(Gite); 0 sin(Gite) cos(Gite)];
    M_RF_Rc = [cos(Assiette) 0 sin(Assiette); 0 1 0; -sin(Assiette) 0 cos(Assiette)];
    M_Rc_Ro = [cos(Cap) -sin(Cap) 0; sin(Cap) cos(Cap) 0; 0 0 1];

    vertices = (M_Rc_Ro*M_RF_Rc*M_Rb_RF*vertices')';

    % Prise en compte de l'altitude de vol :
    vertices(:,3) = vertices(:,3) - altitude;    % moins et pas plus car le Zo est oriente vers le bas

    figure(1)
    hold on
    h = patch('Vertices',vertices,'Faces',faces,'FaceVertexCData',flipud(gray(size(vertices,1))),'FaceColor','interp','FaceLighting','Phong','EdgeColor','none','SpecularColorReflectance',0.5);
    %material metal

    view(3)
    set(get(1,'Children'),'ZDir','reverse')
    set(get(1,'Children'),'YDir','reverse')
    axis equal    % c'est cette ligne qui me fait afficher le message : "Warning: RGB color data not yet supported in Painter's mode."
    axis([-37 37 -37 37 -37-altitude 37-altitude])
    patch([-37 37 37 -37],[37 37 -37 -37],[0 0 0 0],'FaceColor',[0.8 0.6 0.45]) %  le dessin du sol, la terre
    grid on
    xlabel('X_O')
    ylabel('Y_O')
    zlabel('Z_O')


    if(max(vertices(:,3))>0)
        disp('  ')
        disp('!!!!!!!!!!   ATTENTION : CRASH  !!!!!!!!!!!!!!!!!!')
    end

    % Et la lumiere fut !
    % Merci Pierre
    Elevation = 45 ;
    Direction = 60 ; % A partir du Nord
    El = Elevation * pi / 180 ;
    Dr = Direction * pi / 180 ;
    Position = [ cos(El)*sin(Dr) cos(El)*cos(Dr) -cos(El)];
    lh = light('Style','infinite', 'Position', Position,'Color',[1 1 1]);
    set(gca,'AmbientLightColor', [1 1 1])

    resultat=h;

end
