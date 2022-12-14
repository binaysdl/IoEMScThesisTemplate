%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Masters/Doctoral Thesis 
% Class File
% Version 1.6 (27/8/17)
%
% This class was downloaded from:
% http://www.LaTeXTemplates.com
%
% Authors:
% Vel (vel@latextemplates.com)
% Johannes Böttcher
%
% Notes:
% 1) This class file defines the structure and layout of the template file (main.tex).
% 2) It has been written in such a way that under most circumstances you should not need
% to edit it; updating it to a newer version will be harder. If you do make changes, please change the name of
% the file and add comments to make your changes more visible.
%
% Class license:
% LPPL v1.3c (http://www.latex-project.org/lppl)
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% IoE_MSc_thesi
% Modified by:
% Binay Paudyal
% Modification is carried out in following aspects in this class file
% requirements of \ifbool{parskip} is shifted after all works of @starttoc to avoid waning in use of tocloft
% change colors within hyperref options as black for citecolor (from magneta), linkcolor(from b)lue, urlcolor (from mdtRed), filecolor(from blue)
% vspace in dedicatory page design to 0.5/textheight from 0.7/textheight; only for consistentlayout
% parbox in dedicatory page design to 0.8/textwidth from 0.4/textwidth; only for consistentlayout
% changed the parameters to geometry - original values are commented in the same location
% added option "headeron", if unspecified header is not displayed
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%----------------------------------------------------------------------------------------
%	CLASS DEFINITION AND PARAMETERS
%----------------------------------------------------------------------------------------

\NeedsTeXFormat{LaTeX2e}[1996/12/01]
\newcommand{\classname}{IoEMScThesis}
\ProvidesClass{\classname}[2017/08/27 v1.6 LaTeXTemplates.com]
\providecommand{\baseclass}{book}
\RequirePackage{etoolbox}
\RequirePackage{xparse}
\newbool{nolistspace}
\newbool{chapteroneline}
\newbool{listtoc}
\newbool{toctoc}
\newbool{parskip}
\newbool{hyperrefsupport}
\booltrue{hyperrefsupport}
\newbool{headeron}
\newbool{headsepline}
\newbool{consistentlayout}


\DeclareOption{nohyperref}{\boolfalse{hyperrefsupport}}
\DeclareOption{nolistspacing}{\booltrue{nolistspace}}
\DeclareOption{liststotoc}{\booltrue{listtoc}}
\DeclareOption{chapterinoneline}{\booltrue{chapteroneline}}
\DeclareOption{toctotoc}{\booltrue{toctoc}}
\DeclareOption{parskip}{\booltrue{parskip}}
\DeclareOption{headeron}{\booltrue{headeron}}
\DeclareOption{headsepline}{\booltrue{headsepline}}
\DeclareOption{consistentlayout}{\booltrue{consistentlayout}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\baseclass}}

\ProcessOptions\relax

\LoadClass{\baseclass}

%  Simple interface for the user  to customize the chapter titles 
%  The term simple was used in original class
    \ProvideDocumentCommand{\abovechapterskip}{}{\vspace*{20pt}}
    \ProvideDocumentCommand{\chapterbelowskip}{}{\vspace*{40pt}}
    \ProvideDocumentCommand{\chapterinbetweenskip}{}{\vspace*{20pt}}
    \ProvideDocumentCommand{\autodot}{}{}
    \ProvideDocumentCommand{\mdtChapapp}{}{}
    \ProvideDocumentCommand{\chapteralign}{}{\raggedright}
    \ProvideDocumentCommand{\chapterfont}{}{\Huge\bfseries}
    \ProvideDocumentCommand{\chapterprefixfont}{}{\LARGE\bfseries}
    \DeclareDocumentCommand{\@makechapterhead}{ m }{%
    	\abovechapterskip
    	{\parindent \z@ \chapteralign \normalfont
    		\ifnum \c@secnumdepth >\m@ne
    		\if@mainmatter
    		\ifbool{chapteroneline}{%
    			\chapterfont \mdtChapapp\thechapter\autodot\enspace
    		}{%
    			\chapterprefixfont \@chapapp\space \thechapter
    			\par\nobreak
    			\chapterinbetweenskip
    		}%
    		\fi
    		\fi
    		\interlinepenalty\@M%
    		\chapterfont #1\par\nobreak
    		\chapterbelowskip
    	}
    	\thispagestyle{\chapter@p@gestyle}
    }
    \def\@makeschapterhead#1{%
    	\abovechapterskip
    	{\parindent \z@ \chapteralign
    		\normalfont
    		\interlinepenalty\@M
    		\chapterfont  #1\par\nobreak
    		\chapterbelowskip
    	}
    	\thispagestyle{\chapter@p@gestyle}
    }
    
    
    % Addchap provides unnumbered chapters with an entry in the table of contents as well as an updated header
    \ProvideDocumentCommand{\addchap}{ s o m }{%
    	\chapter*{#3}%
    	\markboth{}{}%
    	\IfBooleanTF{#1}{%
    	}{%
    		\IfNoValueTF{#2}{%
    			\addchaptertocentry{#3}%
    			\markboth{\MakeMarkcase{#3}}{\MakeMarkcase{#3}}%
    		}{%
    			\addchaptertocentry{#2}%
    			\markboth{\MakeMarkcase{#2}}{\MakeMarkcase{#2}}%
    		}%
    	}%
    }%
    
    \ProvideDocumentCommand{\addsec}{ s o m }{%
    	\section*{#3}%
    	\markright{}%
    	\IfBooleanTF{#1}{%
    	}{%
    		\IfNoValueTF{#2}{%
    			\addcontentsline{toc}{section}{#3}%
    			\markright{\MakeMarkcase{#3}}%%
    		}{%
    			\addcontentsline{toc}{section}{#2}%
    			\markright{\MakeMarkcase{#2}}%
    		}%
    	}%
    }%

%----------------------------------------------------------------------------------------
%	CLASS OPTIONS
%----------------------------------------------------------------------------------------



    \ifbool{listtoc}{\RequirePackage{tocloft}% If the liststotoc option has been passed to the class, add the lists to the table of contents
    	\patchcmd{\listoftables}{\@starttoc{lot}}{%
    		\addchaptertocentry{\listtablename}\@starttoc{lot}%
    	}{}{}%
    	\patchcmd{\listoffigures}{\@starttoc{lof}}{%
    		\addchaptertocentry{\listfigurename}\@starttoc{lof}%
    	}{}{}%
    }
    
    \ifbool{toctoc}{\RequirePackage{tocloft}% If the toctotoc options has been passed to the class, add the table of contents to the table of contents
    	\patchcmd{\tableofcontents}{\@starttoc{toc}%
    }{%
    	\addchaptertocentry{\contentsname}\@starttoc{toc}}{}{}%
    }
    
    \patchcmd{\tableofcontents}{\MakeUppercase}{\MakeMarkcase}{}{}
    \patchcmd{\tableofcontents}{\MakeUppercase}{\MakeMarkcase}{}{}
    \patchcmd{\listoffigures}{\MakeUppercase}{\MakeMarkcase}{}{}
    \patchcmd{\listoffigures}{\MakeUppercase}{\MakeMarkcase}{}{}
    \patchcmd{\listoftables}{\MakeUppercase}{\MakeMarkcase}{}{}
    \patchcmd{\listoftables}{\MakeUppercase}{\MakeMarkcase}{}{}
    
    % If the option `nolistspacing' is given, the spacing in the different lists is reduced to single spacing. This option is only useful, if the spacing of the document has been changed to onehalfspacing or doublespacing.
    \ifbool{nolistspace}{\RequirePackage{tocloft}
    	\patchcmd{\listoffigures}{%
    		\@starttoc{lof}
    	}{%
    		\begingroup%
    		\singlespace\@starttoc{lof}\endgroup%
    	}{}{}%
    	\patchcmd{\listoftables}{%
    		\@starttoc{lot}
    	}{%
    		\begingroup%
    		\singlespace\@starttoc{lot}\endgroup%
    	}{}{}%
    	\patchcmd{\tableofcontents}{%
    		\@starttoc{toc}
    	}{%
    		\begingroup%
    		\singlespace\@starttoc{toc}\endgroup%
    	}{}{}%
    }{}
    
    \ifbool{parskip}{\RequirePackage{parskip}
        \setlength{\parskip}{1.2em}
    } % If the parskip option is passed to the class, require the parskip package 

%----------------------------------------------------------------------------------------
%	REQUIRED PACKAGES
%----------------------------------------------------------------------------------------

\RequirePackage{babel} % Required for automatically changing names of document elements to languages besides english
\RequirePackage{amsmath} % package for mathematical equations
\RequirePackage{scrbase} % Required for handling language-dependent names of sections/document elements
\RequirePackage{scrhack} % Loads fixes for various packages
\RequirePackage{setspace} % Required for changing line spacing
\RequirePackage{longtable} % Required for tables that span multiple pages (used in the symbols, abbreviations and physical constants pages)
\RequirePackage{siunitx} % Required for \SI commands
\RequirePackage{graphicx} % Required to include images
\graphicspath{{Figures/}{./}} % Specifies where to look for included images
\RequirePackage{booktabs} % Required for better table rules
\RequirePackage[labelfont=bf]{caption} % Required for customising the captions
%\captionsetup{justification=centerlast,font=small,labelfont=sc,margin=50pt}
\captionsetup{width=\textwidth}
\RequirePackage[labelfont={color=black}]{subcaption} %for subfigure caption setting

%----------------------------------------------------------------------------------------
%	DEFINE CUSTOM THESIS INFORMATION COMMANDS
%----------------------------------------------------------------------------------------
    
    \NewDocumentCommand{\thesistitle} { o m }{%
     \IfValueTF{#1}{\def\shorttitle{#1}}{\def\shorttitle{#2}}%
     \def\@title{#2}%
     \def\ttitle{#2}%
    }
    \DeclareDocumentCommand{\author}{m}{\newcommand{\authorname}{#1}\renewcommand{\@author}{#1}}
    \NewDocumentCommand{\supervisor}{m}{\newcommand{\supname}{#1}}
    \NewDocumentCommand{\examiner}{m}{\newcommand{\examname}{#1}}
    \NewDocumentCommand{\degree}{m}{\newcommand{\degreename}{#1}}
    \NewDocumentCommand{\addresses}{m}{\newcommand{\addressname}{#1}}
    \NewDocumentCommand{\university}{m}{\newcommand{\univname}{#1}}
    \NewDocumentCommand{\department}{m}{\newcommand{\deptname}{#1}}
    \NewDocumentCommand{\group}{m}{\newcommand{\groupname}{#1}}
    \NewDocumentCommand{\faculty}{m}{\newcommand{\facname}{#1}}
    \NewDocumentCommand{\subject}{m}{\newcommand{\subjectname}{#1}}
    \NewDocumentCommand{\keywords}{m}{\newcommand{\keywordnames}{#1}}
    
    \newcommand{\checktoopen}{% New command to move content to the next page which prints to the next odd page if twosided mode is active  
    	\if@openright\cleardoublepage\else\clearpage\fi
    	\ifdef{\phantomsection}{\phantomsection}{}% The \phantomsection command is necessary for hyperref to jump to the correct page
    }
    
    \NewDocumentCommand{\bhrule}{}{\typeout{--------------------}}
    \NewDocumentCommand{\tttypeout}{m}{\bhrule\typeout{\space #1}\bhrule}
    
    \newcommand{\HRule}{\rule{.9\linewidth}{.6pt}} % New command to make the lines in the title page
    \newcommand{\decoRule}{\rule{.8\textwidth}{.4pt}} % New command for a rule to be used under figures
    
    \setcounter{tocdepth}{2} % The depth to which the document sections are printed to the table of contents
    \ProvideDocumentCommand{\addchaptertocentry}{ m }{%
    	\addcontentsline{toc}{chapter}{#1}%
    }

%----------------------------------------------------------------------------------------
%	COLOURS
%----------------------------------------------------------------------------------------

    \usepackage[table]{xcolor} % Required for specifying custom colours
    
    \colorlet{mdtRed}{blue!50!black} %red!50!black

%----------------------------------------------------------------------------------------
%	MARGINS
%----------------------------------------------------------------------------------------

\RequirePackage{geometry}
\geometry{
% 	headheight=4ex,
% 	includehead,
	includefoot
}

% \geometry{
% 	paper=a4paper % Change to letterpaper for US letter
% 	,inner=2.5cm % Inner margin
% 	,outer=3.4cm % Outer margin
% 	,bindingoffset=10mm % Binding offset
% ,showframe=True
% 	,top=2.5cm % Top margin
% 	,bottom=2.5cm % Bottom margin
%     ,includefoot
% }

\raggedbottom

%----------------------------------------------------------------------------------------
%	PENALTIES
%----------------------------------------------------------------------------------------
    
    \doublehyphendemerits=10000 % No consecutive line hyphens
    \brokenpenalty=10000 % No broken words across columns/pages
    \widowpenalty=9999 % Almost no widows at bottom of page
    \clubpenalty=9999 % Almost no orphans at top of page
    \interfootnotelinepenalty=9999 % Almost never break footnotes

%----------------------------------------------------------------------------------------
%	HEADERS AND FOOTERS
%----------------------------------------------------------------------------------------

        \RequirePackage[markcase=used]{scrlayer-scrpage}
        
            \providepairofpagestyles{thesisSimple}{%
            \clearpairofpagestyles%
            \cfoot[\pagemark]{\pagemark}% Center footer
        }
        \pagestyle{thesisSimple}


    \providepairofpagestyles[thesisSimple]{thesis}{%
    	\automark*[section]{}%
    }
    \pagestyle{thesis}
    
    
    \ifbool{headsepline}{\KOMAoption{headsepline}{true}}{}
    \PreventPackageFromLoading[\ClassError{\classname}{Package `fancyhdr' is
    incompatible\MessageBreak with this class}{The pagestyles are defined 
    	using package `scrlayer-scrpage', please consult the\MessageBreak 
    KOMA-script documentation for details.}]{fancyhdr}
    
    
    \newcommand{\blank@p@gestyle}{empty}
    \newcommand{\chapter@p@gestyle}{plain}
    \NewDocumentCommand{\blankpagestyle}{ m }{%
    	\ClassWarning{\classname}{\string\blankpagestyle\space is
    	obsolete,\MessageBreak use \string\setblankpagestyle \space  instead}\renewcommand{\blank@p@gestyle}{}{#1}
    }
    \NewDocumentCommand{\setblankpagestyle}{ m }{\renewcommand{\blank@p@gestyle}{#1}}
    \NewDocumentCommand{\setchapterpagestyle}{ m }{\renewcommand{\chapter@p@gestyle}{#1}}
    
    
    
    \DeclareDocumentCommand\cleardoublepage{}{\clearpage\if@twoside \ifodd\c@page\else
    	\hbox{}
    	\thispagestyle{\blank@p@gestyle}
    	\newpage
    	\if@twocolumn\hbox{}\newpage\fi\fi\fi%
    }

%----------------------------------------------------------------------------------------
%	ABBREVIATIONS PAGE DESIGN
%----------------------------------------------------------------------------------------

    \newcommand{\abbrevname}{List of Abbreviations}
    \providecaptionname{english,british,american}{\abbrevname}{List of Abbreviations}
    \providecaptionname{ngerman,german,austrian,naustrian}{\abbrevname}{Abk\"urzungsverzeichnis}
    \NewDocumentEnvironment{abbreviations}{ m }{%
    	\ifbool{nolistspace}{\begingroup\singlespacing}{}
    	\ifbool{listtoc}{\addchap{\abbrevname}}{\addchap*{\abbrevname}}
    	\begin{longtable}{#1}
    	}{%
    	\end{longtable}
    	\addtocounter{table}{-1}% Don't count this table as one of the document tables
    	\ifbool{nolistspace}{\endgroup}{}
    }

%----------------------------------------------------------------------------------------
%	ABSTRACT PAGE DESIGN
%----------------------------------------------------------------------------------------
    
    \DeclareDocumentCommand{\abstractauthorfont}{}{}
    \DeclareDocumentCommand{\abstracttitlefont}{}{}
    \newcommand{\byname}{by}
    \newcommand{\abstractname}{Abstract}
    \providecaptionname{german,ngerman,austrian,naustrian}{\byname}{von}
    \providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\byname}{by}
    \ifbool{consistentlayout}{
    	\DeclareDocumentEnvironment{abstract}{ O{} }{%
    		\addchap*{\abstractname}%
    		{\chapteralign\normalsize\abstractauthorfont \authorname \par}% Author name
    		\vspace{\baselineskip}
    		{\chapteralign\parbox{.7\linewidth}{\chapteralign\normalsize\itshape\abstracttitlefont\@title}\par}% Thesis title
    		\bigskip\noindent\ignorespaces
    	}%
    	{}%end alt-abstract
    }{%
    	\DeclareDocumentEnvironment{abstract}{ O{\null\vfill} }{
    		\checktoopen
    		\tttypeout{\abstractname}
    		#1%added to be able to have abstract more than one page long
    		\thispagestyle{plain}
    		\begin{center}
    			{\normalsize \MakeUppercase{\univname} \par}% University name in capitals
    			\bigskip
    			{\huge\textit{\abstractname} \par}
    			\bigskip
    			{\normalsize \facname \par}% Faculty name
    			{\normalsize \deptname \par}% Department name
    			\bigskip
    			{\normalsize \degreename\par}% Degree name
    			\bigskip
    			{\normalsize\bfseries \@title \par}% Thesis title
    			\medskip
    			{\normalsize \byname{} \authorname \par}% Author name
    			\bigskip
    		\end{center}
    	}
    	{
    		\vfill\null
    	}
    }

    \DeclareDocumentEnvironment{extraAbstract}{ O{\null\vfill} }{
    	\checktoopen
    	\tttypeout{\abstractname}
    	#1%added to be able to have abstract more than one page long
    	\thispagestyle{empty}
    	\begin{center}
    		{\normalsize \MakeUppercase{\univname} \par}% University name in capitals
    		\bigskip
    		{\huge\textit{\abstractname} \par}
    		\bigskip
    		{\normalsize \facname \par}% Faculty name
    		{\normalsize \deptname \par}% Department name
    		\bigskip
    		{\normalsize \degreename\par}% Degree name
    		\bigskip
    		{\normalsize\bfseries \@title \par}% Thesis title
    		\medskip
    		{\normalsize \byname{} \authorname \par}% Author name
    		\bigskip
    	\end{center}
    }
    {
    	\vfill\null
    }

%----------------------------------------------------------------------------------------
%	ACKNOWLEDGEMENTS PAGE DESIGN
%----------------------------------------------------------------------------------------
    
    \usepackage{xcolor}
    \colorlet{mdtRed}{red!50!black}
    \newcommand{\acknowledgementname}{Acknowledgements}
    \providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish} {\acknowledgementname}{Acknowledgements} % Acknowledgement text for English countries
    \providecaptionname{german,ngerman,austrian,naustrian}{\acknowledgementname}{Danksagung} % Acknowledgement text for Germanic countries
    
    \ifbool{consistentlayout}{
    	\DeclareDocumentEnvironment{acknowledgements}{}{%
    		\tttypeout{\acknowledgementname}
    		\addchap*{\acknowledgementname}
    	}
    }
    {
    	\DeclareDocumentEnvironment{acknowledgements}{}{%
    		\checktoopen
    		\tttypeout{\acknowledgementname}
    		\thispagestyle{plain}
    		\begin{center}{\huge\textit{\acknowledgementname}\par}\end{center}
    	}
    	{
    		\vfil\vfil\null
    	}
    }

%----------------------------------------------------------------------------------------
%	DECLARATION PAGE DESIGN
%----------------------------------------------------------------------------------------
    
    \newcommand{\authorshipname}{Declaration of Authorship}
    \providecaptionname{american,australian,british,canadian,english,newzealand,UKenglish,USenglish}{\authorshipname}{Declaration of Authorship} % Declaration of Authorship text for English countries
    \providecaptionname{german,ngerman,austrian,naustrian}{\authorshipname}{Eidesstattliche Erkl\"arung} % Declaration of Authorship text for Germanic countries
    
    \ifbool{consistentlayout}{
    	\DeclareDocumentEnvironment{declaration}{}{
    		\addchap*{\authorshipname}
    		}{}%
    }{
    	\DeclareDocumentEnvironment{declaration}{}{
    		\checktoopen
    		\tttypeout{\authorshipname}
    		\thispagestyle{plain}
    		\null\vfil
    		{\noindent\huge\bfseries\authorshipname\par\vspace{10pt}}
    	}{}
    }

%----------------------------------------------------------------------------------------
%	DEDICATION PAGE DESIGN
%----------------------------------------------------------------------------------------
    
    \ifbool{consistentlayout}{
    	\DeclareDocumentCommand{\dedicatory}{
    		m O{\vspace*{.5\textheight} }  }{
    			\checktoopen\tttypeout{Dedicatory}
    			\markboth{}{}
    			#2
    			{\hfill\parbox{.8\textwidth}{\flushright#1\par}}
    		}
    }{
    	\newcommand\dedicatory[1]{
    		\checktoopen
    		\tttypeout{Dedicatory}
    		\null\vfil
    		\thispagestyle{plain}
    		\begin{center}{\Large\slshape #1}\end{center}
    		\vfil\null
    	}
    }


%====================================
%bold every beginning letter of sentence
%==================================

    \usepackage{expl3,xparse}
    
    % turn expl3 space on: `:' and `_' are letters now and spaces
    % are ignored. To insert a space use `~'.
    \ExplSyntaxOn
    % declare a new sequence variable:
    \seq_new:N \l_pouya_boldfirst_seq
    
    % the internal command:
    \cs_new:Npn \pouya_boldfirst:n #1
      {
        % split the input at every space and put the items in the sequence:
        \seq_set_split:Nnn \l_pouya_boldfirst_seq { ~ } { #1 }
        % map over every item of the sequence; each item is referred to with
        % `##1' as we're inside of a command definition:
        \seq_map_inline:Nn \l_pouya_boldfirst_seq
          {
            % use the head of the item in the argument of \textbf
            % and put in the tail of the item after it
            % followed by a space:
            \textbf { \tl_head:n { ##1 } } \tl_tail:n { ##1 } ~
          }
        % undo the last space:
        \unskip
      }
    
    % the document command:
    \NewDocumentCommand\BoldFirst{m}
      { \pouya_boldfirst:n { #1 } }
    
    % turn expl3 space off again:
    \ExplSyntaxOff
%=====================================

%----------------------------------------------------------------------------------------
%	PHYSICAL CONSTANTS PAGE DESIGN
%----------------------------------------------------------------------------------------
    
    \newcommand{\constantsname}{Physical Constants}
    \providecaptionname{english,british,american}{\constantsname}{Physical Constants}
    \providecaptionname{ngerman,german,austrian,naustrian}{\constantsname}{Physikalische Konstanten}
    
    \NewDocumentEnvironment{constants}{ m }{%
    	\ifbool{nolistspace}{\begingroup\singlespacing}{}
    	\ifbool{listtoc}{\addchap{\constantsname}}{\addchap*{\constantsname}}
    	\begin{longtable}{#1}
    	}{%
    	\end{longtable}
    	\addtocounter{table}{-1}% Don't count this table as one of the document tables
    	\ifbool{nolistspace}{\endgroup}{}
    }

%----------------------------------------------------------------------------------------
%	SYMBOLS PAGE DESIGN
%----------------------------------------------------------------------------------------
                            
    \newcommand{\symbolsname}{List of Symbols}
    \providecaptionname{english,british,american}{\symbolsname}{List of Symbols}
    \providecaptionname{ngerman,german,austrian,naustrian}{\symbolsname}{Symbolverzeichnis}
    
    \NewDocumentEnvironment{symbols}{ m }{%
    	\ifbool{nolistspace}{\begingroup\singlespacing}{}
    	\ifbool{listtoc}{\addchap{\symbolsname}}{\addchap*{\symbolsname}}
    	\begin{longtable}{#1}
    	}{%
    	\end{longtable}
    	\addtocounter{table}{-1}% Don't count this table as one of the document tables
    	\ifbool{nolistspace}{\endgroup}{}
    }
                                                
%----------------------------------------------------------------------------------------

    \ifbool{hyperrefsupport}{% If the nohyperref class option has not been specified
    \AtEndPreamble{\RequirePackage{hyperref}
    \hypersetup{pdfpagemode={UseOutlines},
    bookmarksopen=true,
    bookmarksopenlevel=0,
    hypertexnames=false,
    colorlinks=true,% Set to false to disable coloring links
    citecolor=black,% The color of citations
    linkcolor=black,% The color of references to document elements (sections, figures, etc)
    urlcolor=black,% The color of hyperlinks (URLs)
    filecolor=black,
    linktoc=page,
    pdfstartview={FitV},
    unicode,
    breaklinks=true,
    }
    
    \pdfstringdefDisableCommands{% If there is an explicit linebreak in a section heading (or anything printed to the pdf-bookmarks), it is replaced by a space
    	\let\\\space%
    }
    	}
    }{%nothing
    }

%----------------------------------------------------------------------------------------

\endinput
% lazyLizardTracer
