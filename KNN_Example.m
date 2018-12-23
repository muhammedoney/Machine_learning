%%K-Means MATLAB Example
%%Author Muhammed Mustafa Öney

clear all;
close all;
clc;
%% datapreprocessing
M = readtable('veriler.csv');
x_train = M(1:15,1:4);  %satir sayisinin %66si kadar egitim verisi
y_train = M(1:15,4);    %egitimde kullanilan veriler, tahmin edilecek sütun disinndaki sutunlardan 
                        %alinan ornekler icin(x),
                        %tahmin edilecek sütundan alinan örnekler icin(y) kullanilir
x_test = M(16:end,1:4); %satir sayisinin %33ü kadar test verisi
y_test = M(16:end,4);   %known values

%% train for  KNN Algorithm
mdl = fitcknn(x_train,y_train,'NumNeighbors',3,'NSMethod','exhaustive','Distance','minkowski','Standardize',1);

%% prediction 
label = predict(mdl,x_test); %predicted values

%% error calculation with confusion matrix
y_test = table2array(y_test);  %%y_test table formatinda bir veri tipi olduğu için label ile confusionmatrixe sokabilmek icin labelin veri tipine donusturuldu
C = confusionmat(y_test,label);
size_C = size(C);
sum = 0;
for i=1:size_C(1,1)
    sum = sum + C(i,i);
end
size_y = size(y_test);
error = (size_y(1,1)-sum)/size_y(1,1);
disp(error);
