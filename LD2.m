%%main?gj? dilles 1. kollona - galdi?a NR
%                 2. kollona - p?rdoto di??u bun?u skaits

%J?noskaidro cik di??u buntes ir visp?r p?rdotas
%J?noskaidro cik di??u buntes ir vid?ji p?rdotas dien?

%funckiju izsauc nor?dot komandrind? t?s nosaukumu(parametrus) - LD2(dilles)
function [revenue,total] = LD2(dilles)

total = sum(dilles(:,2)); %sum apr??ina summu
average = mean(dilles(:,2)); % mean apr??ina vid?jo v?rt?bu
fprintf('Kopa pardotas %d buntes.\n', total); %izvada tekstu uz ekr?na 
                                              % %d nor?da veselu skaitli 
                                              % \n nor?da jaunas rindas s?kumu
fprintf('Videji pardotas %.1f buntes diena.\n', average); % %.1f nor?da, ka b?s 
                                                          %skaitlis ar 1 ciparu aiz komata

%J?apr??ina pe??a ?emot v?r? katras dienas cenu
%revenue = total * 0.35;
revenue = sum(dilles(:,2).*dilles(:,3));
fprintf('Nopelnits: %.2f EUR\n', revenue);

%ieg?t? pe??a pie katra galda

%Kur? dien? tika p?rdots vismaz?kais bun?u skaits
[low, lowIndex] = min(dilles(:,2));  %interes? visa attiec?g? matricas rinda

%Kur? dien? tika p?rdots visliel?kais bun?u skaits
[high, highIndex] = max(dilles(:,2));  %interes? visa attiec?g? matricas rinda

fprintf('Min skaits: %d (pie %d. galda)\n', ... % ... izmanto lai turpin?tu rakst?t n?kamaj? rind?
    low, dilles(lowIndex,1));

fprintf('Max skaits: %d (pie %d. galda)\n', high, dilles(highIndex,1));

%%j?nosaka cik pie katra galdi?a ir kop? p?rdotas dilles

tableID = unique(dilles(:,1)); %unique atrod unik?l?s v?rt?bas
averages = zeros(length(tableID),2);
revenues = zeros(length(tableID),2);
for i = 1: length(tableID) %length nosaka matricas gar?k?s dimensijas garumu
    index = dilles(:,1) == tableID(i); %lo?isk? indeks??ana
    values = dilles(index,2);
    values2 = dilles(index,2).* dilles(index,3);
    total = sum(values);
    average = mean(values);
    revenue = sum(values2);
    revenues(i,:) = [tableID(i) revenue];
   
    averages(i,:) = [tableID(i) average]; 
    fprintf('Pie %d. galda pardotas %d buntes.\n', tableID(i), total);
    fprintf('Videji %.1f buntes diena.\n', average);
    if max(values) >= 10
        fprintf('!! Pie %d. galda ir labi.\n', tableID(i));
    end
end
makeScatterPlot(dilles) %appak?funkcijas izsauk?ana
makeBarPlot(averages,...
    'Videjais pardoto dillu bunsu skaits pie viena galda',...
    'Galda numurs',...
    'Videjais skaits');

makeBarPlot(revenues, ...
    'Ienemumi pie viena galda',...
    'Galda numurs',...
    'Ienemumi');
end %funkcija beidzas ar end


function makeScatterPlot(dilles)
figure;
plot(dilles(:,1), dilles(:,2), '.', 'MarkerSize',20);
title('Pardoto dillu bunsu skaits pie viena galda.');
xlabel('Galda numurs');
ylabel('Skaits');
hold on;
average = mean(dilles(:,2));
plot([min(dilles(:,1)) max(dilles(:,1))],[average average],'--');
legend('Skaits viena diena','Kopejais videjais skaits');
set(gca, 'XTick', min(dilles(:,1)) : max(dilles(:,1)));
    %set izmaina daž?diem matlaba elementiem to ?pa??bas
    %gca nor?da uz to, ka modific? tagad?ju diagrammu
    %XTick nor?da k?das v?rt?bas r?da uz X ass ir j?nor?da visas v?rt?bas
                  
set(gca, 'YTick', min(dilles(:,2)) : max(dilles(:,2))); 
    %XTick nor?da k?das v?rt?bas r?da uz X ass ir j?nor?da visas v?rt?bas                  
end

function makeBarPlot(values, titleText, xLabelText, yLabelText)
figure;
bar(values(:,1), values(:,2));
title(titleText);
xlabel(xLabelText);
ylabel(yLabelText);
end



%revenue = LD2(dilles)
%pelna = LD2(dilles)

%[revenue,total] = LD2(dilles)
%[pelna, kopa] = LD2(dilles)