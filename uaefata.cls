%
% brownletter.cls -- a document class for writing letters with Brown letterhead 
%
% Copyright 2003, Nesime Tatbul (tatbul@cs.brown.edu)
%
% Notes:
%
% 1. This class can be used for creating letters with Brown logo at the
%    header and CS department address at the footer (as in standard Brown
%    letterhead stationery).
% 2. It is based on the standard Latex document class, letter.cls.
% 3. Required packages are epsfig and ifthen.
% 4. If Brown logo is to be included in the head, then the file
%    brownlogo.eps must be provided. Otherwise, the logo is omitted.
% 5. For example usage, please see brownletter_example.tex
% 
% Please contact tatbul@cs.brown.edu to report any problems or bugs.
%

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{uaefata}
\RequirePackage{graphicx}
\RequirePackage{epstopdf}
\RequirePackage{epsfig}
\RequirePackage{ifthen}
\usepackage[utf8]{inputenc}
\usepackage[brazil]{babel}
\DeclareGraphicsExtensions{.eps}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{letter}}
\ProcessOptions
\LoadClass[letterpaper]{letter} % we always use letter paper

\newcommand{\subjectname}{Assunto}
\newcommand{\@subject}{}
\newcommand{\subject}[1]{\renewcommand{\@subject}{\subjectname: #1}}

\newcommand{\section}{Section}
\newcommand{\thesection}{\@thesection}
\newboolean{logofound}
\IfFileExists{logos/UFCG-lateral-SemFundo.png}
    {\setboolean{logofound}{true}}
    {\setboolean{logofound}{false}}

\setlength{\textwidth}{6.875in}
\setlength{\textheight}{7.0in}
\setlength{\topskip}{0.0in}
\setlength{\footskip}{1.0in}
\setlength{\oddsidemargin}{-0.25in}
\setlength{\evensidemargin}{-0.25in}
\setlength{\topmargin}{-0.875in}

\DeclareFixedFont{\xcmrbn}{OT1}{cmr}{b}{n}{10}
\DeclareFixedFont{\xcmrmn}{OT1}{cmr}{m}{n}{10}
\DeclareFixedFont{\ixcmrmn}{OT1}{cmr}{m}{n}{9}

\newsavebox{\departmenthead}
\newsavebox{\departmentsmallhead}
\newsavebox{\departmentfoot}
\newsavebox{\emptyfoot}

\sbox{\departmenthead}{
    \begin{tabular*}{\textwidth}
                    {@{}l@{\extracolsep{0.0in}}|@{\extracolsep{0.125in}}l@{}}
    \parbox{3.625in}{\raggedright
        \ifthenelse{\boolean{logofound}}
           {\epsfig{file=/home/rivero/Dropbox/Workspace_Current/UFCG/logos/UFCG-lateral-SemFundo.png, height=1in}}
           {\parbox[t][1.0in][t]{2.0in}{\hfill}}
    } &
    \parbox[t][1.0in]{4.125in}{{\xcmrbn Unidade Acadêmica de Economia e Finanças\\
    		Centro de Humanidades\\ 
    	}
    	    {\ixcmrmn https://www.ch.ufcg.edu.br/}
        }\\
    \end{tabular*}
}


\sbox{\departmentsmallhead}{
	\begin{tabular*}{\textwidth}
		{@{}l@{\extracolsep{0.0in}}|@{\extracolsep{0.05in}}l@{}}
		\parbox{.8in}{\raggedright
			\ifthenelse{\boolean{logofound}}
			{\epsfig{file=logos/brasaoufcg.png, height=.6in}}
			{\parbox[t][.050in][t]{.150in}{\hfill}}
		} &
		\parbox[t][.050in]{4.25in}{{\xcmrbn Unidade Acadêmica de Economia e Finanças - Centro de Humanidades\\ 
			}
			{\ixcmrmn https://www.ch.ufcg.edu.br/}
		}\\
	\end{tabular*}
}



\savebox{\departmentfoot}[\textwidth][c]{\ixcmrmn
    ~Rua Aprígio Veloso, 882, Campina Grande - PB 
    ~CEP: 58429-900 - Brasil
    ~fone: (83) 2101.1215.
}

\savebox{\emptyfoot}[\textwidth][c]{\ixcmrmn
    \hspace*{\textwidth}
}

% header and footer should be placed only on the first page
\renewcommand{\ps@firstpage}{
    \setlength{\headheight}{1.375in}
    \setlength{\headsep}{1.0in}
    \renewcommand{\@oddhead}{\usebox{\departmenthead}}
    \renewcommand{\@oddfoot}{\usebox{\departmentfoot}}
    \renewcommand{\@evenhead}{}
    \renewcommand{\@evenfoot}{}
}

\renewcommand{\ps@empty}{
    \setlength{\headheight}{1.375in}
    \setlength{\headsep}{1in}
    \renewcommand{\@oddhead}{\usebox{\departmentsmallhead}}
    \renewcommand{\@oddfoot}{\usebox{\departmentfoot}}
    \renewcommand{\@evenhead}{\usebox{\departmentsmallhead}}
    \renewcommand{\@evenfoot}{\usebox{\departmentfoot}}
}

\providecommand{\@evenhead}{}
\providecommand{\@oddhead}{}
\providecommand{\@evenfoot}{}
\providecommand{\@oddfoot}{}

\pagestyle{empty}

% we add the subject command to the opening
\renewcommand{\opening}[1]{\thispagestyle{firstpage}%
    \ifx\@empty\fromaddress
        {\raggedleft\@date\par}%
    \else  % home address
        {\raggedleft
            \begin{tabular}{l@{}}\ignorespaces
            \fromaddress \\ *[1\parskip]%
            \@date 
            \end{tabular}\par
        }%
     \fi
     \vspace{1\parskip}%
     {\raggedright \toname \\ \toaddress \par}%
     \vspace{1\parskip}%
     \ifthenelse{\equal{\@subject}{}}{}{\@subject\par}
     \vspace{1\parskip}%
     #1\par\nobreak
}

% we push closing to the right
\renewcommand{\closing}[1]{\par\nobreak\vspace{\parskip}%
    \stopbreaks
    \noindent
    \hspace*{0.4\textwidth}\parbox{0.6\textwidth}{\raggedright
    \ignorespaces #1\\[4\medskipamount]%
    \ifx\@empty\fromsig
        \fromname
    \else \fromsig 
    \fi\strut}%
    \par
}

\renewcommand\section{\@startsection {section}{1}{\z@}%
	{-3.5ex \@plus -1ex \@minus -.2ex}%
	{2.3ex \@plus.2ex}%
	{\normalfont\Large\bfseries}}
\newcommand\subsection{\@startsection{subsection}{2}{\z@}%
	{-3.25ex\@plus -1ex \@minus -.2ex}%
	{1.5ex \@plus .2ex}%
	{\normalfont\large\bfseries}}
\renewcommand \thesection{\@arabic\c@section}


