fis = readfis('MonumentFuzzy1.fis');
t   = linspace(0,12,241);  hr = 18 + t;                 % 6 pm to 6 am
lux = min(max(5 + 55*exp(-t/2) + 4*sin(2*pi*t/6),0),100);
b   = evalfis(fis,[lux(:) hr(:)])';

Ead = trapz(t,b);  Eb = trapz(t,100*ones(size(t)));
saving = 100*(1 - Ead/Eb);
fprintf('Adaptive %.1f | Baseline %.1f | Saved %.1f%%\n',Ead,Eb,saving);

% 1. Brightness response
figure; plot(hr,b,'LineWidth',2); hold on; plot(hr,100*ones(size(t)),'r--','LineWidth',1.5);
grid on; xlabel('Hour of night'); ylabel('Brightness (PWM %)');
legend('Adaptive (fuzzy)','Baseline 100%'); title('Brightness response');

% 2. Energy comparison
figure; bar([Ead Eb]); set(gca,'XTickLabel',{'Adaptive','Baseline'});
ylabel('Energy (% x hours)'); title(sprintf('Energy saved: %.1f%%',saving));

% 3. Rule surface
figure; gensurf(fis); title('Fuzzy rule surface');

% 4. Monument animation
fig = figure('Color',[.05 .06 .1],'Position',[100 100 1000 450]);
subplot(1,2,1); hold on; axis([0 10 0 10]); axis off
sky = patch([0 10 10 0],[0 0 10 10],[0 0 0],'EdgeColor','none');
th = linspace(0,2*pi,60);
for k = 1:6
    glow(k) = patch(5+k*0.7*cos(th),4.5+k*0.7*sin(th),[1 .85 .4],'EdgeColor','none','FaceAlpha',0);
end
patch([0 10 10 0],[0 0 1.5 1.5],[.1 .2 .1],'EdgeColor','none');
mon(1) = patch([3 7 7 3],[1.5 1.5 2.1 2.1],[.4 .4 .4]);
mon(2) = patch([3.6 6.4 6.4 3.6],[2.1 2.1 2.7 2.7],[.4 .4 .4]);
mon(3) = patch([4.2 5.8 5.5 4.5],[2.7 2.7 7 7],[.4 .4 .4]);
mon(4) = patch([4.5 5.5 5],[7 7 8],[.5 .45 .3]);  set(mon,'EdgeColor','none');
txt = text(5,9.3,'','Color','w','HorizontalAlignment','center','FontSize',14);
subplot(1,2,2); hold on; grid on; set(gca,'Color',[.1 .12 .2],'XColor','w','YColor','w');
plot(hr,b,'y','LineWidth',2); plot(hr,100*ones(size(t)),'r--');
xlabel('Hour'); ylabel('Brightness %'); mk = plot(hr(1),b(1),'wo','MarkerFaceColor','w');
for i = 1:numel(t)
    if ~ishandle(fig), return; end                       % stops cleanly if window closed
    bn = b(i)/100;
    sky.FaceColor = min([.02 .03 .08] + (lux(i)/100)*[.4 .55 .8],1);
    for k = 1:6, glow(k).FaceAlpha = bn*0.12; end
    set(mon,'FaceColor',min([.2 .2 .22] + bn*[.75 .65 .4],1));
    txt.String = sprintf('Hour %.1f | Lux %.0f | Brightness %.0f%%',hr(i),lux(i),b(i));
    mk.XData = hr(i); mk.YData = b(i);
    drawnow; pause(0.04);
end
