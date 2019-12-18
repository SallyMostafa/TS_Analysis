function MP_Parasites_dendrogram()
[Pts, labels] = Prepare_phenotype_data();
%disp(size(Pts));
numOfData = 6;
count = 0;
SL = 30;
method = 'complete';

[m n] = size(Pts);
if m > n
    for i = 1:numOfData
        Pts{i} = Pts{i}';
    end
end

for i = 1:numOfData
    for j = i+1:numOfData
        count = count + 1;
        data{count} = [Pts{j}', Pts{i}'];
        changepoint(count) = length(Pts{j});
    end
end

for ind = 1:count
    distance(ind) = distance_Algorithm(data{ind}, changepoint(ind), SL);
end

%disp(data)

figure
rng('default')

Z=linkage(distance,method);%%'complete' , 'average'
labels = cellstr(labels);
subplot(numOfData+2, 2, [2 4 6 8 10 12 14 16]);% subplot spanning the entire third and fourth row
%subplot(numOfData+2, 3, [2 3 5 6 8 9 11 12 14 15 17 18 20 21 23 24]); %subplot spanning the entire second and third col
[H, T, outperm] = dendrogram(Z,'Orientation','right','Labels', labels);%% single
%disp(H)
%disp(T)
%disp(outperm)
disp(Pts(outperm(1)));
xLimits = get(gca,'XLim');  %# Get the range of the y axis
h = gca;
xlim([0 xLimits(2)]);
set(h,{'ycolor'},{'r'});
saveas(gcf,'subplot1.png');
% %% Calc Dedrogram
maxLength = 0;
for ind = 1:length(Pts)
    lengthData = length(Pts{ind});
    if lengthData > maxLength
        maxLength = lengthData;
    end
end

figure; hold on;
LO = length(outperm);
for i = 1:LO
    subplot(numOfData+2, 2, 2*i+1 );  % create a plot with subplots in a grid of 4 x 2
    %subplot(numOfData+2, 3, 3*i+1 );  % create a plot with subplots in a grid of 4 x 2
    Zd1 = zscore(Pts{outperm(LO-i+1)});
    d1new(1: maxLength) = nan;
    d1new((maxLength - length(Zd1))+1: maxLength) = Zd1;
    plot(Zd1); % subplot at first row, first column
    set(gca,'Visible','off');
    xlim([0 maxLength]);
end
saveas(gcf,'subplot2.png');
end
function distance = distance_Algorithm(data, changePoint, SL)
thr = 0.05;
[ABBAJoinMP, ABBAJoinMPI] = MatrixProfileSplitConstraint(data, SL, changePoint);

 %figure 
 %subplot(2,1,1);
 %plot(data);
 %subplot(2,1,2);
 %plot(ABBAJoinMP);


% distance Calculation
TSLength = length(data);
distLoc = ceil(thr*TSLength);
MPSorted = sort(ABBAJoinMP);

if MPSorted(distLoc)~= inf
    distance = MPSorted(distLoc);
else
    MPRemoveInf = ABBAJoinMP(ABBAJoinMP(:)~=inf);
    distance = max(MPRemoveInf);
end
end

