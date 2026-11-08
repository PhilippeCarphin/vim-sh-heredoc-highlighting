function! Def_heredoc(marker, contains)
    let s:bcs = b:current_syntax
    unlet b:current_syntax
    " Load the relavant syntax file
    execute "syntax include @" . a:contains . " syntax/" . a:contains . ".vim"
    let b:current_syntax = s:bcs

    execute "syn region shHereDocHL matchgroup=sh" . a:contains . "HereDoc01 start=+<<\\s*"		. a:marker . "+		end=+^"	. a:marker . "$+ contains=@" . a:contains
    execute "syn region shHereDocHL matchgroup=sh" . a:contains . "HereDoc02 start=+<<-\\s*"		. a:marker . "+		end=+^\\t*"	. a:marker . "$+ contains=@" . a:contains
    execute "syn region shHereDocHL matchgroup=sh" . a:contains . "HereDoc03 start=+<<\\s*\\\\"		. a:marker . "+		end=+^"	. a:marker . "$+ contains=@" . a:contains
    execute "syn region shHereDocHL matchgroup=sh" . a:contains . "HereDoc04 start=+<<-\\s*\\\\"	. a:marker . "+		end=+^\\t*"	. a:marker . "$+ contains=@" . a:contains
    execute "syn region shHereDocHL matchgroup=sh" . a:contains . "HereDoc05 start=+<<\\s*'"		. a:marker . "'+	end=+^"	. a:marker . "$+ contains=@" . a:contains
    execute "syn region shHereDocHL matchgroup=sh" . a:contains . "HereDoc06 start=+<<-\\s*'"		. a:marker . "'+	end=+^\\t*"	. a:marker . "$+ contains=@" . a:contains
    execute "syn region shHereDocHL matchgroup=sh" . a:contains . "HereDoc07 start=+<<\\s*\""		. a:marker . "\"+	end=+^"	. a:marker . "$+ contains=@" . a:contains
    execute "syn region shHereDocHL matchgroup=sh" . a:contains . "HereDoc08 start=+<<-\\s*\""		. a:marker . "\"+	end=+^\\t*"	. a:marker . "$+ contains=@" . a:contains
    execute "syn region shHereDocHL matchgroup=sh" . a:contains . "HereDoc09 start=+<<\\s*\\\\\\_$\\_s*"	. a:marker . "+		end=+^"	. a:marker . "$+ contains=@" . a:contains
    execute "syn region shHereDocHL matchgroup=sh" . a:contains . "HereDoc10 start=+<<-\\s*\\\\\\_$\\_s*"	. a:marker . "+		end=+^\\t*"	. a:marker . "$+ contains=@" . a:contains
    execute "syn region shHereDocHL matchgroup=sh" . a:contains . "HereDoc11 start=+<<\\s*\\\\\\_$\\_s*\\\\"	. a:marker . "+		end=+^"	. a:marker . "$+ contains=@" . a:contains
    execute "syn region shHereDocHL matchgroup=sh" . a:contains . "HereDoc12 start=+<<-\\s*\\\\\\_$\\_s*\\\\"	. a:marker . "+		end=+^\\t*"	. a:marker . "$+ contains=@" . a:contains
    execute "syn region shHereDocHL matchgroup=sh" . a:contains . "HereDoc13 start=+<<\\s*\\\\\\_$\\_s*'"	. a:marker . "'+	end=+^"	. a:marker . "$+ contains=@" . a:contains
    execute "syn region shHereDocHL matchgroup=sh" . a:contains . "HereDoc14 start=+<<-\\s*\\\\\\_$\\_s*'"	. a:marker . "'+	end=+^\\t*"	. a:marker . "$+ contains=@" . a:contains
    execute "syn region shHereDocHL matchgroup=sh" . a:contains . "HereDoc15 start=+<<\\s*\\\\\\_$\\_s*\""	. a:marker . "\"+	end=+^"	. a:marker . "$+ contains=@" . a:contains
    execute "syn region shHereDocHL matchgroup=sh" . a:contains . "HereDoc16 start=+<<-\\s*\\\\\\_$\\_s*\""	. a:marker . "\"+	end=+^\\t*"	. a:marker . "$+ contains=@" . a:contains

    for i in map(range(1, 16), 'printf(''%02d'', v:val)')
        execute "hi def link sh" . a:contains . "HereDoc" . i . " shRedir"
    endfor

endfunction

let g:heredocs_default = #{PYTHON: "python", LUA: "lua", PERL: "perl", SHELL: "sh", GNUPLOT: "gnuplot", JSON: "json", VIM: "vim"}
for [marker, contains] in items(extend(g:heredocs_default, get(g:, 'heredocs', {})))
    call Def_heredoc(marker, contains)
endfor

for container in ['shFunctionList', 'shCaseList', 'shCommandSublist', 'shPPSLeftList']
    execute "syn cluster " . container . " add=shHereDocHL"
endfor
" vim: ts=16 fdm=marker
