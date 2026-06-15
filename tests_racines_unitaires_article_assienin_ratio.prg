%level = "RATIO"
%diff  = "DRATIO"

%NONE = "exog=none"
%INT  = "exog=const"
%TI   = "exog=trend"

for %v {%level}

'========================
' ADF
'========================
freeze(adf_NONE_{%v}) {%v}.uroot(adf, {%NONE})
freeze(adf_INT_{%v})  {%v}.uroot(adf, {%INT})
freeze(adf_TI_{%v})   {%v}.uroot(adf, {%TI})

'========================
' PP
'========================
freeze(pp_NONE_{%v}) {%v}.uroot(pp, {%NONE})
freeze(pp_INT_{%v})  {%v}.uroot(pp, {%INT})
freeze(pp_TI_{%v})   {%v}.uroot(pp, {%TI})

next

for %v {%diff}

freeze(adf_NONE_{%v}) {%v}.uroot(adf, {%NONE})
freeze(adf_INT_{%v})  {%v}.uroot(adf, {%INT})
freeze(adf_TI_{%v})   {%v}.uroot(adf, {%TI})

freeze(pp_NONE_{%v}) {%v}.uroot(pp, {%NONE})
freeze(pp_INT_{%v})  {%v}.uroot(pp, {%INT})
freeze(pp_TI_{%v})   {%v}.uroot(pp, {%TI})

next

for %v {%level}

'========================
' KPSS
'========================
freeze(kpss_INT_{%v}) {%v}.uroot(kpss, {%INT})
freeze(kpss_TI_{%v})  {%v}.uroot(kpss, {%TI})

'========================
' ERS (DF-GLS)
'========================
freeze(ers_INT_{%v}) {%v}.uroot(ers, {%INT})
freeze(ers_TI_{%v})  {%v}.uroot(ers, {%TI})

'========================
' NG-PERRON
'========================
freeze(ngp_INT_{%v}) {%v}.uroot(ngp, {%INT})
freeze(ngp_TI_{%v})  {%v}.uroot(ngp, {%TI})

next

for %v {%diff}

freeze(kpss_INT_{%v}) {%v}.uroot(kpss, {%INT})
freeze(kpss_TI_{%v})  {%v}.uroot(kpss, {%TI})

freeze(ers_INT_{%v}) {%v}.uroot(ers, {%INT})
freeze(ers_TI_{%v})  {%v}.uroot(ers, {%TI})

freeze(ngp_INT_{%v}) {%v}.uroot(ngp, {%INT})
freeze(ngp_TI_{%v})  {%v}.uroot(ngp, {%TI})

next

