function UFA_draw_radar(data,lim,prefer_range,labels)
    n=length(data);
    adj_data=zeros(n,1);
    point=zeros(n,2);
    adj_preferl=zeros(n,1);
    preferl_point=zeros(n,2);
    adj_preferu=zeros(n,1);
    preferu_point=zeros(n,2);
    
    set(gca,'units','normal','pos',[0 0 1 1]);
    axis off
    axis equal
    hold on
    theta_last=pi/2;
    for i=1:n
        theta=2*pi/n*i+pi/2;
        plot([0,500*cos(theta)],[0,500*sin(theta)],'k-','linewidth',1);
        for j=1:5
           plot([j*100*cos(theta_last),j*100*cos(theta)],[j*100*sin(theta_last),j*100*sin(theta)],'--','linewidth',0.75,'color',[0.5,0.5,0.5]);
        end
        
        theta_last=theta;
        if data(i)<lim(i,1)
            adj_data(i)=0;
        elseif data(i)>lim(i,2)
            adj_data(i)=500;
        else
            adj_data(i)=(data(i)-lim(i,1))/(lim(i,2)-lim(i,1))*500;
        end
        point(i,1:2)=[adj_data(i)*cos(theta);adj_data(i)*sin(theta)];
        adj_preferl(i)=(prefer_range(i,1)-lim(i,1))/(lim(i,2)-lim(i,1))*500;
        preferl_point(i,1:2)=[adj_preferl(i)*cos(theta);adj_preferl(i)*sin(theta)];
        adj_preferu(i)=(prefer_range(i,2)-lim(i,1))/(lim(i,2)-lim(i,1))*500;
        preferu_point(i,1:2)=[adj_preferu(i)*cos(theta);adj_preferu(i)*sin(theta)];
        text_around(510*cos(theta),510*sin(theta),labels{i},theta);
    end
    
    plot([preferl_point(:,1);preferl_point(1,1)],[preferl_point(:,2);preferl_point(1,2)],'b-','linewidth',1),alpha(0.3); % [63, 169, 245]
    plot([preferu_point(:,1);preferu_point(1,1)],[preferu_point(:,2);preferu_point(1,2)],'r-','linewidth',1);
    
    %{
    
    for i=1:n
        theta=2*pi/n*i+pi/2;
        for j=1:5
            text_around(j*100*cos(theta),j*100*sin(theta),num2str(lim(i,1)+(lim(i,2)-lim(i,1))/5*j),theta+pi/2,7);
        end
    end
    
    %}
    
    flag = 16;
    theta=2*pi/n*flag+pi/2;
    for j=1:5
        text_around(j*100*cos(theta),j*100*sin(theta),num2str(lim(flag,1)+(lim(flag,2)-lim(flag,1))/5*j),theta+pi/2,10);
    end
    
    
    plot([point(:,1);point(1,1)],[point(:,2);point(1,2)],'k-','linewidth',0.2);
    fill(point(:,1),point(:,2),[0.9 0.9 0.7])
    alpha(0.5);
    texts=findobj(gca,'Type','Text');
    minx=-300;
    maxx=300;
    miny=-300;
    maxy=300;
    for i=1:length(texts)
        rect=get(texts(i),'Extent');
        x=rect(1);
        y=rect(2);
        dx=rect(3);
        dy=rect(4);
        if x<minx
            minx=x;
        elseif x+dx>maxx
            maxx=x+dx;
        end
        if y<miny
            miny=y;
        elseif y+dy>maxy
            maxy=y+dy;
        end
    end
    axis([minx-50,maxx+50,miny-20,maxy+20]);
end

function text_around(x,y,txt,theta,fontsize)
    if nargin==4
        fontsize=12;
    end
    section=mod(theta+pi/12,2*pi);
    if section>pi+pi/6
        if section>1.5*pi+pi/6
            text(x,y,txt,'VerticalAlignment','cap','HorizontalAlignment','left','Fontsize',fontsize,'Interpreter','none');
        elseif section>1.5*pi
            text(x,y,txt,'VerticalAlignment','cap','HorizontalAlignment','center','Fontsize',fontsize,'Interpreter','none');
        else
            text(x,y,txt,'VerticalAlignment','cap','HorizontalAlignment','right','Fontsize',fontsize,'Interpreter','none');
        end
    elseif section>pi
        text(x,y,txt,'VerticalAlignment','middle','HorizontalAlignment','right','Fontsize',fontsize,'Interpreter','none');
    elseif section>pi/6
        if section>0.5*pi+pi/6
            text(x,y,txt,'VerticalAlignment','bottom','HorizontalAlignment','right','Fontsize',fontsize,'Interpreter','none');
        elseif section>0.5*pi
            text(x,y,txt,'VerticalAlignment','bottom','HorizontalAlignment','center','Fontsize',fontsize,'Interpreter','none');
        else
            text(x,y,txt,'VerticalAlignment','bottom','HorizontalAlignment','left','Fontsize',fontsize,'Interpreter','none');
        end
    else
        text(x,y,txt,'VerticalAlignment','middle','HorizontalAlignment','left','Fontsize',fontsize,'Interpreter','none');
    end
end
