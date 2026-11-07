function! Def_heredoc(marker, contains)
    let s:bcs = b:current_syntax
    unlet b:current_syntax
    " Load the relavant syntax file
    execute "syntax include @" . a:contains . " syntax/" . a:contains . ".vim"
    let b:current_syntax = s:bcs

    for [matchGroup, quotation] in items({"heredoc" . a:marker . "Plain": "", "heredoc" . a:marker . "SingleQuote": "'", "heredoc" . a:marker . "DoubleQuote": "\""})
        for [mgSuffix, startPrefix, endPrefix] in [["", "<<\\s*", "^"], ["Indented", "<<-\\s*", "^\\t*"]]
            let mgName = matchGroup . mgSuffix
            let start  = startPrefix . quotation . a:marker .quotation . "\\s*"
            let end    = endPrefix   . a:marker . "$"
            execute "syntax region shHereDocHL matchgroup=" . mgName . " start=+" . start . "+ end=+" . end . "+ contains=@" . a:contains
            execute "hi def link " . mgName . " shRedir"
        endfor
    endfor
endfunction

let g:heredocs_default = #{PYTHON: "python", LUA: "lua", PERL: "perl", SHELL: "sh", GNUPLOT: "gnuplot", JSON: "json"}
for [marker, contains] in items(extend(g:heredocs_default, get(g:, 'heredocs', {})))
    call Def_heredoc(marker, contains)
endfor

for container in ["shCommandSublist", "shFunctionList", "shCaseList", "shPPSLeftList"]
    execute "syn cluster " . container . " contains=shHereDocHL"
endfor
