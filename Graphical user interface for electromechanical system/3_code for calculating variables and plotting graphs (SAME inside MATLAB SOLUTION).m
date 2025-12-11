clc, clear, clf, format compact
syms s Rs Rl L1 L2 L3 C3 C1 C2 Ur Ui  

%% Zadanie vstupných hodnôt
disp('Filter Chebysheva typu pásmový priepust')
g1=3.3487; g2=0.7117; g3=g1; del=0.10; f0=2.5e6;
Rsx=50; Rlx=50;Rx=50;
%L1x=35.47e-3; C1x=1.428e-6; L2x = 1.432; C2x = 35.38e-9; C3x=3.010e-6; L3x = 16.83e-3;
 L1x=(g1*Rx)/(2*pi*f0*del); L2x=(Rx*del)/(g2*2*pi*f0); L3x=(g3*Rx)/(2*pi*f0*del); 
 C1x=del/(g1*Rx*2*pi*f0); C2x = g2/(Rx*2*pi*f0*del); C3x=del/(g3*Rx*2*pi*f0); % paramere obvodu
 Ui=1;
Tstep=3e-5; wmin=1.4e7; wmax=1.75e7   % parametre pre Step a Bode
color='b'; % farba grafu 

%% MUN  
disp('MUN')
% Zápis systému a výpočet TF v symbolickom tvare

Ze=(L2*s)/(1+L2*C2*s^2);            %Ekvivalentny odpor paralelneho zapojenia C2 a L2
Z1=(s*Rs*C1+L1*C1*s^2+1)/(s*C1);    %Ekvivalentny vetvy z odporami Rs C1 a L1
Z3=(s*Rl*C3+L3*C3*s^2+1)/(s*C3);    %Ekvivalentny vetvy z odporami Rl C3 a L3
F = (Ze*Rl)/(Ze*Z3+Z1*Z3+Ze*Z1);

F=collect(F)
pretty(F)
% Spracovanie údajov TF v symbolickom tvare pre prechod do num. MATLABu
[cit,men]=numden(F) % oddelenie polynómov čitateľa a menovateľa
cit=subs(cit,{Rl,Rs,L1,L2,L3,C1,C2,C3},{Rlx,Rsx,L1x,L2x,L3x,C1x,C2x,C3x}); % dosadenie hodnôt do polynómu čitateľa
men=subs(men,{Rl,Rs,L1,L2,L3,C1,C2,C3},{Rlx,Rsx,L1x,L2x,L3x,C1x,C2x,C3x}); % dosadenie do polynómu menovateľa 

b=sym2poly(cit) % b - koeficienty polynómu čitateľa b(s)
a=sym2poly(men) % a - koeficienty polynómu menovateľa a(s)
b=double(b) % Prechod do numerickeho MATLABu
a=double(a)
F=tf(b,a) % Výsledná TF v numerickom MATLABe
F=tf(b/a(end),a/a(end))% TF upravená pre a0=1 (normovanie TF)

 subplot(121); 
 step(F,Tstep), grid on,
 title('Prechodová charakteristika MUN','FontSize',20,'FontWeight','bold')
 legend('F','Orientation','vertical','FontAngle', 'italic','FontSize',16,'FontWeight','bold')
 xlabel('\rightarrow t','FontSize',16,'FontWeight','bold')
 ylabel('\rightarrow U_R/U_{in}','FontSize',16,'FontWeight','bold')
 %LFCh
 subplot(122); bode(F,{wmin,wmax}), grid on
 title('Frekvenčná charakteristika MUN','fontsize',20,'FontWeight','bold')
 xlabel('\rightarrow Frequency','FontSize',16,'FontWeight','bold')
 ylabel('\rightarrow \phi','FontSize',16,'FontWeight','bold')
 set(findall(gcf,'type','line'),'linewidth',2)