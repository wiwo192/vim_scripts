"
" Setup 'SetupBugEnv' and 'SetupLrgEnv' command.
" depends on $bugdir, $lrgdir 
"

"
"  - cd to <parentdir>/<childdir>
"    (mkdir <parentdir>/<childdir> if <childdir> doesn't exist)
"
"  - edit <parentdir>/<childdir>/analysis.txt
function! SetupEnv(parentdir, childdir)
   let l:target_dir = a:parentdir . "/" . a:childdir"

   if ! isdirectory(l:target_dir)
      call mkdir(l:target_dir)
   endif

   execute "cd ". l:target_dir

   execute "edit analysis.txt"
endfunction

command! -nargs=1 BugEnv let $bug=<q-args> | call SetupEnv($bugdir, "bug" . <q-args>)
command! -nargs=1 LrgEnv let $lrg=<q-args> | call SetupEnv($lrgdir, "lrg" . <q-args>)
