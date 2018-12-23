%%K-Means MATLAB Example
%%Author Muhammed Mustafa �ney

clear all;
close all;
clc;
%% datapreprocessing
M = readtable('veriler.csv');
x_train = M(1:15,1:4);  %sat�r say�s�n�n %77si kadar egitim verisi
y_train = M(1:15,4);    %egitimde kullan�lan veriler, tahmin edilecek s�tun d���ndaki s�tunlardan 
                        %al�nan �rnekler icin(x),
                        %tahmin edilecek s�tundan al�nan �rnekler icin(y) kullan�l�r
x_test = M(16:end,1:4); %sat�r say�s�n�n %33� kadar test verisi
y_test = M(16:end,4);   %known values

%% train for  KNN Algorithm
mdl = fitcknn(x_train,y_train,'NumNeighbors',3,'NSMethod','exhaustive','Distance','minkowski','Standardize',1);

%% prediction 
label = predict(mdl,x_test); %predicted values

%% error calculation with confusion matrix
y_test = table2array(y_test);
C = confusionmat(y_test,label);
size_C = size(C);
sum = 0;
for i=1:size_C(1,1)
    sum = sum + C(i,i);
end
size_y = size(y_test);
error = (size_y(1,1)-sum)/size_y(1,1);
disp(error);