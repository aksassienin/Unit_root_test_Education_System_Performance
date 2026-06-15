smpl @all
%vars = "DPEPIB DPENSSECDEPENSPUB TXACHEV BEPC BAC CEPE RATIO2 PINSTITUTRICE PIBHBT DPENSPRIMDEPENSPUB IPC"
!n = @wcount(%vars)

' ----- Nettoyage préventif -----
if @isobject("_tmp") then
    delete _tmp
endif
if @isobject("_tmpseries") then
    delete _tmpseries
endif

!nrows = !n*2*3 + 1
table(!nrows,12) ResultatsRU

ResultatsRU(1,1)  = "Variable"
ResultatsRU(1,2)  = "Niveau"
ResultatsRU(1,3)  = "Spec."
ResultatsRU(1,4)  = "ADF stat"
ResultatsRU(1,5)  = "ADF p-val"
ResultatsRU(1,6)  = "PP stat"
ResultatsRU(1,7)  = "PP p-val"
ResultatsRU(1,8)  = "DFGLS stat"
ResultatsRU(1,9)  = "KPSS stat"
ResultatsRU(1,10) = "ERS-PO stat"
ResultatsRU(1,11) = "NP MZa"
ResultatsRU(1,12) = "Decision"

!row = 2

for !i=1 to !n
    %v = @word(%vars,!i)

    for %lev L D
        if %lev="L" then
            %ser    = %v
            %levlab = "Level"
        else
            series _tmpseries = d({%v})
            %ser    = "_tmpseries"
            %levlab = "1st Diff."
        endif

        for %sp n c t
            if @isobject("_tmp") then
                delete _tmp
            endif

            if %sp="n" then
                %splab = "None"
            endif
            if %sp="c" then
                %splab = "Intercept"
            endif
            if %sp="t" then
                %splab = "Trend+Int."
            endif

            ResultatsRU(!row,1) = %v
            ResultatsRU(!row,2) = %levlab
            ResultatsRU(!row,3) = %splab

            ' ===== ADF =====
            freeze(_tmp) {%ser}.uroot(adf,{%sp},info=aic)
            ResultatsRU(!row,4) = @val(_tmp.@cellfmt(7,2))
            ResultatsRU(!row,5) = @val(_tmp.@cellfmt(7,4))
            delete _tmp

            ' ===== PP =====
            freeze(_tmp) {%ser}.uroot(pp,{%sp},bw=nw)
            ResultatsRU(!row,6) = @val(_tmp.@cellfmt(7,2))
            ResultatsRU(!row,7) = @val(_tmp.@cellfmt(7,4))
            delete _tmp

            ' ===== DFGLS =====
            if %sp<>"n" then
                freeze(_tmp) {%ser}.uroot(dfgls,{%sp},info=aic)
                ResultatsRU(!row,8) = @val(_tmp.@cellfmt(7,2))
                delete _tmp
            else
                ResultatsRU(!row,8) = "-"
            endif

            ' ===== KPSS =====
            if %sp<>"n" then
                freeze(_tmp) {%ser}.uroot(kpss,{%sp},bw=nw)
                ResultatsRU(!row,9) = @val(_tmp.@cellfmt(7,2))
                delete _tmp
            else
                ResultatsRU(!row,9) = "-"
            endif

            ' ===== ERS-PO =====
            if %sp<>"n" then
                freeze(_tmp) {%ser}.uroot(ers,{%sp},info=aic)
                ResultatsRU(!row,10) = @val(_tmp.@cellfmt(7,2))
                delete _tmp
            else
                ResultatsRU(!row,10) = "-"
            endif

            ' ===== Ng-Perron MZa =====
            if %sp<>"n" then
                freeze(_tmp) {%ser}.uroot(np,{%sp},info=aic)
                ResultatsRU(!row,11) = @val(_tmp.@cellfmt(7,2))
                delete _tmp
            else
                ResultatsRU(!row,11) = "-"
            endif

            ' ===== Décision =====
            if @val(ResultatsRU(!row,5)) < 0.05 then
                ResultatsRU(!row,12) = "Stationnaire"
            else
                ResultatsRU(!row,12) = "RU"
            endif

            !row = !row + 1
        next

    next

    if @isobject("_tmpseries") then
        delete _tmpseries
    endif
next

ResultatsRU.setwidth(1)  28
ResultatsRU.setwidth(2)  12
ResultatsRU.setwidth(3)  13
ResultatsRU.setwidth(4)  12
ResultatsRU.setwidth(5)  12
ResultatsRU.setwidth(6)  12
ResultatsRU.setwidth(7)  12
ResultatsRU.setwidth(8)  13
ResultatsRU.setwidth(9)  12
ResultatsRU.setwidth(10) 13
ResultatsRU.setwidth(11) 12
ResultatsRU.setwidth(12) 14

show ResultatsRU
statusline "Table complète générée : ResultatsRU"
