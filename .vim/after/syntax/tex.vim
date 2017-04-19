" Borrowed from timss's answer to stackoverflow question 6738902
" The subsequent discussion with Konrad Rudolph is also worth reading
syn region texZone start="\\begin{lstlisting}" end="\\end{lstlisting}\|%stopzone\>"
syn region texZone start="\\lstinputlisting"   end="{\s*[a-zA-Z/.0-9_^]\+\s*}"
syn match texInputFile "\\lstinline\s*\(\[.*\]\)\={.\{-}}" contains=texStatement,texInputCurlies,texInputFileOpt
