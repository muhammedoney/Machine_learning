%%Refine Data in MATLAB 
%%Author Muhammed Mustafa Öney

clear all;
close all;
clc;

M = csvread('MobileCommData.csv',1,2);   %ilk satýr(C0,C1..) ve ilk iki sutunu atmadan csvread fonksiyonu ile dosyayý okuyamýyorduk. 
                                         %Ama herhangi bir çýkartma yapmadan readtable ile dosya okunabiliyor
%% Refinement

M_copy=M;
list=ones(1,400);
M_temp = M(1,1:end);
sayac = 400;
for i=1:400
   var=M_temp(1,i);
   for j=1:729848
       if var ~= M(j,i)
           list(1,i)=0;                  % bu islem ile, M matrisindeki bir sutunun her elemeaný ayný ise o sutun list vektoru icinde 1 olarak iþaretleniyor
           sayac = sayac-1;
           break;
       end
       var = M(j,i);
   end
end
 b=0;
for a=1:400
    if list(1,a) == 1
        M(:,(a-b)) = [];                % burada ise silinmesi gereken sutunlar silinmektedir, her silinen sutun ile M matrisinin boyutu da kuculdugunden b integeri kullanilmistir
        b=b+1;
    end
end

%% Writing as CSV

csvwrite('ProcessedMobileCommData.csv',M);