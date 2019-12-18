function Euc_Parasites_dendrogram()
[Pts, labels] = Prepare_phenotype_data();
numOfData = 6;
method = 'complete';

originaldata = Pts;
Ptsmatrix = cell2mat(Pts);
Ptsmatrix = Ptsmatrix';
distance = pdist(Ptsmatrix);

figure
rng('default')

Z=linkage(distance,method);%%'complete' , 'average'
labels = cellstr(labels);
subplot(numOfData+2, 2, [2 4 6 8 10 12 14 16]);
[H, T, outperm] = dendrogram(Z,'Orientation','right','Labels', labels);%% single


xLimits = get(gca,'XLim');  %# Get the range of the y axis
h = gca;
xlim([0 xLimits(2)]);
set(h,{'ycolor'},{'r'});
saveas(gcf,'eucsubplot1.png');
% %% Calc Dedrogram
maxLength = 0;
for ind = 1:length(originaldata)
    lengthData = length(originaldata{ind});
    if lengthData > maxLength
        maxLength = lengthData;
    end
end
%disp(originaldata{1});
%disp(size(outperm));
%out =num2cell(outperm,1);
out = [3 6 2 5 1 4];
%disp(size(out));
disp(originaldata(3));
figure; hold on;
LO = length(outperm);
for i = 1:LO
    subplot(numOfData+2, 2, 2*i+1 );  % create a plot with subplots in a grid of 4 x 2
    %subplot(numOfData+2, 3, 3*i+1 );  % create a plot with subplots in a grid of 4 x 2
    Zd1 = zscore(originaldata{out(LO-i+1)});
    d1new(1: maxLength) = nan;
    d1new((maxLength - length(Zd1))+1: maxLength) = Zd1;
    plot(Zd1); % subplot at first row, first column
    set(gca,'Visible','off');
    xlim([0 maxLength]);
end
saveas(gcf,'eucsubplot2.png');
end

