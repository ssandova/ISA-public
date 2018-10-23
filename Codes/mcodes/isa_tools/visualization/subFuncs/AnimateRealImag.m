function arw = AnimateRealImag(hObject,eventdata,t,psi,h)

%LOAD
arw = guidata(hObject);

%NEW ARROW
delete(arw);
kk = round(get(hObject,'Value'));
arw = arrow([t(kk) 0 0],[t(kk),real(psi(kk)),imag(psi(kk))], 'EdgeColor','r','FaceColor','r','FaceAlpha',0.9,'EdgeAlpha',0.9,'LineWidth',2,'MarkerSize',10,'LineSmoothing','on');
drawnow;

%SAVE
guidata(hObject,arw);

end
